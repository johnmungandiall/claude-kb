# Feature — upgrade prompt (`update.md`)

- **Purpose:** Incrementally upgrade an existing claude-kb setup to latest spec without rebuilding `kb/`.
- **When:** Target already has `kb/` + `## Knowledge Base` in `CLAUDE.md`; user pastes `update.md` instead of `prompt.md`.
- **Also documented:** README "Update prompt" section (embedded copy — keep in sync).

## What it changes (only)

| Step | Source | Action |
|------|--------|--------|
| 1 | `update.md:7-54` | Replace `## Knowledge Base` body in `CLAUDE.md`; keep existing 1-line map summaries |
| 2 | `update.md:55-58` | Create `kb/about-you.md` if missing |
| 3 | `update.md:63-64` | Create optional `gotchas` / `changelog` / `cheatsheet` notes if useful |
| 4 | `update.md:65-69` | Add missing `kb/subprojects/` notes if monorepo |
| 5 | `update.md:70-72` | Add missing `[[other-note]]` cross-links to existing notes |
| 6 | `update.md:73` | Bump "last indexed" in `kb/overview.md` |

## Rules

- Incremental only — do not regenerate unchanged KB files (`update.md:75-79`).
- Same accuracy rules: `path:line` from opened files only.

Contrast with [[prompt-init]] (full bootstrap); note rules in [[conventions]].
