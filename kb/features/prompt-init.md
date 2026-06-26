# Feature — init prompt (`prompt.md`)

- **Purpose:** One-shot bootstrap of a compact, self-maintaining KB in any repo.
- **Trigger:** User pastes contents of `prompt.md` (or the README "The prompt" init block).

## Key sections in `prompt.md`

| Lines | Section | Does |
|-------|---------|------|
| `1-10` | ROLE / GOAL | Compact map under `kb/`; self-maintaining via `CLAUDE.md` |
| `13-22` | STEPS §1 | Deep read — no guesses; whole repo incl. monorepo + infra |
| `23-25` | STEPS §2 | Extract architecture, features, models, APIs, gotchas |
| `26-37` | STEPS §3 | KB file tree to create (incl. about-you/about-kb/gotchas/changelog/cheatsheet) |
| `38-77` | STEPS §4 | Create `kb/about-kb.md` — the FULL KB-maintenance rules template |
| `78-109` | STEPS §5 | LEAN `## Knowledge Base` block for target `CLAUDE.md` (triggers + map + pointer) |
| `111-129` | RULES | ≤50 lines/file (split if bigger), `path:line` + `(checked <date>)`, `[[cross-link]]`, no secrets, lean CLAUDE.md |
| `131-133` | OUTPUT | List what changed |

## CLAUDE.md wiring (target)

- Section title exactly `## Knowledge Base` — LEAN template at `prompt.md:82-107`.
- Holds only short TRIGGERS (read-first; after-change → update `kb/`; user-pref → `about-you`; sub-agents) + the KB map + a pointer.
- The FULL rules (auto-maintain, sub-agents, user-map) live in `kb/about-kb.md`, loaded on demand — NOT inlined in `CLAUDE.md`, so every session stays cheap.

See [[prompt-update]] for the incremental upgrade path; [[conventions]] for note rules.
