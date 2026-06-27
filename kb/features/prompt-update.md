# Feature — upgrade prompt (`update.md`)

- **Purpose:** Incrementally upgrade an existing claude-kb setup to latest spec without rebuilding `kb/`.
- **When:** Target already has `kb/` + `## Knowledge Base` in `CLAUDE.md`; user pastes `update.md` instead of `prompt.md`.
- **Also documented:** README "Update prompt" section (embedded copy — keep in sync).

## What it changes (only)

| Step | Source | Action |
|------|--------|--------|
| 1 | `update.md:7-46` | Create `kb/about-kb.md` (full KB rules) if missing — moved out of `CLAUDE.md` |
| 2 | `update.md:47-84` | Replace `## Knowledge Base` body with LEAN block + SLIM/migrate other `CLAUDE.md` reference content into `kb/`; keep existing summaries |
| 3 | `update.md:85-88` | Create `kb/about-you.md` if missing |
| 4 | `update.md:89-90` | Create optional `gotchas` / `changelog` / `cheatsheet` notes if useful |
| 5 | `update.md:91-95` | Add missing `kb/subprojects/` notes if monorepo |
| 6 | `update.md:96-98` | Add missing `[[other-note]]` cross-links to existing notes |
| 7 | `update.md:99` | Bump "last indexed" in `kb/overview.md` |

## Rules

- Incremental only — do not regenerate unchanged KB files (`update.md:101-105`).
- Same accuracy rules: `path:line` from opened files only.

Contrast with [[prompt-init]] (full bootstrap); note rules in [[conventions]].
