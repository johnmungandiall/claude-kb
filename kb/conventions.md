# Conventions — how claude-kb prompts and KB notes are structured.

## Prompt files

- **`prompt.md`** — full init; use on projects with no KB yet.
- **`update.md`** — delta upgrade; use when KB already exists.
- **`verify.md`** — audit existing KB for drift vs code; fix cheap, report rest. See [[prompt-verify]].
- **`README.md`** — duplicates all three prompts in fenced blocks for GitHub browsing; keep byte-identical to the standalone files.

## KB note rules (enforced in prompts)

- Each file ≤ 50 lines; bullets/tables; no code dumps.
- Reference code as `path:line`, verified by reading the file.
- One fact per place; cross-link with `[[other-note]]`.
- Start each file with a one-line summary.
- `kb/about-you.md` maps the USER (style, tech, goals, rules), not code; tag items [confirmed]/[inferred]. See [[glossary]].
- `CLAUDE.md` is a LEAN pointer — short triggers + map + a link to `kb/about-kb.md`; the full maintenance rules live in that note, never inline.

## Target `CLAUDE.md` section

- Exact heading: `## Knowledge Base` (optionally suffixed `(read FIRST — saves tokens)` per template).
- Body is LEAN: short triggers (read-first; after-change → update `kb/`; user-pref → `about-you`; sub-agents) + the map + a pointer to `kb/about-kb.md`. The full rules live in that note, not inline — keeps every session cheap.
- Map lists each `kb/` file with a 1-line description; update map line only when files added/removed.

See [[prompt-init]] / [[prompt-update]] for how these rules are enforced; [[architecture]] for the file tree.
