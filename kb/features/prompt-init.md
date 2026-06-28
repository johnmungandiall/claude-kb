# Feature — init prompt (`prompt.md`)

- **Purpose:** One-shot bootstrap of a compact, self-maintaining KB in any repo.
- **Trigger:** User pastes contents of `prompt.md` (or the README "The prompt" init block).

## Key sections in `prompt.md`

| Lines | Section | Does |
|-------|---------|------|
| `1-11` | ROLE / GOAL | Compact map under `kb/`; self-maintaining via `CLAUDE.md` |
| `13-22` | STEPS §1 | Deep read — no guesses; whole repo incl. monorepo + infra |
| `23-25` | STEPS §2 | Extract architecture, features, models, APIs, gotchas |
| `26-37` | STEPS §3 | KB file tree to create (incl. about-you/about-kb/gotchas/changelog/cheatsheet) |
| `38-101` | STEPS §4 | Create `kb/about-kb.md` — FULL KB rules template (+ sub-agents, How-to-work, Pointers&freshness) |
| `102-141` | STEPS §5 | LEAN `## Knowledge Base` block + SLIM/migrate other `CLAUDE.md` reference content into `kb/` |
| `142-161` | STEPS §6 | Create `.claude/agents/` KB subagents (see [[kb-agents]]) |
| `162-183` | RULES | ≤50 lines/file (split if bigger), full-path `path:line` + `(checked <date>)`, `[[cross-link]]`, no secrets, lean CLAUDE.md |
| `184-185` | OUTPUT | List what changed |

## CLAUDE.md wiring (target)

- Section title exactly `## Knowledge Base` — LEAN template at `prompt.md:114-139`.
- Holds only short TRIGGERS (read-first; after-change → update `kb/`; user-pref → `about-you`; sub-agents) + the KB map + a pointer.
- The FULL rules (auto-maintain, sub-agents, user-map) live in `kb/about-kb.md`, loaded on demand — NOT inlined in `CLAUDE.md`, so every session stays cheap.
- STEP 5 also SLIMS an existing bloated `CLAUDE.md`: migrate reference content (architecture, commands, config, conventions…) into the matching `kb/` note (condensed + `path:line`), leaving a one-line pointer; keep only short always-on directives.

See [[prompt-update]] for the incremental upgrade path; [[conventions]] for note rules.
