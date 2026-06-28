# Feature — upgrade prompt (`update.md`)

- **Purpose:** Incrementally upgrade an existing claude-kb setup to latest spec without rebuilding `kb/`.
- **When:** Target already has `kb/` + `## Knowledge Base` in `CLAUDE.md`; user pastes `update.md` instead of `prompt.md`.
- **Also documented:** README "Update prompt" section (embedded copy — keep in sync).

## What it changes (only)

| Step | Source | Action |
|------|--------|--------|
| 1 | `update.md:7-70` | Create `kb/about-kb.md` (full KB rules) if missing — moved out of `CLAUDE.md` |
| 2 | `update.md:71-108` | Replace `## Knowledge Base` body with LEAN block + SLIM/migrate other `CLAUDE.md` reference content into `kb/`; keep existing summaries |
| 3 | `update.md:109-112` | Create `kb/about-you.md` if missing |
| 4 | `update.md:113-114` | Create optional `gotchas` / `changelog` / `cheatsheet` notes if useful |
| 5 | `update.md:115-119` | Add missing `kb/subprojects/` notes if monorepo |
| 6 | `update.md:120-122` | Add missing `[[other-note]]` cross-links to existing notes |
| 7 | `update.md:123-132` | Create `.claude/agents/` KB subagents if missing (see [[kb-agents]]) |
| 8 | `update.md:133-197` | Create `tools/kb-check.sh` + sample `tools/hooks/pre-commit` if missing |
| 9 | `update.md:198` | Bump "last indexed" in `kb/overview.md` |

## Rules

- Incremental only — do not regenerate unchanged KB files (`update.md:200-205`).
- Same accuracy rules: `path:line` from opened files only.

Contrast with [[prompt-init]] (full bootstrap); note rules in [[conventions]].
