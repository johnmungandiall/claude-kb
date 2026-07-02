# claude-kb

Reusable Claude Code prompts for building a compact, self-maintaining knowledge base in any repo.

## Knowledge Base (read FIRST — saves tokens)
This repo keeps a compact KB in `kb/`. The FULL KB rules (how to maintain it,
sub-agents, user-map) live in `kb/about-kb.md` — read it before you maintain the
KB, edit notes, or dispatch a sub-agent.

- READ FIRST: before ANY task (answer, code, debug, plan), open the relevant
  `kb/` notes to orient — do NOT grep or scan the whole repo first. If the KB
  lacks something, follow its `path:line` pointers into the code, then fold the
  finding back in.
- AFTER CHANGING code/config: update the affected `kb/` note(s) in the SAME
  session, before ending your turn — part of "done". (Exact rules: `kb/about-kb.md`.)
- WHEN THE USER states/corrects a durable preference, goal, or rule: update
  `kb/about-you.md` the same session.
- SUB-AGENTS & SKILLS: anything you dispatch starts cold — pass it these rules.
  Prefer delegating KB work to the `.claude/agents/` subagents
  (`kb-maintainer`, `kb-verify`, `kb-slim`); they auto-trigger by description.
- NO DRIFT: changed a value/name/contract that lives in MORE THAN ONE place? update
  every copy and search the old value to zero. A trap noted in a feature note also
  gets a stub in `kb/gotchas.md`; a multi-step procedure gets a `kb/runbooks/` note.
  End a code/config change with a "KB: updated <note>" / "no change needed" line.

Map of the KB:
- kb/overview.md — what claude-kb is, entry points, how to use
- kb/about-kb.md — full KB-maintenance + sub-agent + user-map rules (read before maintaining)
- kb/architecture.md — repo layout and target-project KB data flow
- kb/about-you.md — what the USER prefers: working style, tech, goals, rules
- kb/features/ — prompt-init (bootstrap), prompt-update (upgrade), prompt-verify (drift audit), prompt-slim (shrink a bloated CLAUDE.md), prompt-check (install the drift checker), prompt-hooks (install Claude Code lifecycle hooks), kb-agents (the .claude/agents/ subagents)
- kb/conventions.md, kb/glossary.md
- kb/gotchas.md, kb/changelog.md, kb/cheatsheet.md — repo traps, KB history, command cheatsheet
- kb/runbooks/ — multi-step procedures (e.g. edit-a-prompt): every artifact to touch, in order

## Editing the prompts (shared blocks stay in lockstep)
Some blocks are DUPLICATED across the prompt files — edit one copy → update every
copy in the SAME session; follow `kb/runbooks/edit-a-prompt.md`. Gates before done:
`bash tools/kb-check.sh` AND `bash tools/lockstep-check.sh` both green.
