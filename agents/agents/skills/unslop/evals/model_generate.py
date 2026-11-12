#!/usr/bin/env python3
"""Text generation adapter for writing pipelines and paired product evaluations.

The CLI reads a prompt from stdin and writes only the final response. It supports
Codex, Claude CLI, OpenRouter, Gemini, and Cloudflare AI Gateway. Provider setup
and development commands are documented in evals/CORE-BENCHMARK.md.

Core evaluations use call_isolated: text-only Codex/Claude in empty workspaces,
or native Gemini/Cloudflare requests without tools. Native responses and usage
are retained for independent evidence validation. Legacy climb callers may use
the non-isolated CLI entrypoint; those calls are not core acceptance evidence.

Codex final text comes from --output-last-message, never the agent transcript.
Its process group is killed on timeout so a hung CLI cannot stall a climb.
"""

from __future__ import annotations

import argparse
from functools import lru_cache
import json
import os
import signal
import subprocess
import sys
import tempfile
import time
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import run_model_parity as parity  # noqa: E402

CODEX_DEFAULT_TIMEOUT = 180


def resolve_model(model: str) -> tuple[str, str]:
    """Resolve an explicit provider:model id; unqualified ids use Codex."""
    kind, separator, model_id = model.partition(":")
    if not separator:
        kind, model_id = "codex", model
    if kind not in {"codex", "claude-cli", "gemini", "cloudflare"} or not model_id.strip():
        raise ValueError("use a model id or codex:, claude-cli:, gemini:, or cloudflare:MODEL")
    if kind == "cloudflare" and model_id.startswith("dynamic/"):
        raise ValueError("evals require a specific model, not a dynamic gateway route")
    return kind, model_id


def provider_response(kind: str, payload: dict) -> tuple[str, dict]:
    """Extract text and usage from retained native evidence, also used by scoring."""
    if kind == "gemini":
        candidates = payload.get("candidates", [])
        if len(candidates) != 1 or candidates[0].get("finishReason") != "STOP":
            raise ValueError("Gemini response is missing, blocked, or truncated")
        parts = candidates[0].get("content", {}).get("parts", [])
        if any(set(part) - {"text", "thought", "thoughtSignature"} for part in parts):
            raise ValueError("Gemini response contains a non-text action")
        text = "".join(part.get("text", "") for part in parts if not part.get("thought"))
        native = payload.get("usageMetadata", {})
        usage = {
            "input_tokens": native.get("promptTokenCount"),
            "cached_input_tokens": native.get("cachedContentTokenCount", 0),
            "output_tokens": native.get("candidatesTokenCount"),
        }
        thoughts = native.get("thoughtsTokenCount", 0)
        if type(thoughts) is not int or thoughts < 0:
            raise ValueError("invalid Gemini reasoning-token count")
        if type(usage["output_tokens"]) is int:
            usage["output_tokens"] += thoughts
        if native.get("toolUsePromptTokenCount", 0):
            raise ValueError("Gemini response used tools")
    elif kind == "cloudflare":
        choices = payload.get("choices", [])
        if len(choices) != 1 or choices[0].get("finish_reason") != "stop":
            raise ValueError("Cloudflare response is missing, blocked, or truncated")
        message = choices[0].get("message", {})
        if message.get("tool_calls") or message.get("function_call") or message.get("refusal"):
            raise ValueError("Cloudflare response contains a tool call or refusal")
        text = message.get("content")
        native = payload.get("usage", {})
        usage = {
            "input_tokens": native.get("prompt_tokens"),
            "cached_input_tokens": native.get("prompt_tokens_details", {}).get("cached_tokens", 0),
            "output_tokens": native.get("completion_tokens"),
        }
    elif kind == "claude-cli":
        if (payload.get("type") != "result" or payload.get("subtype") != "success"
                or payload.get("is_error") or payload.get("num_turns") != 1):
            raise ValueError("Claude response did not complete successfully")
        text = payload.get("result")
        native = payload.get("usage", {})
        counts = [native.get("input_tokens"), native.get("cache_read_input_tokens", 0),
                  native.get("cache_creation_input_tokens", 0)]
        if any(type(value) is not int or value < 0 for value in counts):
            raise ValueError("Claude input-token evidence is incomplete")
        usage = {
            "input_tokens": sum(counts),
            "cached_input_tokens": counts[1],
            "output_tokens": native.get("output_tokens"),
        }
    else:
        raise ValueError("unsupported native response provider")
    if not isinstance(text, str) or not text.strip():
        raise ValueError("provider returned no usable text")
    if any(type(value) is not int or value < 0 for value in usage.values()):
        raise ValueError("provider token evidence is incomplete")
    if usage["cached_input_tokens"] > usage["input_tokens"]:
        raise ValueError("cached tokens exceed input tokens")
    return text, usage


def call_isolated(model, prompt, *, timeout=180, cwd=None, event_sink=None):
    """Call a text-only provider without project rules, skills, or model tools."""
    kind, model_id = resolve_model(model)
    if kind == "codex":
        return call_codex(model_id, prompt, timeout=timeout, cwd=cwd,
                          isolated=True, event_sink=event_sink)
    started = time.perf_counter()
    request_evidence = {}
    try:
        if kind == "gemini":
            key = os.environ.get("GEMINI_API_KEY") or os.environ.get("GOOGLE_API_KEY")
            if not key:
                return None, "GEMINI_API_KEY or GOOGLE_API_KEY is required"
            url = "https://generativelanguage.googleapis.com/v1beta/models/{}:generateContent".format(
                urllib.parse.quote(model_id, safe="")
            )
            config = {"maxOutputTokens": 16384}
            if model_id.startswith("gemini-3"):
                config["thinkingConfig"] = {"thinkingLevel": "LOW"}
            elif model_id.startswith("gemini-2.5"):
                config["thinkingConfig"] = {"thinkingBudget": 1024}
            request_evidence = {"generation_config": config}
            request = urllib.request.Request(url, data=json.dumps({
                "contents": [{"role": "user", "parts": [{"text": prompt}]}],
                "generationConfig": config,
            }).encode(), headers={"x-goog-api-key": key, "Content-Type": "application/json"})
            with urllib.request.urlopen(request, timeout=timeout) as response:
                payload = json.load(response)
        elif kind == "cloudflare":
            account = os.environ.get("CLOUDFLARE_ACCOUNT_ID") or os.environ.get("CF_ACCOUNT_ID")
            gateway = os.environ.get("CF_GATEWAY_ID")
            key = os.environ.get("CLOUDFLARE_API_TOKEN") or os.environ.get("CF_API_TOKEN")
            if not account or not gateway or not key:
                return None, "CLOUDFLARE_ACCOUNT_ID, CF_GATEWAY_ID, and CLOUDFLARE_API_TOKEN are required"
            url = "https://api.cloudflare.com/client/v4/accounts/{}/ai/v1/chat/completions".format(
                urllib.parse.quote(account, safe="")
            )
            request = urllib.request.Request(url, data=json.dumps({
                "model": model_id, "messages": [{"role": "user", "content": prompt}],
                "stream": False, "max_tokens": 16384,
            }).encode(), headers={
                "Authorization": "Bearer " + key, "Content-Type": "application/json",
                "cf-aig-gateway-id": gateway, "cf-aig-skip-cache": "true",
            })
            with urllib.request.urlopen(request, timeout=timeout) as response:
                cache_status = response.headers.get("cf-aig-cache-status", "")
                payload = json.load(response)
                request_evidence = {"gateway_id": gateway, "cache_bypassed": True,
                                    "cache_status": cache_status,
                                    "log_id": response.headers.get("cf-aig-log-id", "")}
        else:
            if cwd is None:
                raise ValueError("isolated Claude calls require an empty working directory")
            command = [
                "claude", "-p", "--model", model_id, "--safe-mode",
                "--tools", "", "--disable-slash-commands", "--strict-mcp-config",
                "--mcp-config", '{"mcpServers":{}}', "--no-session-persistence",
                "--output-format", "json", "--system-prompt",
                "Follow the supplied writing task. Return only the requested response.",
            ]
            proc = subprocess.run(command, input=prompt, cwd=cwd, capture_output=True,
                                  text=True, timeout=timeout)
            if proc.returncode:
                return None, "isolated Claude call failed (exit {})".format(proc.returncode)
            payload = json.loads(proc.stdout)
        if event_sink is not None:
            event_sink.append(json.dumps({
                "type": "unslop.provider_response", "provider": kind,
                "model": model, "payload": payload, **request_evidence,
            }) + "\n")
        if kind == "cloudflare":
            if request_evidence["cache_status"].upper() == "HIT":
                return None, "Cloudflare returned cached evaluation output"
            if payload.get("model") != model_id:
                return None, "Cloudflare response model differs from requested model"
        try:
            text, usage = provider_response(kind, payload)
        except ValueError as exc:
            return None, str(exc)
        if event_sink is not None:
            event_sink.append(json.dumps({
                "type": "unslop.invocation_metrics", "model": model,
                "elapsed_seconds": round(time.perf_counter() - started, 6), **usage,
            }) + "\n")
        return text, None
    except urllib.error.HTTPError as exc:
        return None, "{} HTTP error {}".format(kind, exc.code)
    except (OSError, ValueError, KeyError, TypeError, AttributeError, subprocess.TimeoutExpired) as exc:
        # Provider errors can contain request details. Keep credentials and prompts
        # out of terminal errors; successful native evidence stays in run artifacts.
        return None, "{} call failed: {}".format(kind, type(exc).__name__)


@lru_cache(maxsize=1)
def _disabled_skill_config() -> str:
    """Return a Codex override that disables installed skill metadata.

    Isolated eval calls receive the complete shipping contract explicitly in
    their prompt. Loading unrelated personal and plugin skill descriptions adds
    thousands of input tokens and can influence routing, so enumerate and
    disable them for the model invocation itself.
    """
    user_root = Path.home()
    paths: set[str] = set()
    for root in (user_root / ".codex" / "skills", user_root / ".agents" / "skills"):
        for candidate in root.glob("*/SKILL.md") if root.is_dir() else ():
            if candidate.is_file():
                paths.add(str(candidate.resolve()))
    plugin_cache = user_root / ".codex" / "plugins" / "cache"
    if plugin_cache.is_dir():
        # Plugin packages put skills below a literal `skills/` directory, at a
        # small number of version/package nesting depths. Fixed-depth globs
        # avoid walking node_modules, assets, and other irrelevant subtrees.
        for pattern in (
            "*/skills/*/SKILL.md",
            "*/*/skills/*/SKILL.md",
            "*/*/*/skills/*/SKILL.md",
            "*/*/*/*/skills/*/SKILL.md",
        ):
            for candidate in plugin_cache.glob(pattern):
                if candidate.is_file():
                    paths.add(str(candidate.resolve()))
    entries = ",".join(
        "{path=" + json.dumps(path) + ",enabled=false}"
        for path in sorted(paths)
    )
    return f"skills.config=[{entries}]"


def _codex_usage(raw_events: str) -> dict[str, int]:
    """Extract the largest cumulative token counters from Codex JSONL."""
    counters = {"input_tokens": 0, "cached_input_tokens": 0, "output_tokens": 0}
    aliases = {
        "input_tokens": "input_tokens",
        "cached_input_tokens": "cached_input_tokens",
        "cached_tokens": "cached_input_tokens",
        "output_tokens": "output_tokens",
    }

    def visit(value) -> None:
        if isinstance(value, dict):
            for key, item in value.items():
                target = aliases.get(key)
                if target and isinstance(item, int) and item >= 0:
                    counters[target] = max(counters[target], item)
                visit(item)
        elif isinstance(value, list):
            for item in value:
                visit(item)

    for line in raw_events.splitlines():
        try:
            visit(json.loads(line))
        except (TypeError, json.JSONDecodeError):
            continue
    return counters


def call_codex(
    model_id,
    prompt,
    timeout=CODEX_DEFAULT_TIMEOUT,
    *,
    cwd=None,
    isolated=False,
    event_sink=None,
):
    """Call the local Codex CLI (``codex exec``) and return its final message.

    Uses ``--output-last-message FILE`` to get the agent's clean prose turn
    instead of parsing the interleaved tool/hook transcript on stdout.
    ``--sandbox read-only --ephemeral --skip-git-repo-check`` keep the call a
    pure text-generation request: no repo writes, no persisted session, no
    git-repo requirement. A hard timeout (own process group, SIGKILL on
    expiry) turns a silent hang into an honest (None, error) result instead of
    blocking the climb loop forever.
    """
    fd, out_path = tempfile.mkstemp(prefix="codex_out_", suffix=".txt")
    os.close(fd)
    started = time.perf_counter()
    cmd = ["codex", "exec", "--skip-git-repo-check", "--sandbox", "read-only",
           "--ephemeral", "-o", out_path]
    if isolated:
        if cwd is None:
            raise ValueError("isolated Codex calls require an explicit empty working directory")
        cmd += [
            "--ignore-user-config", "--ignore-rules", "--json", "-C", str(cwd),
            "-c", _disabled_skill_config(),
        ]
    if model_id:
        cmd += ["-m", model_id]
    cmd.append("-")  # read the prompt from stdin
    try:
        try:
            proc = subprocess.Popen(
                cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE,
                stderr=subprocess.PIPE, text=True, start_new_session=True,
            )
        except (FileNotFoundError, OSError) as e:
            return None, f"codex cli error: {e}"
        try:
            stdout, stderr = proc.communicate(input=prompt, timeout=timeout)
            if event_sink is not None:
                event_sink.append(stdout)
                metric = {
                    "type": "unslop.invocation_metrics",
                    "model": model_id,
                    "elapsed_seconds": round(time.perf_counter() - started, 6),
                    **_codex_usage(stdout),
                }
                event_sink.append(json.dumps(metric, separators=(",", ":")) + "\n")
        except subprocess.TimeoutExpired:
            try:
                os.killpg(os.getpgid(proc.pid), signal.SIGKILL)
            except (ProcessLookupError, OSError):
                pass
            try:
                proc.wait(timeout=5)
            except subprocess.TimeoutExpired:
                pass
            return None, f"codex exec timed out after {timeout}s (treated as a hang; round failed)"
        if proc.returncode != 0:
            return None, f"codex exec exit {proc.returncode}: {stderr.strip()[:300]}"
        text = Path(out_path).read_text(errors="replace") if Path(out_path).exists() else ""
        if not text.strip():
            return None, "codex exec exited 0 but --output-last-message was empty"
        return text, None
    finally:
        try:
            os.unlink(out_path)
        except OSError:
            pass


def main(argv):
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--kind", required=True, choices=["claude-cli", "openrouter", "codex", "gemini", "cloudflare"])
    p.add_argument("--model", required=True)
    p.add_argument("--timeout", type=int, default=CODEX_DEFAULT_TIMEOUT,
                   help="Codex, Gemini, and Cloudflare request timeout in seconds (default 180)")
    args = p.parse_args(argv)

    prompt = sys.stdin.read()
    if args.kind == "claude-cli":
        text, err = parity.call_claude_cli(args.model, prompt)
    elif args.kind == "openrouter":
        text, err = parity.call_openrouter(args.model, prompt)
    elif args.kind in {"gemini", "cloudflare"}:
        text, err = call_isolated(args.kind + ":" + args.model, prompt, timeout=args.timeout)
    else:
        text, err = call_codex(args.model, prompt, timeout=args.timeout)

    if err or text is None:
        sys.stderr.write(f"model_generate ({args.kind}/{args.model}) failed: {err}\n")
        return 1
    sys.stdout.write(text)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
