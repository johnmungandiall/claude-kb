# ROLE
You maintain a COMPACT, token-efficient knowledge base (KB) for THIS project so
future AI sessions understand and navigate the codebase WITHOUT reading every file.

# GOAL
Create/update a small tree of Markdown notes under `kb/` that act as a MAP of the
project, AND wire the project's `CLAUDE.md` so the KB is SELF-MAINTAINING: once
wired, every future code change automatically refreshes the affected `kb/` notes
in the same session — the KB never goes stale. The KB must save tokens:
summarize, never copy code. Point to `path:line` instead of pasting code.

# STEPS
1. INVESTIGATE the code — do NOT skim. Read the entry points, config, and the key
   source files closely enough to understand what actually runs and how. Follow
   imports/calls to trace real data flow. Filenames and assumptions are NOT enough
   — open and read the file before you describe it. Writing KB notes from guesses
   instead of read code is the #1 failure; refuse to do it.
   Cover the WHOLE repo, not just one app: detect every sub-project / monorepo
   package (e.g. `apps/`, `packages/`, `services/`, or nested `package.json` /
   `pyproject.toml` / `go.mod` / `*.csproj` / `pubspec.yaml`) and treat each as
   its own area. Don't ignore non-code files that matter — config, env, CI/CD,
   Docker/k8s/IaC, build scripts, DB schemas/migrations, and docs.
2. From what you ACTUALLY READ (never assumed), identify: architecture, main
   features/modules, key files + their responsibility, data models, state
   management, routing/navigation, external APIs/services, conventions, gotchas.
3. Write the KB as a TREE of tiny files:
   - `kb/overview.md`      — what it does, tech stack, entry point, how to run, "last indexed: <date/commit>"
   - `kb/architecture.md`  — module map + data flow; for monorepos, how sub-projects connect; a tiny mermaid diagram is welcome when it clarifies
   - `kb/about-you.md`    — durable facts about the USER: working style, tech preferences, goals, standing rules; tag each [confirmed]/[inferred]
   - `kb/about-kb.md`     — the FULL KB-maintenance rules (auto-maintain, sub-agents, user-map) that `CLAUDE.md` points to instead of inlining
   - `kb/subprojects/<name>.md`— one per sub-project/package: purpose, stack, entry point, how it wires to the rest (omit if single-project repo)
   - `kb/features/<name>.md`— one per major feature: purpose, key files as `path:line`, key functions
   - `kb/conventions.md`   — naming, folder rules, patterns used
   - `kb/glossary.md`      — domain/business terms
   - `kb/gotchas.md`       — known traps / footguns / "do NOT do X" (only if any exist)
   - `kb/changelog.md`     — dated one-line history of notable KB changes
   - `kb/cheatsheet.md`    — one-page run/build/test commands + key entry points
4. Create `kb/about-kb.md` — the FULL KB rules. `CLAUDE.md` will hold only short
   triggers and POINT here, so the detail loads on demand, not every session:
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
5. Update `CLAUDE.md` at the repo root (create it if missing). PRESERVE all existing
   content — only add/refresh a section named exactly `## Knowledge Base`. Keep it
   LEAN: short triggers + the KB map + a pointer to `kb/about-kb.md`. Do NOT inline
   the full rules here — that is what `kb/about-kb.md` is for:
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
   - kb/overview.md — <1-line>
   - kb/about-kb.md — full KB-maintenance + sub-agent + user-map rules (read before maintaining)
   - kb/architecture.md — <1-line>
   - kb/about-you.md — what the USER prefers: working style, tech, goals, rules
   - kb/subprojects/ — <list sub-projects, if any>
   - kb/features/ — <list feature notes>
   - kb/conventions.md, kb/glossary.md
   - kb/gotchas.md, kb/changelog.md, kb/cheatsheet.md — traps, KB history, command cheatsheet (optional)
   ```
   Fill the 1-line summaries from the actual files. Keep this section tight; never
   duplicate `kb/about-kb.md` content into `CLAUDE.md` — point to it.

# RULES — keep it SMALL, DYNAMIC, ADVANCED
- ACCURACY over speed: every claim and every `path:line` must come from code you
  actually OPENED and verified this session — never from filenames or guesses.
  If you haven't read it, don't write it; go read it. Never invent files,
  functions, or line numbers. Verify a line number by looking at that line.
- Each KB file ≤ 50 lines. Dense bullets and tables only. No prose padding. No full code dumps.
  If a note outgrows 50 lines, SPLIT it into focused sub-notes rather than let it sprawl.
- Reference code as `lib/auth/login_service.dart:42`, NOT by pasting it.
- Mark volatile `path:line` refs with `(checked <date>)` so staleness is visible at a glance.
- NEVER copy secrets/keys/tokens/PII into the KB — reference where they live, never the value.
- Capture only what a filename does NOT reveal — the "why" and the wiring between parts.
- Keep a STABLE structure so it can be regenerated incrementally: on re-run, update
  ONLY the sections whose underlying code changed; leave the rest untouched.
- One fact per place. CROSS-LINK every note to its related notes with `[[other-note]]`
  (e.g. a feature note links its `[[conventions]]` and `[[glossary]]`). A note with NO
  links is incomplete — the KB must be a navigable web, not a pile of isolated files.
- Optimize for retrieval: start each file with a one-line summary of its contents.
- CLAUDE.md stays a LEAN POINTER: short triggers + the KB map + a link to
  `kb/about-kb.md`, never a copy of the rules (keeps every session cheap).

# OUTPUT
Create/update the files under `kb/`, update the `## Knowledge Base` section in
`CLAUDE.md`, then print a short list of what changed.
