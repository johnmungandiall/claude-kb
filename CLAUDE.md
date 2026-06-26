# claude-kb

Reusable Claude Code prompts for building a compact, self-maintaining knowledge base in any repo.

## Knowledge Base (read FIRST — saves tokens)

This repo has a compact KB in `kb/`. Before any task, read the relevant `kb/`
files to orient instead of scanning the whole codebase.

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
