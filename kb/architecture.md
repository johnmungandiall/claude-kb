# Architecture — flat prompt repo; output is a tree in the *target* project.

## Repo layout (this repo)

| Path | Role |
|------|------|
| `README.md:1` | Human-facing docs; embeds full prompt text for copy-paste |
| `prompt.md:1` | Init prompt — investigate target code, write `kb/`, wire `CLAUDE.md` |
| `update.md:1` | Upgrade prompt — incremental spec refresh, no full rebuild |
| `LICENSE:1` | MIT |
| `kb/` | KB for *this* meta-repo (created by init) |

## Data flow (target project after paste)

```
User pastes prompt.md
  → Claude reads target codebase
  → writes kb/{overview,architecture,features/*,conventions,glossary}.md
  → adds ## Knowledge Base section to target CLAUDE.md
  → future sessions read kb/ first; AUTO-MAINTAIN on code changes
```

## KB tree spec (written into target)

- `kb/overview.md` — stack, entry, run, last indexed
- `kb/architecture.md` — module map, data flow
- `kb/subprojects/<name>.md` — per monorepo package (if any)
- `kb/features/<name>.md` — per major feature, `path:line` refs
- `kb/conventions.md`, `kb/glossary.md`

See `prompt.md:26-32` for the canonical file list. The two prompts are detailed in [[prompt-init]] and [[prompt-update]]; note-writing rules in [[conventions]].
