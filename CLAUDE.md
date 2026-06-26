# claude-kb

Reusable Claude Code prompts for building a compact, self-maintaining knowledge base in any repo.

## Knowledge Base (read FIRST — saves tokens)

MANDATORY — READ THE KB FIRST: this repo has a compact KB in `kb/`. Before ANY
task (answering, coding, debugging, planning) you MUST open the relevant `kb/`
notes to orient. This is NOT optional and NOT a fallback: do NOT grep or scan
the whole codebase before consulting the KB — it is the designated entry point,
and skipping it wastes tokens and risks missing context. If the KB lacks what
you need, follow its `path:line` pointers into the code, then fold the finding
back into the KB.

AUTO-MAINTAIN (mandatory): whenever you add, change, move, rename, or delete
code/config in this repo, you MUST update the affected `kb/` note(s) in the
SAME session, BEFORE ending your turn — treat it as part of "done", not
optional. Touch only the notes whose underlying code changed; leave the rest.
Edit the `kb/` FILES, not this CLAUDE.md — CLAUDE.md stays a stable pointer.
Change the KB map below ONLY when you add or remove a `kb/` file, and then
only that one line; routine code fixes must NOT modify CLAUDE.md.
New major feature → add `kb/features/<name>.md`. Refresh the "last indexed"
marker in `kb/overview.md`. Never let code and KB drift apart.

SUB-AGENTS & SKILLS: the KB is the shared map for EVERY agent, not just this
session. When you dispatch a sub-agent (Task/Agent) or run a skill/workflow
that reads or edits code, pass the same rule in its instructions — read the
relevant `kb/` notes FIRST to orient, and update them in the SAME session
after changing code. A sub-agent starts cold, so it won't use the KB unless
you tell it to.

USER UNDERSTANDING (mandatory): the KB also maps the USER, not just the
code. `kb/about-you.md` records durable facts about how the user wants you
to work — working style, tech preferences, project goals, and standing
rules. Read it FIRST alongside the code notes. Whenever the user states or
corrects a durable preference, goal, or rule, update `kb/about-you.md` in
the SAME session. Tag each item [confirmed] (user said/approved it) or
[inferred] (your guess); promote [inferred] → [confirmed] only when the
user confirms. Capture lasting habits, not one-off chatter; never store secrets.

Map of the KB:
- kb/overview.md — what claude-kb is, entry points, how to use
- kb/architecture.md — repo layout and target-project KB data flow
- kb/about-you.md — what the USER prefers: working style, tech, goals, rules
- kb/features/ — prompt-init (bootstrap), prompt-update (upgrade)
- kb/conventions.md, kb/glossary.md

## Editing the prompts (keep README in sync)

`README.md` embeds the FULL text of `prompt.md`, `update.md`, and `verify.md` in
fenced (````markdown) blocks. If you edit any prompt file, mirror the same change
into its matching README block in the SAME session, or the copies silently drift.
Verify with the diff gate (extract each fenced block, `diff` it against the
standalone file — they must be byte-identical). See `kb/conventions.md` for the
note-writing rules.
