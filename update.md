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
   - kb/overview.md — <keep existing 1-line>
   - kb/architecture.md — <keep existing 1-line>
   - kb/about-you.md — what the USER prefers: working style, tech, goals, rules
   - kb/subprojects/ — <list sub-projects, if any>
   - kb/features/ — <keep existing list>
   - kb/conventions.md, kb/glossary.md
   ```
2. Create `kb/about-you.md` if it is missing — a compact note (≤ 50 lines) of
   durable facts about the USER: working style, tech preferences, project goals,
   and standing rules, each tagged [confirmed]/[inferred]. If it already exists,
   leave its content untouched. Ensure its line is in the KB map above.
3. If the repo has sub-projects / monorepo packages (`apps/`, `packages/`,
   `services/`, or nested `package.json` / `pyproject.toml` / `go.mod` /
   `*.csproj` / `pubspec.yaml`) and `kb/subprojects/` is missing, READ each one
   and add a tiny `kb/subprojects/<name>.md` (purpose, stack, entry point, how it
   wires to the rest). Leave unrelated notes untouched.
4. Add missing `[[other-note]]` cross-links: older setups were generated without
   them, so scan each `kb/` note and link it to its related notes (e.g. a feature
   note → `[[conventions]]`, `[[glossary]]`). Add only links; don't rewrite content.
5. Bump the "last indexed" marker in `kb/overview.md`.

# RULES
- Incremental ONLY: do not regenerate unchanged KB files.
- Every `path:line` you add must come from code you actually OPENED — no guesses.
- Cross-link related notes with `[[other-note]]`; a note with no links is incomplete.
- Keep the `## Knowledge Base` section tight.

# OUTPUT
Print a short list of exactly what changed.
