# Core Product Results

## Release status: BETA; COMPARATIVE CLAIM NOT YET REVALIDATED

Treat the current implementation as an experimental beta. Its bounded
deterministic suite is green, but the cross-family trials below do not
revalidate its general writing-quality claim.
Earlier paired Luna runs predate fixes to raw-span scoring and per-case
efficiency enforcement. The newest independently annotated corpus missed its
frozen composition floor before either arm ran. The latest valid public product result
therefore remains the v9 no-ship below.

The failed V7 corpus was a benchmark-construction failure, not a product
failure. Its holdout contained five issue spans across two dirty documents and
four clean documents; the frozen floor was six issues across three dirty and
three clean documents. V7 was spent before a product call, and neither arm ran.
It provides no evidence that the current pipeline is better, worse, or equal to
raw Luna.

## Speed and coverage pass — 2026-09-07

The source audit now returns findings only, with exact quotes instead of
mandatory character arithmetic. Python attaches the original source and resolves
unique quotes; ambiguous overlapping quotes are rejected too. The generation
format still requires the complete rewrite. Duplicate audit instructions and
unused diff diagnostics were removed. Clean rewrites explicitly stop after
diagnosis. The shared contract now calls out paraphrased scaffolding by function.

The new `SKILL-PARAPHRASE-01` tune case has zero scanner hits. Both behavioral
arms removed the empty ceremony, identity claim, and closing question while
copying the informative question-and-answer paragraph exactly. This adds
regression coverage, not evidence of lift over the baseline.

Final native-evidence-verified tune results use an independent blinded Sol judge:

| Outcome | Gemini 3.5 Flash + skill / raw | Luna + skill / raw |
|---|---:|---:|
| Dirty issues repaired | 13/20 / 13/20 | 15/20 / 14/20 |
| Dirty factual constraints retained | 7/7 / 7/7 | 7/7 / 7/7 |
| Dirty protected spans retained | 20/20 / 20/20 | 20/20 / 20/20 |
| Clean exact no-ops | 7/7 / 4/7 | Unscored: annotation failure |
| Clean factual constraints retained | 39/39 / 37/39 | Unscored |

Gemini repaired 9/11 marketing and 4/9 technical issues; raw repaired 7/11 and
6/9. Luna repaired 9/11 and 6/9; raw repaired 7/11 and 7/9. Neither final dirty
trial used a fallback. Luna's clean trial failed because read-only evidence
overlapped a writable finding; the failure retains the native response.
The preceding lean trial repaired 15/20 with Gemini versus 9/20 raw, but Luna
fell back on both documents (0/20 versus 10/20 raw). This variability rules out
claiming a consistent cross-family quality improvement.

Across the same two dirty tune cases, Gemini's summed model-call latency was
178 seconds before this pass, 147 in the first lean trial, and 130 in the final
trial. Total output tokens, including reasoning, were 36,749, 23,428, and
21,550 respectively; each paired trial used nine model calls including judging.
These are observed call-time sums, not wall-clock guarantees or a controlled
latency study. In a separate three-repeat local check on 5,304 characters,
removing the unused diff pass reduced median coverage-check time from 249 ms
to 0.1 ms without changing the verdict.

The full behavioral tune run completed all 22 generations without timeouts and
finished in 492 seconds, but acceptance failed on two with-skill cases:
`SKILL-CORE-DIRTY-01` retained vague "actionable" praise; `SKILL-MACRO-01` failed
the judge's rhythm-variation requirement after removing the scaffold and coda.
The latter requirement is in tension with preserving otherwise natural
sentences. Neither assertion was weakened. The other nine with-skill cases
passed, including the new paraphrase case.

The full offline/integrity suite and lint passed. Brittle prompt-substring
checks were replaced with observable annotation checks; existing behavioral
coverage remains. The deterministic budget is now 74 examples / 378 predicates,
with no new test files. Trials and implementation snapshots are retained locally
in `evals/runs/families/lean/` and `lean-unique/`; the first directory precedes
the conservative overlapping-quote fix. Behavioral artifacts are archived in
`evals/runs/families/lean-unique/behavioral/`. No holdout or holdback was opened.
Human calibration and live Cloudflare/Claude evidence are still missing.

## Earlier cross-family development — 2026-09-07

Provider support now includes Codex, Claude CLI, Gemini, and explicit open models
through Cloudflare AI Gateway. This is development support, not a new release
claim. The shared writing contract remains below 650 words. Scored trials below
use public tune cases and an independent, blinded Sol judge; no holdout or
holdback was opened. Human judge calibration has not been performed.

The Gemini 3.5 Flash trial before the speed pass improved repair while preserving clean text:

| Outcome | Gemini + UNSLOP | Plain Gemini |
|---|---:|---:|
| Dirty-document detection | 9 TP, 3 FP, 11 FN | 3 TP, 5 FP, 17 FN |
| Annotated issues repaired | 11/20 | 6/20 |
| Dirty-document factual constraints preserved | 7/7 | 7/7 |
| Clean documents left exact | 7/7 | 3/7 |
| Clean-document factual constraints preserved | 39/39 | 37/39 |

The marketing case repaired 6/11 issues and the technical case 5/9. Neither
fell back to the source, but nine issues still need repair. These counts do not
support an "all AI tells removed" claim.

The Luna dirty trial before the speed pass failed because a finding added a comma absent from
the source quote; it is unscored. Its current clean trial left 4/7 documents
exact, versus 3/7 for raw Luna, and made three false findings. Both arms
preserved all 39 factual constraints. It over-edited a subscription heading,
a stated social benefit, and a conference recap transition.
The preceding Luna trial fell back on both
documents: 0/20 repairs versus 16/20 for its raw arm. A Gemini 3.8 Flash trial
also failed, because a finding crossed a sentence boundary. Those failures are
retained; they do not disappear behind the successful Gemini 3.5 result.

Error analysis led to four changes: the source audit now reads the shared
findings contract; Gemini reasoning is bounded; required findings survive a
one-word grammatical extension; and phrase deletion can consume its trailing
inline space. The old whitespace gate rejected otherwise authorized deletions.
Unique exact quotes now also repair read-only evidence offsets. Ambiguous or
inexact quotes still fail. These corrections do not establish a model ranking.

Current predictions, native responses, failures, and verified metrics are
retained locally under `evals/runs/families/current/`. Earlier trials remain in
`baseline/`, `retry/`, `revised/`, and `final/`; the last two include implementation
snapshots for their earlier hashes. These ignored artifacts are development
evidence, not replacements for frozen release inputs. The seven clean and two
dirty cases are too few for generalization. Repeated frozen trials and human
calibration remain required by the
[comparison protocol](CORE-BENCHMARK.md#evaluation-discipline).

Cloudflare's request shape, explicit gateway/model routing, cache bypass, and
native evidence verification passed offline contract checks. Live open-model
runs still need a gateway ID and authorized token configured locally. The
available Wrangler login could list Workers AI models but could not list
gateways. Claude CLI is installed but unauthenticated. Neither provider has
live writing-quality evidence from this work.

The legacy `check.py --behavioral tune` run completed 15/20 calls and failed on
five 180-second timeouts: both macro-rewrite arms, the with-skill relational
audit, and both dirty-memo arms. It did not reach judging and is not a passing
behavioral result. The full deterministic/integrity gate and lint passed;
the executable budget is 74 examples and 400 outcome predicates. No new test
files were added. The generic skill-creator validator rejects the preexisting
`user-invocable` and `argument-hint` frontmatter keys; those interface fields
were preserved.

## Latest valid public result: NO-SHIP (v9)

The first frozen public v9 holdout does not establish that UNSLOP safely
improves unfamiliar AI-generated or mixed prose. It does show that the UNSLOP
contract helps Luna find and repair substantially more annotated issues than a
neutral editing prompt. That gain is not enough: the treatment also produced
more false positives, caused one real damaging edit, and left every dirty
document short of safe whole-document improvement.

The sealed holdback was not opened after this public failure.

## Frozen public result

Both generation arms used `gpt-5.6-luna`. The blinded adjudicator was
`gpt-5.6-sol`. The holdout contained three dirty documents and one clean
document, with 31 annotated issues and nine protected spans.

| Metric | Luna + UNSLOP | Plain Luna | Required |
|---|---:|---:|---:|
| Detection precision | 81.25% | 83.33% | at least 90% |
| Detection recall | 83.87% | 32.26% | at least 90% |
| Repair success | 87.10% | 58.06% | at least 90% |
| Preservation | 100% | 100% | 100% |
| Damage rate | 11.11% | 0% | 0% |
| Dirty documents safely improved | 0 of 3 | 0 of 3 | at least 80% |
| Clean documents left byte-exact | 1 of 1 | 1 of 1 | 100% |

UNSLOP won the paired comparison on all three dirty documents and tied the
clean document, but no dirty document cleared the absolute safety bar. Paired
wins therefore do not override the no-ship decision.

## What failed

The treatment made 26 true-positive findings, six false-positive findings, and
missed five gold issues. It repaired 27 of 31 annotated issues and preserved
all seven required factual or relational constraints. Its single protected-span
failure weakened a literal energy description from "harnessed energy" to
"received light."

The independent adversarial review found three recurring product failures:

- It treated accurate reports of another source's mistake or claim as errors
  in the current authorial voice.
- It treated literal technical language as AI-style metaphor and edited it
  unnecessarily.
- It missed consequential semantic problems, including unsupported decisions,
  unsafe recommendations, and an unsupported stability conclusion.

Two unsafe decisions remained in the conservation case. An unsafe repeat
recommendation remained in the rover case, alongside the damaging literal
energy edit. The ceramics case retained an unsupported stability conclusion.

## Evidence integrity

Thresholds were frozen before the v9 model run and were not changed afterward.
The manifest, shipping contract, runner, scorer, and scanner hashes are pinned
in `core-thresholds.json`. After model outputs existed, scorer input
normalization was corrected and an initially proposed policy-text heuristic was
rejected by independent review. The final scorer permits deterministic
protected-span overrides only when the manifest explicitly declares
`enforcement: exact_span`; v9 used no such override. The resulting v17 score is
reproducible but is not represented as a pristine pre-frozen trial.

Raw local evidence contains prompt hashes, model events, parsed responses, and
the independent judgments under `evals/runs/core/holdout-v17/`. That directory
is intentionally ignored because the prediction artifact is large and may
contain provider event envelopes. The stable public inputs and frozen hashes
are committed instead.

## Engineering performance

On the measured development machine, `python3 evals/check.py --full` completed
in about three seconds with no expected or unexpected failures. The deterministic
surface is explicitly capped at 80 executable examples and 400 expanded outcome
predicates; the current counts are printed by
`python3 evals/check_complexity_budget.py`. The scanner contract separately
reports 36/36 structural patterns, 16/16 literal triggers, and 20/20 protected
categories.

## Next valid experiment

Do not tune directly against v9 and continue calling it a public holdout. Use
its failures as development evidence, improve the general attribution,
literal-language, and semantic-risk logic, and then evaluate once on a newly
authored, independently annotated public corpus. Open the sealed holdback only
after that new public corpus passes the frozen absolute gates.
