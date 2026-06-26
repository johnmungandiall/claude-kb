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

Map of the KB:
- kb/overview.md — what claude-kb is, entry points, how to use
- kb/architecture.md — repo layout and target-project KB data flow
- kb/features/ — prompt-init (bootstrap), prompt-update (upgrade)
- kb/conventions.md, kb/glossary.md

## Editing the prompts (keep README in sync)

`README.md` embeds the FULL text of `prompt.md` and `update.md` in fenced
blocks (README.md:82, README.md:181). If you edit either prompt file, mirror
the same change into the matching README block in the SAME session, or the two
copies silently drift. See `kb/conventions.md` for the note-writing rules.
