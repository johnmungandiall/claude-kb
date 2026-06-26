# Feature — init prompt (`prompt.md`)

- **Purpose:** One-shot bootstrap of a compact, self-maintaining KB in any repo.
- **Trigger:** User pastes contents of `prompt.md` (or the README "The prompt" init block).

## Key sections in `prompt.md`

| Lines | Section | Does |
|-------|---------|------|
| `1-11` | ROLE / GOAL | Compact map under `kb/`; self-maintaining via `CLAUDE.md` |
| `13-22` | STEPS §1 | Deep read — no guesses; whole repo incl. monorepo + infra |
| `23-25` | STEPS §2 | Extract architecture, features, models, APIs, gotchas |
| `26-36` | STEPS §3 | KB file tree to create (incl. about-you/gotchas/changelog/cheatsheet) |
| `37-89` | STEPS §4 | `## Knowledge Base` block for target `CLAUDE.md` |
| `90-108` | RULES | ≤50 lines/file (split if bigger), `path:line` + `(checked <date>)`, `[[cross-link]]`, no secrets |
| `109-110` | OUTPUT | List what changed |

## CLAUDE.md wiring (target)

- Section title exactly `## Knowledge Base` — see template at `prompt.md:39-86`.
- Opens with a MANDATORY "read the KB FIRST" directive — KB is the designated entry point, not optional.
- AUTO-MAINTAIN: update affected `kb/` notes same session as code edits.
- SUB-AGENTS & SKILLS: pass KB read/update rules to dispatched agents.

See [[prompt-update]] for the incremental upgrade path; [[conventions]] for note rules.
