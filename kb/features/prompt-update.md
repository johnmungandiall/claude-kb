# Feature — upgrade prompt (`update.md`)

- **Purpose:** Incrementally upgrade an existing claude-kb setup to latest spec without rebuilding `kb/`.
- **When:** Target already has `kb/` + `## Knowledge Base` in `CLAUDE.md`; user pastes `update.md` instead of `prompt.md`.
- **Also documented:** README "Update prompt" section (embedded copy — keep in sync).

## What it changes (only)

| Step | Source | Action |
|------|--------|--------|
| 1 | `update.md:7-46` | Create `kb/about-kb.md` (full KB rules) if missing — moved out of `CLAUDE.md` |
| 2 | `update.md:47-77` | Replace `## Knowledge Base` body with the LEAN block (triggers + map + pointer to about-kb); keep existing 1-line summaries |
| 3 | `update.md:78-81` | Create `kb/about-you.md` if missing |
| 4 | `update.md:82-83` | Create optional `gotchas` / `changelog` / `cheatsheet` notes if useful |
| 5 | `update.md:84-88` | Add missing `kb/subprojects/` notes if monorepo |
| 6 | `update.md:89-91` | Add missing `[[other-note]]` cross-links to existing notes |
| 7 | `update.md:92` | Bump "last indexed" in `kb/overview.md` |

## Rules

- Incremental only — do not regenerate unchanged KB files (`update.md:94-98`).
- Same accuracy rules: `path:line` from opened files only.

Contrast with [[prompt-init]] (full bootstrap); note rules in [[conventions]].
