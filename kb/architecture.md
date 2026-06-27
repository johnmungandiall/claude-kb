# Architecture — flat prompt repo; output is a tree in the *target* project.

## Repo layout (this repo)

| Path | Role |
|------|------|
| `README.md:1` | Human-facing docs; embeds full prompt text for copy-paste |
| `prompt.md:1` | Init prompt — investigate target code, write `kb/`, wire `CLAUDE.md` |
| `update.md:1` | Upgrade prompt — incremental spec refresh, no full rebuild |
| `verify.md:1` | Audit prompt — re-check `path:line` vs code, fix cheap drift |
| `slim.md:1` | Slim prompt — migrate reference content out of a bloated `CLAUDE.md` into `kb/` |
| `LICENSE:1` | MIT |
| `kb/` | KB for *this* meta-repo (created by init) |

## Data flow (target project after paste)

```
User pastes prompt.md
  → Claude reads target codebase
  → writes kb/{overview,architecture,about-kb,about-you,features/*,conventions,glossary}.md
  → adds a LEAN ## Knowledge Base section to target CLAUDE.md (triggers + map + pointer to kb/about-kb.md)
  → future sessions read kb/ first; full maintain rules in kb/about-kb.md; AUTO-MAINTAIN on code changes
```

## KB tree spec (written into target)

- `kb/overview.md` — stack, entry, run, last indexed
- `kb/architecture.md` — module map, data flow
- `kb/about-kb.md` — full KB-maintenance rules; the lean `CLAUDE.md` points here
- `kb/about-you.md` — durable USER facts (style, tech, goals, rules)
- `kb/subprojects/<name>.md` — per monorepo package (if any)
- `kb/features/<name>.md` — per major feature, `path:line` refs
- `kb/conventions.md`, `kb/glossary.md`

See `prompt.md:26-37` for the canonical file list. The four prompts are detailed in [[prompt-init]], [[prompt-update]], [[prompt-verify]], and [[prompt-slim]]; note-writing rules in [[conventions]].
