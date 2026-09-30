---
name: tandoor-recipe-import
description: Import recipes from URLs, images, PDFs, or text into a user's Tandoor instance or validated German Tandoor JSON. Use for extraction, ingredient matching, step structuring, source attribution, and recipe images.
---

# Tandoor recipe import

Create a faithful, usable recipe in the user's Tandoor. Use this fallback order: dedicated Tandoor MCP, then direct authenticated Tandoor API, then authenticated browser UI.

## Tool selection: MCP first

Before using the direct API or opening Tandoor in a browser, inspect the active tool runtime for lazy-loaded `mcp__tandoor__*` tools. Do not infer that the MCP is absent merely because its tools were not included in the initial tool list.

- When present, use `mcp__tandoor__list_foods`, `mcp__tandoor__list_units`, and `mcp__tandoor__list_recipes` before every mutation.
- After all Food and Unit matches are settled, use `mcp__tandoor__create_recipe` or `mcp__tandoor__update_recipe`.
- Verify every write with `mcp__tandoor__get_recipe`.
- Use `mcp__tandoor__create_food` or `mcp__tandoor__create_unit` only after explicit user approval.
- Use `mcp__tandoor__upload_recipe_image` for a requested local JPEG or PNG.

If the MCP is unavailable or lacks a required capability, use the direct authenticated API. Browser UI is the final fallback, only after both MCP and API cannot provide the required capability. State which MCP and API capabilities are unavailable before using the browser.

## Extract and preserve the recipe

- Accept URLs, raw text, recipe images, PDFs, handwritten cards, and batches. Extract the actual recipe, not surrounding editorial or promotional text.
- For an image or PDF, use OCR and check every amount, unit, fraction, temperature, portion, and time against the source before saving.
- Preserve explicit portions, active time, waiting time, temperatures, source URL, and requested source image.
- Write the recipe in German when the source is in another language. Convert non-metric measures to metric only when the conversion is reliable.
- When portions or times are absent, estimate only if useful and label them as estimates in the draft. Never replace explicit source values.
- Match every ingredient against existing Tandoor Foods and Units before saving. Do not create Foods or Units silently.
- If an exact Food or Unit is absent, offer existing close matches and the proposed new record. Wait for the user's choice before creating anything. Do not substitute an ingredient without saying so.
- Prefer existing metric units. If the UI has no suitable unit, use an accurate conversion and retain the source measure in the ingredient note.
- The local `tandoor` MCP retrieves its write token from the macOS Keychain; never request, read, echo, or persist that token.
- Without that MCP, request a write-scoped token only for the active import. Keep it out of the skill, files, logs, source attribution, and recipe notes.

## Normalize ingredients and values

- Normalize source terms to singular German for matching and shopping-list quality, for example `Eier` to `Ei` and `Tomaten` to `Tomate`.
- Normalize numeric input into decimal values. Retain an exact fraction as a note when the UI cannot represent it.
- For a live import, use the exact selected existing Food label even when its display form differs from the normalized lookup form.
- Keep a conversion only when the ingredient and conversion are unambiguous; otherwise retain the source measure in the note and ask.
- Treat close Food matches as alternatives, not equivalents. Preserve the selected substitute in the ingredient note and align the instruction wording with it.

## Steps and ingredients

- Create real Tandoor Steps, not one instruction field with headings. Group source actions into meaningful preparation phases.
- When a step's initial phrase is `Name: instruction`, set `Name` as the Tandoor step name and remove `Name:` from its instruction. Do not duplicate titles in both places.
- Assign each ingredient row to the step where it is used. Move rather than copy rows when an amount belongs to one later step.
- Separate source amounts that are genuinely used in different phases (for example, dough butter and filling butter). Their rows should appear only in the relevant steps.
- Ingredients used without a measurable amount in a later instruction need not become a speculative extra ingredient row; preserve the instruction wording instead.
- Encode a source ingredient without a measurable amount as `no_amount`, never as an invented zero quantity.

## Tandoor MCP workflow

1. Draft title, portions, times, ingredients, semantic steps, and source mapping before mutation.
2. Use `list_recipes` to find title matches, then `get_recipe` on candidates to check the source URL. Do not create a duplicate recipe.
3. Read existing Foods and Units, then match every ingredient. For an absent Food or Unit, present close matches and the proposed record; wait for the user's choice before `create_food` or `create_unit`.
4. Create the recipe only after every ingredient choice is resolved. Send the source URL and real semantic Steps with ingredient rows assigned to their actual step.
5. For a requested video image, extract several clear frames of the finished dish and let the user select one before `upload_recipe_image`.
6. Before an update, use `get_recipe`; use `update_recipe` only for changed fields, then re-read and verify the result.
7. Re-read the saved recipe with `get_recipe` and verify title, step names, ingredient tables per step, source URL, and image when requested.

### Local Tandoor MCP

Use the following tools when the `tandoor` MCP is present: `list_foods`, `get_food`, `list_units`, `create_unit`, `list_recipes`, `get_recipe`, `create_food`, `create_recipe`, `update_recipe`, and `upload_recipe_image`.

The MCP owns the credential boundary. Its macOS Keychain entry must never be copied into prompts, tool arguments, skill instructions, generated artifacts, or logs.

## JSON mode

Use JSON mode only when the user asks for an export rather than a live import.

- Emit valid German Tandoor-compatible JSON with singular normalized ingredient names. Encode every amount as a numeric float, for example `0.5`, never as `"1/2"`.
- Build the payload against the current Tandoor API or import schema. Include timestamps only when the selected schema requires them, in its exact required format. Do not invent unsupported fields.
- Validate JSON syntax, required fields, types, and schema constraints before delivery. Keep validation failures per recipe; a partially valid batch is not a successful batch.
- State clearly that the result is an export, not an imported recipe.
