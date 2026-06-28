# Conventions — how claude-kb prompts and KB notes are structured.

## Prompt files

- **`prompt.md`** — full init; use on projects with no KB yet.
- **`update.md`** — delta upgrade; use when KB already exists.
- **`verify.md`** — audit existing KB for drift vs code; fix cheap, report rest. See [[prompt-verify]].
- **`slim.md`** — shrink a bloated `CLAUDE.md`; migrate reference content into `kb/`, leave pointers. See [[prompt-slim]].
- **`check.md`** — install `tools/kb-check.sh` + sample hook in any repo (focused, can't-skip). See [[prompt-check]].
- **`README.md`** — duplicates all five prompts in fenced blocks for GitHub browsing; keep byte-identical to the standalone files.
- **`.claude/agents/`** — KB subagents the prompts auto-create (`kb-maintainer`, `kb-verify`, `kb-slim`); distilled, NOT byte-synced to the prompts (generated artifacts). See [[kb-agents]].

## KB note rules (enforced in prompts)

- Each file ≤ 50 lines; bullets/tables; no code dumps.
- Reference code as a FULL path from the repo root + `:line` (e.g. `prompt.md` at line 42), verified by reading the file — no bare filenames or stray punctuation, so `tools/kb-check.sh` can verify it. Name the function/class too: the NAME is the durable anchor, the line a hint that may drift (grep the name if it's off).
- Release history lives ONLY in `kb/changelog.md`; `kb/overview.md` keeps a one-line `last indexed: <date>`, nothing more — no duplication.
- Don't rely on memory — run `bash tools/kb-check.sh` (resolves every pointer; `--freshness` flags git-stale notes) before release or on a pre-commit hook. See [[cheatsheet]].
- One fact per place; cross-link with `[[other-note]]`.
- Start each file with a one-line summary.
- `kb/about-you.md` maps the USER (style, tech, goals, rules), not code; tag items [confirmed]/[inferred]. See [[glossary]].
- `CLAUDE.md` is a LEAN pointer — short triggers + map + a link to `kb/about-kb.md`; the full maintenance rules live in that note, never inline.

## Target `CLAUDE.md` section

- Exact heading: `## Knowledge Base` (optionally suffixed `(read FIRST — saves tokens)` per template).
- Body is LEAN: short triggers (read-first; after-change → update `kb/`; user-pref → `about-you`; sub-agents) + the map + a pointer to `kb/about-kb.md`. The full rules live in that note, not inline — keeps every session cheap.
- Map lists each `kb/` file with a 1-line description; update map line only when files added/removed.

See [[prompt-init]] / [[prompt-update]] for how these rules are enforced; [[architecture]] for the file tree.
