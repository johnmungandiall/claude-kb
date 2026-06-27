# ROLE
You are UPGRADING an existing claude-kb setup in THIS repo to the latest spec.
A `kb/` tree and a `## Knowledge Base` section in `CLAUDE.md` already exist — do
NOT rebuild them from scratch. Make ONLY the incremental changes below.

# WHAT TO DO
1. Create `kb/about-kb.md` if missing — the FULL KB rules, MOVED out of `CLAUDE.md`
   so the detail loads on demand, not every session. If it already exists, leave it:
   ```
   # About the KB — full rules for maintaining this knowledge base.

   Read this before you maintain the KB, edit notes, or dispatch a sub-agent.
   `CLAUDE.md` holds only the short triggers; the detail lives here.

   ## Read first
   - Before ANY task, open the relevant `kb/` notes to orient — don't grep/scan the
     whole repo first; the KB is the designated entry point, not a fallback.
   - If the KB lacks what you need, follow its `path:line` pointers into the code,
     then fold the finding back into the KB.

   ## Auto-maintain (mandatory)
   - Whenever you add, change, move, rename, or delete code/config, update the
     affected `kb/` note(s) in the SAME session, before ending your turn — part of
     "done", not optional. Touch only the notes whose underlying code changed.
   - New major feature → add `kb/features/<name>.md`. Refresh the "last indexed"
     marker in `kb/overview.md`. Append a dated one-line entry to `kb/changelog.md`.
   - Edit the `kb/` FILES, not `CLAUDE.md` — it stays a stable pointer. Change the KB
     map in `CLAUDE.md` ONLY when a `kb/` file is added or removed.

   ## Sub-agents & skills
   - A dispatched sub-agent (Task/Agent) or skill/workflow starts cold. Pass it the
     same rules: read the relevant `kb/` notes FIRST, and update them in the SAME
     session after changing code.

   ## User map
   - `kb/about-you.md` records durable facts about how the user wants you to work —
     working style, tech preferences, goals, standing rules.
   - When the user states or corrects a durable preference, goal, or rule, update
     `kb/about-you.md` the SAME session. Tag each item [confirmed]/[inferred];
     promote [inferred] → [confirmed] only on confirmation.
   - Capture lasting habits, not one-off chatter; never store secrets. Prefs that
     apply across ALL the user's projects → also persist to host long-term memory
     (e.g. Claude Code memory) when available.

   See [[conventions]] for note-writing rules, [[overview]] for the big picture.
   ```
2. Open `CLAUDE.md` and SLIM it to a LEAN pointer (it loads every session). First,
   replace the `## Knowledge Base` section body with the LEAN version below — short
   triggers + map + a pointer to `kb/about-kb.md` (the old verbose rules now live
   there). Re-use the existing 1-line KB map summaries; add a `kb/subprojects/`
   line if the repo has sub-projects.
   ```
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

   Map of the KB:
   - kb/overview.md — <keep existing 1-line>
   - kb/about-kb.md — full KB-maintenance + sub-agent + user-map rules (read before maintaining)
   - kb/architecture.md — <keep existing 1-line>
   - kb/about-you.md — what the USER prefers: working style, tech, goals, rules
   - kb/subprojects/ — <list sub-projects, if any>
   - kb/features/ — <keep existing list>
   - kb/conventions.md, kb/glossary.md
   - kb/gotchas.md, kb/changelog.md, kb/cheatsheet.md — traps, KB history, command cheatsheet (optional)
   ```
   Then MIGRATE any OTHER reference/knowledge content in `CLAUDE.md` (architecture,
   feature/module detail, build/test/run commands, configuration, data models,
   conventions, glossary, gotchas) INTO the matching `kb/` note — distilled to
   summary + `path:line`, ≤50 lines (split if bigger), never a code dump — then
   replace each such section with a one-line pointer. Nothing is lost; it moves,
   condensed. Keep ONLY short, always-on directives in `CLAUDE.md`. Never move
   secrets/keys/values — reference where they live.
3. Create `kb/about-you.md` if it is missing — a compact note (≤ 50 lines) of
   durable facts about the USER: working style, tech preferences, project goals,
   and standing rules, each tagged [confirmed]/[inferred]. If it already exists,
   leave its content untouched. Ensure its line is in the KB map above.
4. Create `kb/gotchas.md`, `kb/changelog.md`, and `kb/cheatsheet.md` if they are
   useful for this repo (skip any that do not apply); add their line to the KB map.
5. If the repo has sub-projects / monorepo packages (`apps/`, `packages/`,
   `services/`, or nested `package.json` / `pyproject.toml` / `go.mod` /
   `*.csproj` / `pubspec.yaml`) and `kb/subprojects/` is missing, READ each one
   and add a tiny `kb/subprojects/<name>.md` (purpose, stack, entry point, how it
   wires to the rest). Leave unrelated notes untouched.
6. Add missing `[[other-note]]` cross-links: older setups were generated without
   them, so scan each `kb/` note and link it to its related notes (e.g. a feature
   note → `[[conventions]]`, `[[glossary]]`). Add only links; don't rewrite content.
7. Bump the "last indexed" marker in `kb/overview.md`.

# RULES
- Incremental ONLY: do not regenerate unchanged KB files.
- Every `path:line` you add must come from code you actually OPENED — no guesses.
- Cross-link related notes with `[[other-note]]`; a note with no links is incomplete.
- Keep the `## Knowledge Base` section tight.

# OUTPUT
Print a short list of exactly what changed.
