# Feature — init prompt (`prompt.md`)

- **Purpose:** One-shot bootstrap of a compact, self-maintaining KB in any repo.
- **Trigger:** User pastes the contents of `prompt.md`.

## Key sections in `prompt.md`

| Lines | Section | Does |
|-------|---------|------|
| `1-11` | ROLE / GOAL | Compact map under `kb/`; self-maintaining via `CLAUDE.md` |
| `13-22` | STEPS §1 | Deep read — no guesses; whole repo incl. monorepo + infra |
| `23-25` | STEPS §2 | Extract architecture, features, models, APIs, gotchas |
| `26-38` | STEPS §3 | KB file tree to create (incl. about-you/about-kb/gotchas/changelog/cheatsheet/runbooks) |
| `39-126` | STEPS §4 | Create `kb/about-kb.md` — FULL KB rules template (+ sub-agents, No-silent-drift, How-to-work, Pointers&freshness) |
| `127-170` | STEPS §5 | LEAN `## Knowledge Base` block + SLIM/migrate other `CLAUDE.md` reference content into `kb/` |
| `171-189` | STEPS §6 | Create `.claude/agents/` KB subagents (see [[kb-agents]]) |
| `190-340` | STEPS §7 | Create `tools/kb-check.sh` + sample `tools/hooks/pre-commit` (the drift checker) |
| `341-367` | RULES | ≤50 lines/file (split if bigger), `path:line` + `(checked <date>)`, `[[cross-link]]`, no-silent-drift (lockstep/central-traps/runbooks), no secrets, lean CLAUDE.md |
| `368-375` | OUTPUT | Run `tools/kb-check.sh --fix` then a plain check (`broken 0`), then list what changed |

## CLAUDE.md wiring (target)

- Section title exactly `## Knowledge Base` — LEAN template at `prompt.md:138-167`.
- Holds only short TRIGGERS (read-first; after-change → update `kb/`; user-pref → `about-you`; sub-agents) + the KB map + a pointer.
- The FULL rules (auto-maintain, sub-agents, user-map) live in `kb/about-kb.md`, loaded on demand — NOT inlined in `CLAUDE.md`, so every session stays cheap.
- STEP 5 also SLIMS an existing bloated `CLAUDE.md`: migrate reference content (architecture, commands, config, conventions…) into the matching `kb/` note (condensed + `path:line`), leaving a one-line pointer; keep only short always-on directives.

See [[prompt-update]] for the incremental upgrade path; [[conventions]] for note rules.
