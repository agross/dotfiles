# Core Product Benchmark

This benchmark answers one question:

> On unfamiliar AI-generated or mixed prose, does UNSLOP find the genuine
> writing problems, repair them, and leave facts and good prose intact?

It does not award product-quality credit for test count, routing, caching,
schema validation, voice imitation, or contributor tooling. Those remain
important engineering or feature checks, but they have separate scoreboards.

## Scoreboards

| Scoreboard | Evidence | Headline use |
|---|---|---|
| Core product | `core-benchmark.json`, raw run evidence, `core_metrics.py` | Whether UNSLOP works |
| Voice | teach/mimic fixtures and live mimic protocol | Whether UNSLOP sounds like a taught author |
| Engineering | canonical adversarial suite and harness checks | Whether the repository is safe to change |

The core scoreboard always reports these outcomes separately:

- **Detection precision:** legitimate findings / all findings.
- **Detection recall:** found gold issues / all gold issues.
- **Repair success:** gold issues actually improved / all gold issues.
- **Preservation:** required facts, qualifications, and relationships retained.
- **Damage rate:** already-good protected spans harmed / all protected spans.
- **Net improvement:** issue-bearing documents independently judged better than
  their source. Clean cases do not dilute this denominator.
- **Clean no-op rate:** clean documents returned byte-for-byte unchanged. This
  is the strongest check that an editor leaves already-good prose alone.

The report also shows the same metrics for Luna without UNSLOP and the
with-skill-minus-without-skill delta. A positive aggregate does not excuse a
damaging case; per-case failures remain visible.

## Case Contract

Public cases live in `evals/core-benchmark.json` and have one immutable source
document and a split:

- `tune` is visible during development.
- `holdout` is for reporting, not prompt adjustment.
- `holdback` is not committed with the public corpus. A separately generated
  local manifest lives under the ignored `evals/runs/` tree; the repository
  stores only its hash and counts. Running it requires
  `UNSLOP_CONFIRM_HOLDBACK=1`.

Gold annotations identify exact issue spans, protected good spans, and
preservation constraints. Generation receives the source, genre, and register,
but never the gold annotations. The independent adjudication step receives the
gold only after both rewrites exist.

Every selected case must produce both arms:

1. `with_skill`: Luna receives the pinned UNSLOP rewrite contract.
2. `without_skill`: the same Luna model receives a neutral diagnose-and-rewrite
   request without reading local or globally installed skill files.

The rewrite judge is the independent `gpt-5.6-sol` orchestrator model. It sees
randomized candidate labels and rewrites only—not either arm's findings or
treatment identity.

The runner records one canonical copy per case of the prompt hashes, raw
generation, raw adjudication, parsed findings, validation battery, and final
rewrites. Per-arm rows carry hashes instead of duplicating that evidence.
Missing, malformed, or timed-out runs fail the evaluation; they do not
disappear from denominators.

## Span Matching

Predicted findings use offsets into the original source. A finding matches one
gold issue at 0.5 or greater intersection-over-union. Category labels are
reported but do not control identity because two editors can legitimately name
the same problem differently. Matching is one-to-one. The runner requires an
exact source quote and computes missing or wrong offsets only when that quote
occurs once, for both findings and read-only evidence. Models supply offsets
only to disambiguate repeated quotes. The source audit returns findings only;
the runner attaches the immutable source without generating another copy.
A grammatical repair may carry
the immediately following word into a finding; deleting a phrase may remove its
trailing inline whitespace. Other words and indentation remain protected.
Paragraph deletion may also remove its own separators. Duplicate, malformed,
ambiguous, and shotgun findings count as failures.
Coverage uses exact protected text between findings and rejects new sentence
boundaries inside replacements. There is no second diff-based coverage oracle.

For compatibility, JSON recall and repair ratios use 1 when there are no gold
issues. That empty denominator is not success evidence. In human reports, mark
those rates inapplicable and report false findings and clean exact no-ops.

## Acceptance

Do not set release thresholds from the tune split or from observed public
outputs. Freeze the public corpus, runner, scorer, scanner, shipping contract,
and release thresholds before the first public holdout run. Final evidence must
include:

- an uncached Luna run for both arms;
- every raw artifact and prompt/model hash;
- split- and case-level metrics;
- a paired comparison against Luna without UNSLOP;
- an independent adversarial review of annotations, runner behavior, and
  claimed conclusions.

Until those artifacts exist, scanner coverage and the legacy behavioral pass
rate are regression evidence, not proof that the product improves writing.

## Current public result

The frozen v9 public holdout failed the release gate. UNSLOP substantially
improved Luna's detection recall and repair rate, but it also introduced false
positives and one damaging edit, missed substantive semantic and safety issues,
and safely improved none of the three dirty documents end to end. The sealed
holdback remains unopened. See `CORE-RESULTS.md` for metrics and failure modes.

## Cross-family development

Use the same runner and scoring contract for each provider. `--development`
permits an explicit generator and independent judge on **tune only**. Release
acceptance still requires its frozen Luna/Sol pair and rejects development
artifacts, including development runs that happen to use Luna.

```bash
python3 evals/core_runner.py evals/core-benchmark.json --split tune \
  --development --model gemini:gemini-3.5-flash --judge-model gpt-5.6-sol \
  --workers 2 --out evals/runs/families/gemini-dirty.json
python3 evals/core_metrics.py evals/core-benchmark.json \
  evals/runs/families/gemini-dirty.json --split tune --arm with_skill \
  --out evals/runs/families/gemini-dirty-metrics.json
```

Repeat with `evals/core-benchmark-v2.json` and a different output path for the
seven clean tune documents. The original corpus contributes two dirty tune
cases with 20 issues. Neither slice alone measures editing quality: dirty cases
expose misses and failed repairs; clean cases expose unnecessary edits. These
small public development sets cannot establish generalization.

| Model selector | Authentication and execution |
|---|---|
| `gpt-5.6-luna` or `codex:MODEL` | Authenticated Codex CLI in an isolated empty directory. |
| `claude-cli:MODEL` | Authenticated Claude CLI with tools, skills, and MCP disabled. |
| `gemini:MODEL` | `GEMINI_API_KEY` or `GOOGLE_API_KEY`; native text-only API. |
| `cloudflare:MODEL` | `CLOUDFLARE_ACCOUNT_ID`, `CF_GATEWAY_ID`, `CLOUDFLARE_API_TOKEN`; gateway-routed text-only API. |

Supply credentials locally through environment variables; never put them in
model files, prompts, or reports. For open models through Cloudflare:

```bash
python3 evals/core_runner.py evals/core-benchmark.json --split tune \
  --development --model cloudflare:@cf/qwen/qwen3-30b-a3b-fp8 \
  --judge-model gpt-5.6-sol --workers 2 \
  --out evals/runs/families/qwen-dirty.json
```

Cloudflare uses `/accounts/{account_id}/ai/v1/chat/completions` with an explicit
`cf-aig-gateway-id` and `cf-aig-skip-cache: true`. Select a model available to
that account; dynamic routing and fallback model substitutions are rejected.
The token needs Workers AI access. See the current
[Cloudflare REST API contract](https://developers.cloudflare.com/ai-gateway/usage/rest-api/).
The adapter does not create gateways or buy provider credits.

Gemini 3 uses low thinking; Gemini 2.5 uses a 1,024-token thinking budget.
Both retain a 16,384-token output ceiling. The initial Gemini trial exhausted
that ceiling with reasoning before completing its JSON response. Native
[thinking configuration and token usage](https://ai.google.dev/api/generate-content#ThinkingConfig)
are retained in the evidence, including reasoning tokens. Other models retain
their provider defaults. Compare actual token and time costs alongside quality;
equal token ceilings do not imply equal compute.

Each provider's native response and token counts accompany the final text.
The scorer checks those counts, completion status, model identity, and absence
of tool use. A failed live call writes a `.failure.json` beside the requested
output. Preserve failed attempts and their reasons; a successful retry does not
erase them. `--case` is diagnostic only: the scorer requires the complete split.

## Evaluation discipline

Before a model-family recommendation:

1. Freeze the contract, model IDs, inference settings, corpus, and scoring
   rules. Run paired raw-model and model-plus-skill arms on the same inputs.
   Keep development on tune; keep holdout and holdback closed during edits.
2. Inspect every failed case before changing a prompt. Prefer a shared contract
   correction to provider-specific prose rules. Repeat the frozen tune matrix
   at least three times to expose stochastic failures; retain all attempts.
3. Report each family and genre separately: detection counts, repairs,
   preservation, clean exact no-ops, completion failures, tokens, and latency.
   Show case-level deltas. Do not pool families to hide a regression or use
   phrase absence as proof that prose improved.
4. Use blinded, randomized candidate order and a different generator model as
   judge. The runner enforces different model IDs, not independent families.
   For finalists, repeat adjudication with a judge from another family and
   inspect disagreements. A Sol-only comparison can favor OpenAI style.
5. Calibrate subjective judgments against human-labeled passes and failures,
   using separate calibration and validation examples. Report sensitivity,
   specificity, and disagreements for repair and preservation separately.
   Without those labels, describe the scores as model judgments, not human
   preference. Report case-level uncertainty; repeated calls are not new cases.
6. Freeze release criteria before new held-out evaluation. Require preservation
   and clean-text performance as well as repair gains. Do not claim removal of
   every AI tell: there is no exhaustive tell list or reliable authorship test.
   The product claim is contextual writing improvement with preserved meaning.

This follows the task-specific comparisons, human calibration, and judge-bias
controls in [OpenAI's evaluation guidance](https://developers.openai.com/api/docs/guides/evaluation-best-practices/)
and [Anthropic's evaluation guidance](https://platform.claude.com/docs/en/test-and-evaluate/develop-tests).
