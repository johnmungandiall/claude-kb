# Feature — KB subagents (`.claude/agents/`)

- **Purpose:** Ship dedicated Claude Code subagents that run KB work in their OWN context window, auto-triggered by their `description` — so the KB maintains ITSELF and heavy KB tasks don't bloat the main session.
- **Auto-created:** `prompt.md` STEP 6 (`prompt.md:171-189`) and `update.md` step 7 (`update.md:151-160`) write these into any target repo, so every claude-kb setup gets them automatically.
- **Also documented:** the about-kb "Sub-agents & skills" rule says to prefer delegating KB work to them.

## The three agents (this repo's reference copies)

| File | Role |
|------|------|
| `.claude/agents/kb-maintainer.md` | After ANY code/config change, refresh the affected `kb/` notes (read-first, verify `path:line`). Use PROACTIVELY |
| `.claude/agents/kb-verify.md` | Audit the KB for DRIFT — the [[prompt-verify]] workflow; no Write tool |
| `.claude/agents/kb-slim.md` | Shrink a bloated `CLAUDE.md` — the [[prompt-slim]] workflow |

## Format & sync

- Claude Code agent file = YAML frontmatter (`name`, `description`, `tools`, `model: inherit`) + a system-prompt body. Auto-delegation keys off `description`.
- `kb-maintainer` stays DRY — reads `kb/about-kb.md` (or the `## Knowledge Base` rules) instead of re-embedding them. `kb-verify` / `kb-slim` carry a DISTILLED copy of their prompt — NOT byte-synced, since agents are generated artifacts (a distilled copy, not a verbatim one).
- Each agent body also carries the condensed "How to work" discipline (think-first, simplest change, surgical edits, verify) — mirrored from the about-kb template.

Contrast: the prompts ([[prompt-init]] etc.) are pasted by a human; these agents are invoked by Claude. See [[architecture]], [[conventions]].
