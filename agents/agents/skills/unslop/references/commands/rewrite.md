# /unslop rewrite

The default command. Read `references/core-contract.md`; it is authoritative.
Use two passes: diagnose, then repair confirmed findings and validate.

Input arrives as an argument, a file path, or stdin. Set `$INPUT` to the source
and `$OUTPUT` to your rewrite.

## Pass 1 — diagnose

1. Read the source before scanner output. Identify concrete defects and the
   information each sentence contributes. Then extract the facts and constraints:
   ```bash
   python3 scripts/extract_constraints.py <<< "$INPUT"
   ```
2. Scan the source for candidates the reading may have missed:
   ```bash
   python3 scripts/banned_phrase_scan.py <<< "$INPUT"
   python3 scripts/structure_scan.py <<< "$INPUT"
   python3 scripts/silhouette_scan.py <<< "$INPUT"
   python3 scripts/readability_metrics.py <<< "$INPUT"
   ```
   Pass `--genre docs` or `--genre social` only when the input truly belongs to
   that genre. Add `banned_phrase_scan.py --include-quoted` only when the user
   wants quoted examples audited too.
3. Read the selected preset only for voice. It cannot authorize a finding.
4. Classify exact spans as confirmed findings or protected source. Do not
   fact-check, use the current date, or treat missing support as an AI tell.
   Scanner rows remain candidates until contextual review confirms a defect.
   If none are confirmed, return the source exactly. Skip reconstruction and
   validation of unchanged output.

## Pass 2 — reconstruct

Apply the core contract. Edit only a sentence containing a confirmed finding,
make the smallest repair, and copy all other sentences byte-for-byte. If there
are no findings, return the source exactly. Undo any edit that changes a fact,
meaning, register, attribution, or protected domain phrase.

## Validate

Run the gate battery and apply the blocking semantics in
`references/core-contract.md` **Validation**.

Return the cleaned text only, unless the user asked for the strict analysis
block in SKILL.md **Output Format**.

For multi-agent execution, use `references/pipeline.md`; for orchestrated
detector packs, use `references/packs/`.
