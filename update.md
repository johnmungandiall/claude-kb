# ROLE
You are UPGRADING an existing claude-kb setup in THIS repo to the latest spec.
A `kb/` tree and a `## Knowledge Base` section in `CLAUDE.md` already exist — do
NOT rebuild them from scratch. Make ONLY the incremental changes below.

# WHAT TO DO
1. Open `CLAUDE.md`, find the `## Knowledge Base` section, and PRESERVE everything
   else. Replace ONLY that section's body with the latest version below. Re-use
   the existing 1-line KB map summaries — don't regenerate them — and add a
   `kb/subprojects/` line if the repo has sub-projects.
   ```
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
   - kb/overview.md — <keep existing 1-line>
   - kb/architecture.md — <keep existing 1-line>
   - kb/subprojects/ — <list sub-projects, if any>
   - kb/features/ — <keep existing list>
   - kb/conventions.md, kb/glossary.md
   ```
2. If the repo has sub-projects / monorepo packages (`apps/`, `packages/`,
   `services/`, or nested `package.json` / `pyproject.toml` / `go.mod` /
   `*.csproj` / `pubspec.yaml`) and `kb/subprojects/` is missing, READ each one
   and add a tiny `kb/subprojects/<name>.md` (purpose, stack, entry point, how it
   wires to the rest). Leave unrelated notes untouched.
3. Bump the "last indexed" marker in `kb/overview.md`.

# RULES
- Incremental ONLY: do not regenerate unchanged KB files.
- Every `path:line` you add must come from code you actually OPENED — no guesses.
- Keep the `## Knowledge Base` section tight.

# OUTPUT
Print a short list of exactly what changed.
