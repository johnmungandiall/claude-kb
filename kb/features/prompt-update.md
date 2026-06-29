# Feature — upgrade prompt (`update.md`)

- **Purpose:** Incrementally upgrade an existing claude-kb setup to latest spec without rebuilding `kb/`.
- **When:** Target already has `kb/` + `## Knowledge Base` in `CLAUDE.md`; user pastes `update.md` instead of `prompt.md`.
- **Linked from:** `README.md` links to `update.md` (no embedded copy).

## What it changes (only)

| Step | Source | Action |
|------|--------|--------|
| 1 | `update.md:7-94` | Create `kb/about-kb.md` (full KB rules incl. No-silent-drift) if missing — moved out of `CLAUDE.md` |
| 2 | `update.md:95-136` | Replace `## Knowledge Base` body with LEAN block + SLIM/migrate other `CLAUDE.md` reference content into `kb/`; keep existing summaries |
| 3 | `update.md:137-140` | Create `kb/about-you.md` if missing |
| 4 | `update.md:141-142` | Create optional `gotchas` / `changelog` / `cheatsheet` notes if useful |
| 5 | `update.md:143-147` | Add missing `kb/subprojects/` notes if monorepo |
| 6 | `update.md:148-150` | Add missing `[[other-note]]` cross-links to existing notes |
| 7 | `update.md:151-160` | Create `.claude/agents/` KB subagents if missing (see [[kb-agents]]) |
| 8 | `update.md:161-311` | Create `tools/kb-check.sh` + sample `tools/hooks/pre-commit` if missing |
| 9 | `update.md:312` | Bump "last indexed" in `kb/overview.md` |

## Rules

- Incremental only — do not regenerate unchanged KB files (`update.md:314-319`).
- Same accuracy rules: `path:line` from opened files only.

Contrast with [[prompt-init]] (full bootstrap); note rules in [[conventions]].
