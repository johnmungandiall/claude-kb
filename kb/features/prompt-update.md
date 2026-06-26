# Feature — upgrade prompt (`update.md`)

- **Purpose:** Incrementally upgrade an existing claude-kb setup to latest spec without rebuilding `kb/`.
- **When:** Target already has `kb/` + `## Knowledge Base` in `CLAUDE.md`; user pastes `update.md` instead of `prompt.md`.
- **Also documented:** `README.md:136-205`.

## What it changes (only)

| Step | Source | Action |
|------|--------|--------|
| 1 | `update.md:7-44` | Replace `## Knowledge Base` body in `CLAUDE.md`; keep existing 1-line map summaries |
| 2 | `update.md:45-49` | Add missing `kb/subprojects/` notes if monorepo |
| 3 | `update.md:50-52` | Add missing `[[other-note]]` cross-links to existing notes |
| 4 | `update.md:53` | Bump "last indexed" in `kb/overview.md` |

## Rules

- Incremental only — do not regenerate unchanged KB files (`update.md:55-59`).
- Same accuracy rules: `path:line` from opened files only.

Contrast with [[prompt-init]] (full bootstrap); note rules in [[conventions]].
