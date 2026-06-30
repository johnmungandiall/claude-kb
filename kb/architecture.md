# Architecture — flat prompt repo; output is a tree in the *target* project.

## Repo layout (this repo)

| Path | Role |
|------|------|
| `README.md:1` | Human-facing docs; LINKS to the prompt files (no longer embeds them) |
| `prompt.md:1` | Init prompt — investigate target code, write `kb/`, wire `CLAUDE.md` |
| `update.md:1` | Upgrade prompt — incremental spec refresh, no full rebuild |
| `verify.md:1` | Audit prompt — re-check `path:line` vs code, fix cheap drift |
| `slim.md:1` | Slim prompt — migrate reference content out of a bloated `CLAUDE.md` into `kb/` |
| `check.md:1` | Check prompt — install `tools/kb-check.sh` + sample hook in any repo (focused) |
| `hooks.md:1` | Hooks prompt — install Claude Code lifecycle hooks (`.claude/hooks/*.py` + `settings.json`) that auto-fire KB upkeep + the drift gate (focused) |
| `.claude/agents/` | KB subagents (`kb-maintainer` / `kb-verify` / `kb-slim`); the prompts auto-create these in any target repo |
| `tools/kb-check.sh` | Drift checker (symbol-aware) — resolves markdown-link & backtick-path pointers (broken = exit 1) and binds name-anchored `` `Name`:line `` to its file (same-line link / `(basename.ext)` hint / the note's first link), flagging STALE when the symbol left the cited line; `--fix` relocates a drifted line by the symbol's unique definition, `--freshness` flags git-stale notes; auto-created by the prompts |
| `tools/hooks/pre-commit` | Sample opt-in hook that runs the checker to gate commits |
| `LICENSE:1` | MIT |
| `kb/` | KB for *this* meta-repo (created by init) |

## Data flow (target project after paste)

```
User pastes prompt.md
  → Claude reads target codebase
  → writes kb/{overview,architecture,about-kb,about-you,features/*,conventions,glossary}.md
  → adds a LEAN ## Knowledge Base section to target CLAUDE.md (triggers + map + pointer to kb/about-kb.md)
  → writes .claude/agents/{kb-maintainer,kb-verify,kb-slim}.md (auto-delegating KB subagents)
  → writes tools/kb-check.sh + tools/hooks/pre-commit (drift checker + sample hook)
  → future sessions read kb/ first; full maintain rules in kb/about-kb.md; AUTO-MAINTAIN on code changes (often via the kb-maintainer agent)
```

## KB tree spec (written into target)

- `kb/overview.md` — stack, entry, run, last indexed
- `kb/architecture.md` — module map, data flow
- `kb/about-kb.md` — full KB-maintenance rules; the lean `CLAUDE.md` points here
- `kb/about-you.md` — durable USER facts (style, tech, goals, rules)
- `kb/subprojects/<name>.md` — per monorepo package (if any)
- `kb/features/<name>.md` — per major feature, `path:line` refs
- `kb/conventions.md`, `kb/glossary.md`

See `prompt.md:26-38` for the canonical file list. The six prompts are detailed in [[prompt-init]], [[prompt-update]], [[prompt-verify]], [[prompt-slim]], [[prompt-check]], and [[prompt-hooks]]; the auto-created subagents in [[kb-agents]]; note-writing rules in [[conventions]].
