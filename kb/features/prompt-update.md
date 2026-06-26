# Feature — upgrade prompt (`update.md`)

- **Purpose:** Incrementally upgrade an existing claude-kb setup to latest spec without rebuilding `kb/`.
- **When:** Target already has `kb/` + `## Knowledge Base` in `CLAUDE.md`; user pastes `update.md` instead of `prompt.md`.
- **Also documented:** `README.md:108-172`.

## What it changes (only)

| Step | Source | Action |
|------|--------|--------|
| 1 | `update.md:7-39` | Replace `## Knowledge Base` body in `CLAUDE.md`; keep existing 1-line map summaries |
| 2 | `update.md:40-44` | Add missing `kb/subprojects/` notes if monorepo |
| 3 | `update.md:45-47` | Add missing `[[other-note]]` cross-links to existing notes |
| 4 | `update.md:48` | Bump "last indexed" in `kb/overview.md` |

## Rules

- Incremental only — do not regenerate unchanged KB files (`update.md:50-54`).
- Same accuracy rules: `path:line` from opened files only.

Contrast with [[prompt-init]] (full bootstrap); note rules in [[conventions]].
