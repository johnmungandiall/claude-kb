# Feature — init prompt (`prompt.md`)

- **Purpose:** One-shot bootstrap of a compact, self-maintaining KB in any repo.
- **Trigger:** User pastes contents of `prompt.md` (or README block at `README.md:20-106`).

## Key sections in `prompt.md`

| Lines | Section | Does |
|-------|---------|------|
| `1-10` | ROLE / GOAL | Compact map under `kb/`; self-maintaining via `CLAUDE.md` |
| `12-22` | STEPS §1 | Deep read — no guesses; whole repo incl. monorepo + infra |
| `23-25` | STEPS §2 | Extract architecture, features, models, APIs, gotchas |
| `26-32` | STEPS §3 | KB file tree to create |
| `33-65` | STEPS §4 | `## Knowledge Base` block for target `CLAUDE.md` |
| `67-81` | RULES | ≤50 lines/file, `path:line` refs, `[[cross-link]]` every note, accuracy over speed |
| `83-85` | OUTPUT | List what changed |

## CLAUDE.md wiring (target)

- Section title exactly `## Knowledge Base` — see template at `prompt.md:36-63`.
- AUTO-MAINTAIN: update affected `kb/` notes same session as code edits.
- SUB-AGENTS & SKILLS: pass KB read/update rules to dispatched agents.

See [[prompt-update]] for the incremental upgrade path; [[conventions]] for note rules.
