# claude-kb

![claude-kb — a compact, self-maintaining knowledge base for Claude Code](assets/banner.png)

[![Made for Claude Code](https://img.shields.io/badge/made%20for-Claude%20Code-8A2BE2)](https://www.anthropic.com/claude-code)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
![Markdown only — no dependencies](https://img.shields.io/badge/dependencies-none-brightgreen)
![Works with any repo](https://img.shields.io/badge/works%20with-any%20language-blue)
[![GitHub stars](https://img.shields.io/github/stars/johnmungandiall/claude-kb?style=social)](https://github.com/johnmungandiall/claude-kb/stargazers)

> Stop paying for Claude to re-learn your whole codebase every single session.

A reusable **Claude Code** prompt that builds a compact, self-maintaining
knowledge base (`kb/`) for any repo. Once set up, every future session reads a
small map first — **fewer tokens, faster answers, no re-exploration.**

**The problem:** each new session, Claude re-scans your files to figure out how
the project works — slow, and it burns tokens every time.

**The fix:** a tiny tree of Markdown notes (`kb/`) that maps the project — entry
points, architecture, features, gotchas — pointing to `path:line` instead of
pasting code. Claude reads the map, not the whole repo.

> [!IMPORTANT]
> **It updates itself.** Whenever you change the project — add a feature, rename
> a file, or tweak config — Claude refreshes the affected `kb/` notes in the
> *same* session, as part of the task. The map never drifts from the code, and
> you never maintain it by hand.

> [!TIP]
> **One paste to set up.** No install, no dependencies — works on any language
> or framework.

## How it works

```mermaid
flowchart LR
    A([New Claude session]) --> B{kb/ map exists?}
    B -- no --> E[Scan the whole repo] --> F[🐌 slow · burns tokens]
    B -- yes --> C[Read the small kb/ map] --> D[⚡ fast · fewer tokens]
    G([You change the code]) --> H[Claude refreshes the affected<br/>notes in the same session] --> A
    classDef bad fill:#ffe0e0,stroke:#e53935,color:#b71c1c;
    classDef good fill:#e0f7e0,stroke:#2e7d32,color:#1b5e20;
    classDef upd fill:#ede0ff,stroke:#7b2ff2,color:#4a148c;
    class E,F bad;
    class C,D good;
    class G,H upd;
```

## Without vs with claude-kb

|  | Without `kb/` | With `kb/` |
|---|---|---|
| **Start of each session** | Claude re-reads many files to orient | Claude reads one small map |
| **Tokens to get oriented** | High — paid *every* session | Low — the map is read instead |
| **Staying current** | You re-explain the project | Notes auto-update when code changes |
| **Setup** | — | One paste · any language |

## What's new in v2.7

- **Drift is caught by a script, not by memory** — `tools/kb-check.sh` verifies
  every `path:line` pointer resolves (and `--freshness` flags notes older than the
  code they cite). Pointers are now a checkable full path from the repo root, and
  release history lives in one place (`kb/changelog.md`). `verify.md` runs it first.

## What's new in v2.6

- **The KB builds its own agents** — setup now auto-creates Claude Code subagents
  under `.claude/agents/` (`kb-maintainer`, `kb-verify`, `kb-slim`). They run KB
  work in their own context window and auto-trigger by task, so the KB keeps itself
  current — and heavy verify/slim jobs stay out of your main session.

## What's new in v2.5

- **One prompt just to shrink `CLAUDE.md`** — a new [slim.md](slim.md) prompt
  takes an already-bloated `CLAUDE.md` and moves its reference content into
  compact `kb/` notes, leaving a one-line pointer in each spot. Focused job — no
  KB rebuild, no drift audit — for when your `CLAUDE.md` got huge and you just
  want it lean again.

## What's new in v2.4

- **The setup prompts now slim `CLAUDE.md` for you** — running [prompt.md](prompt.md)
  or [update.md](update.md) migrates any reference content already in `CLAUDE.md`
  (architecture, commands, config, conventions, gotchas) into the matching `kb/`
  note and replaces it with a pointer, so the always-loaded file stays lean.

## What's new in v2.3

- **Leaner `CLAUDE.md`, nothing lost** — the full KB-maintenance, sub-agent, and
  user-map rules move out of the always-loaded `CLAUDE.md` into a new
  `kb/about-kb.md`. `CLAUDE.md` now carries only short triggers, the map, and a
  pointer — every session loads less, and the detail is read on demand.

## What's new in v2.2

- **Audit for drift** — a new [verify.md](verify.md) prompt re-checks every
  `path:line` against the code, fixes the cheap mismatches, and lists the rest.
- **More note types** — optional `kb/gotchas.md` (traps), `kb/changelog.md` (KB
  history), and `kb/cheatsheet.md` (one-page commands).
- **Smarter rules** — freshness markers on volatile refs, a mermaid diagram in
  architecture, a secret guard, an oversized-note split rule, and global user
  prefs that persist to host memory.

## What's new in v2.1

- **The KB now understands you, not just the code** — a new `kb/about-you.md`
  note records your working style, tech preferences, goals, and standing rules,
  and keeps itself updated as you work. Claude reads it first, every session.

## What's new in v2.0

- **Using the KB is now mandatory** — the wired `CLAUDE.md` opens with a strong
  "read the KB FIRST" directive, so sessions consult the map before scanning code.
- **Cross-linking is enforced** — every note links its related notes with
  `[[other-note]]`, making the KB a navigable web instead of isolated files.

Already on an older setup? Paste [update.md](update.md) to upgrade in place.

## Use it

1. Open your project in Claude Code.
2. Paste the prompt below (or the contents of [prompt.md](prompt.md)).
3. Claude reads the code, writes `kb/` notes, and wires your `CLAUDE.md` to read
   them first — then keeps them updated whenever the code changes.

**Already set up an older version?** Paste [update.md](update.md) instead — it
upgrades your existing `kb/` + `CLAUDE.md` wiring to the latest v2.0 rules
(mandatory KB usage, enforced cross-linking, sub-agents/skills, sub-projects)
without rebuilding the whole KB.

**Just need to shrink a bloated `CLAUDE.md`?** Paste [slim.md](slim.md) — it moves
the reference content out into `kb/` notes and leaves pointers, without rebuilding
the KB or auditing it for drift.

## The prompt

````markdown
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
   - This KB ships dedicated subagents in `.claude/agents/` (`kb-maintainer`,
     `kb-verify`, `kb-slim`); prefer DELEGATING KB work to them — they auto-trigger
     on the right tasks and already follow these rules.

   ## User map
   - `kb/about-you.md` records durable facts about how the user wants you to work —
     working style, tech preferences, goals, standing rules.
   - When the user states or corrects a durable preference, goal, or rule, update
     `kb/about-you.md` the SAME session. Tag each item [confirmed]/[inferred];
     promote [inferred] → [confirmed] only on confirmation.
   - Capture lasting habits, not one-off chatter; never store secrets. Prefs that
     apply across ALL the user's projects → also persist to host long-term memory
     (e.g. Claude Code memory) when available.

   ## How to work
   - THINK FIRST: state assumptions; if the request has multiple readings or a
     simpler path exists, say so — don't silently pick.
   - SIMPLEST THING: the minimum change that solves it — no speculative features,
     abstractions, or config that wasn't asked for.
   - SURGICAL: change only what the task needs; match the surrounding style; don't
     refactor or reformat unrelated code; remove only the orphans YOUR change
     creates, and flag (don't delete) other dead code.
   - GOAL-DRIVEN: turn the task into a concrete check and loop until it verifies.

   ## Pointers & freshness
   - A code pointer is ALWAYS a full path from the repo root + `:line` (e.g.
     `lib/foo/bar.dart:42`) — never a bare filename or stray punctuation, so a
     script can verify it. Name the function/class too: the NAME is the durable
     anchor, the line is a hint that may drift — grep the name if the line is off.
   - Release history lives ONLY in `kb/changelog.md`; `kb/overview.md` keeps a
     one-line `last indexed: <date>` and nothing more — don't duplicate history.
   - Don't rely on discipline — run a pointer checker (claude-kb ships
     `tools/kb-check.sh`: resolves every pointer, `--freshness` flags notes older
     than the code) on a pre-commit hook or before release.

   See [[conventions]] for note-writing rules, [[overview]] for the big picture.
   ```
5. Update `CLAUDE.md` at the repo root (create it if missing), and SLIM it — it
   loads every session, so it must stay a LEAN pointer. Add/refresh a section named
   exactly `## Knowledge Base`: short triggers + the KB map + a pointer to
   `kb/about-kb.md` (do NOT inline the full rules — that is what `kb/about-kb.md` is
   for). Then MIGRATE any reference/knowledge ALREADY in `CLAUDE.md` (architecture,
   feature/module detail, build/test/run commands, configuration, data models,
   conventions, glossary, gotchas) INTO the matching `kb/` note — distilled to
   summary + `path:line`, ≤50 lines (split if bigger), never a code dump — and
   replace each such section with a one-line pointer. Nothing is lost; it moves,
   condensed. Keep ONLY short, always-on directives in `CLAUDE.md`; never move
   secrets:
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
   duplicate `kb/about-kb.md` content into `CLAUDE.md` — point to it. The whole
   `CLAUDE.md` should end up a lean pointer, not a manual.
6. Create `.claude/agents/` so the KB maintains ITSELF through auto-delegating
   subagents — Claude Code invokes each one automatically by its `description`, in
   its OWN context window (keeps the main session cheap). Write each as a Claude
   Code agent file: YAML frontmatter (`name`, `description`, `tools`,
   `model: inherit`) then a short system prompt. Create three:
   - `.claude/agents/kb-maintainer.md` — `description` says to use it PROACTIVELY
     after ANY code/config change to refresh the affected `kb/` notes. Body: read
     `kb/about-kb.md` (or the `## Knowledge Base` rules) + the relevant notes
     FIRST; update ONLY the notes whose code changed; verify every `path:line` by
     opening the file; bump "last indexed" and append `kb/changelog.md`.
   - `.claude/agents/kb-verify.md` — `description`: audit the KB for DRIFT (when it
     may be stale or on request). Body: re-check every `path:line`, fix cheap
     mismatches in place, list the rest — the `verify.md` workflow. No Write tool.
   - `.claude/agents/kb-slim.md` — `description`: shrink a bloated `CLAUDE.md`.
     Body: migrate reference content into `kb/` notes ONE section at a time and
     leave pointers, KEEPing safety-critical directives — the `slim.md` workflow.
   These let the main thread DELEGATE heavy KB work instead of doing it inline.
   Give each agent body the same "How to work" discipline: think first, make the
   simplest surgical change, and verify before finishing.

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
  `kb/about-kb.md`, never a copy of the rules OR reference content — migrate any
  such content already in CLAUDE.md into the matching `kb/` note, leaving a pointer
  (keeps every session cheap).

# OUTPUT
Create/update the files under `kb/` and `.claude/agents/`, update the
`## Knowledge Base` section in `CLAUDE.md`, then print a short list of what changed.
````

## Update prompt (for existing setups)

Already ran an older version? Paste this instead of the full prompt — it upgrades
your existing `kb/` + `CLAUDE.md` to the latest rules without rebuilding the KB.
It's also in [update.md](update.md).

````markdown
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
   - This KB ships dedicated subagents in `.claude/agents/` (`kb-maintainer`,
     `kb-verify`, `kb-slim`); prefer DELEGATING KB work to them — they auto-trigger
     on the right tasks and already follow these rules.

   ## User map
   - `kb/about-you.md` records durable facts about how the user wants you to work —
     working style, tech preferences, goals, standing rules.
   - When the user states or corrects a durable preference, goal, or rule, update
     `kb/about-you.md` the SAME session. Tag each item [confirmed]/[inferred];
     promote [inferred] → [confirmed] only on confirmation.
   - Capture lasting habits, not one-off chatter; never store secrets. Prefs that
     apply across ALL the user's projects → also persist to host long-term memory
     (e.g. Claude Code memory) when available.

   ## How to work
   - THINK FIRST: state assumptions; if the request has multiple readings or a
     simpler path exists, say so — don't silently pick.
   - SIMPLEST THING: the minimum change that solves it — no speculative features,
     abstractions, or config that wasn't asked for.
   - SURGICAL: change only what the task needs; match the surrounding style; don't
     refactor or reformat unrelated code; remove only the orphans YOUR change
     creates, and flag (don't delete) other dead code.
   - GOAL-DRIVEN: turn the task into a concrete check and loop until it verifies.

   ## Pointers & freshness
   - A code pointer is ALWAYS a full path from the repo root + `:line` (e.g.
     `lib/foo/bar.dart:42`) — never a bare filename or stray punctuation, so a
     script can verify it. Name the function/class too: the NAME is the durable
     anchor, the line is a hint that may drift — grep the name if the line is off.
   - Release history lives ONLY in `kb/changelog.md`; `kb/overview.md` keeps a
     one-line `last indexed: <date>` and nothing more — don't duplicate history.
   - Don't rely on discipline — run a pointer checker (claude-kb ships
     `tools/kb-check.sh`: resolves every pointer, `--freshness` flags notes older
     than the code) on a pre-commit hook or before release.

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
7. Create `.claude/agents/` if it is missing — three KB subagents so the KB
   maintains ITSELF via auto-delegating agents (Claude Code invokes each by its
   `description`, in its own context window). Each is a Claude Code agent file
   (YAML frontmatter `name` / `description` / `tools` / `model: inherit` + a short
   system prompt): `kb-maintainer.md` (use PROACTIVELY after any code/config change
   to refresh the affected `kb/` notes), `kb-verify.md` (audit the KB for drift —
   the `verify.md` workflow, no Write), and `kb-slim.md` (shrink a bloated
   `CLAUDE.md` — the `slim.md` workflow). Leave any that already exist untouched.
   Give each agent body the same "How to work" discipline: think first, make the
   simplest surgical change, and verify before finishing.
8. Bump the "last indexed" marker in `kb/overview.md`.

# RULES
- Incremental ONLY: do not regenerate unchanged KB files.
- Every `path:line` you add must come from code you actually OPENED — no guesses.
- Cross-link related notes with `[[other-note]]`; a note with no links is incomplete.
- Keep the `## Knowledge Base` section tight.

# OUTPUT
Print a short list of exactly what changed.
````

## Verify prompt (audit the KB against the code)

Want to check that the `kb/` map still matches the code? Paste this prompt (or
the contents of [verify.md](verify.md)). It reads the notes, re-checks every
`path:line` against the real files, fixes the cheap mismatches, and lists the
rest for you to confirm — without rebuilding the KB.

````markdown
# ROLE
You are AUDITING an existing claude-kb setup in THIS repo for DRIFT — places
where the `kb/` notes no longer match the code. Do NOT rebuild the KB and do NOT
make large rewrites. Find mismatches, fix the cheap ones, and report the rest.

# WHAT TO DO
1. If `tools/kb-check.sh` exists, RUN it first (`bash tools/kb-check.sh --freshness`)
   — it auto-flags every pointer that no longer resolves and every note older than
   the code it points to; start from its output. Then read every `kb/` note. For
   each concrete claim — especially `path:line` references — open the referenced
   file and confirm it still says what the note claims. A note written from a stale
   guess is the #1 problem; verify, don't assume.
2. Classify each finding:
   - STALE `path:line` — the line moved or the file/function no longer exists; a
     bare filename or non-resolving pointer is STALE (pointers = full path from root).
   - WRONG claim — the note describes behavior the code no longer has.
   - MISSING — a major feature/module/sub-project has no note.
   - ORPHAN — a note describes code that was deleted.
   - BROKEN `[[link]]` — a cross-link points at a note that does not exist.
3. FIX cheaply and safely in place: correct a moved line number, fix a broken
   `[[link]]`, delete an orphan line, refresh the `(checked <date>)` marker. For
   anything bigger (a missing feature note, a reworked module), do NOT guess —
   list it for the user to confirm.
4. If `kb/changelog.md` exists, append a dated one-line entry summarizing the audit.
   Refresh the "last indexed" marker in `kb/overview.md`.

# RULES
- Verify before you touch: every fix must come from a file you actually OPENED.
- Incremental ONLY — no full regeneration, no restructuring.
- Keep each note ≤ 50 lines and a pointer-style map, not a code copy.
- Never invent files, functions, or line numbers to make a note "look" current.
- Pointers are a full path from the repo root + `:line`; fix any that aren't.

# OUTPUT
Print two short lists: FIXED (what you changed) and NEEDS-CONFIRMATION (drift you
found but did not auto-fix, with the `path:line` and why).
````

## Slim prompt (shrink a bloated CLAUDE.md)

Already have a giant `CLAUDE.md` that loads every session and burns tokens? Paste
this prompt (or the contents of [slim.md](slim.md)). It moves the reference
content — architecture, commands, config, conventions, gotchas — out of
`CLAUDE.md` into compact `kb/` notes and leaves a one-line pointer in each spot,
so nothing is lost but every session loads less. Focused job: it does **not**
rebuild the KB or audit for drift.

````markdown
# ROLE
You are SLIMMING a bloated `CLAUDE.md` in THIS repo. It loads every session, so
every line costs tokens forever. MOVE the reference/knowledge content OUT of
`CLAUDE.md` into compact `kb/` notes (condensed + `path:line`), leaving a
one-line pointer in its place. This is a FOCUSED migration — NOT a full KB
rebuild (`prompt.md`) and NOT a drift audit (`verify.md`). Nothing is lost; it
moves, distilled. `CLAUDE.md` must end up a LEAN pointer.

# WORK INCREMENTALLY — ONE SECTION AT A TIME
A big `CLAUDE.md` will NOT fit in one pass (verifying every `path:line` alone eats
context). Do NOT cut everything and then rewrite everything. Process ONE section
fully before the next: write + verify its `kb/` note, and ONLY THEN cut that
section from `CLAUDE.md` and leave the pointer. That way an interrupted run never
loses content. If context runs low, STOP at a clean section boundary and report
exactly which sections are DONE and which REMAIN — never leave `CLAUDE.md`
half-cut with notes half-written.

# WHAT TO DO
1. Read `CLAUDE.md` end to end. Note its current size (lines) for the
   before/after. Sort its content into two buckets:
   - KEEP (stays in `CLAUDE.md`): short, always-on directives that must fire EVERY
     session — "always do X", build/lint/test gates, tone, the `## Knowledge Base`
     triggers. ALSO KEEP safety-critical directives even when conditional (no
     auto-commit/push/add unless asked, never put secrets in the KB, the
     release-notes / changelog workflow): leave a ONE-LINE directive in
     `CLAUDE.md` and move only the deep detail.
   - MOVE (reference/knowledge): architecture, module/feature detail, data models,
     build/run/test commands, configuration, conventions, glossary, domain terms,
     gotchas — anything read only WHEN working on that area.
2. Take ONE MOVE section and distill it into the matching `kb/` note:
   - If the note is MISSING, create it (`kb/overview.md`, `kb/architecture.md`,
     `kb/features/<name>.md`, `kb/conventions.md`, `kb/glossary.md`,
     `kb/gotchas.md`, `kb/cheatsheet.md`). Condense to summary + `path:line`,
     ≤50 lines (SPLIT if bigger), never a code dump.
   - If a matching note ALREADY EXISTS, MERGE the missing detail into it — do NOT
     overwrite a good note and do NOT duplicate what it already says.
3. Verify `path:line`s. For any pointer you NEWLY write, OPEN the code and confirm
   it — never trust the old `CLAUDE.md` text; bloat is often stale. For an
   existing trusted note, spot-check 2–3 pointers instead of re-verifying it all.
4. ONLY after the note is written and verified, cut that section from `CLAUDE.md`
   and replace it with a ONE-LINE pointer (e.g. "Architecture: see
   `kb/architecture.md`."). Then loop back to step 2 for the next section.
5. Ensure `CLAUDE.md` has a lean `## Knowledge Base` section — short triggers +
   the KB map + a pointer to `kb/about-kb.md`. If `kb/about-kb.md` is missing,
   create it with the FULL KB-maintenance rules (auto-maintain, sub-agents,
   user-map) so `CLAUDE.md` never has to inline them:
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
6. Refresh the "last indexed" marker in `kb/overview.md` and append a dated
   one-line entry to `kb/changelog.md` (create either if it is missing).

# RULES
- Verify before you write: every NEW `path:line` must come from a file you
  actually OPENED this session — never copied from the old `CLAUDE.md`, never
  guessed. (Existing trusted notes: spot-check, don't re-verify wholesale.)
- Move, don't delete: each MOVE section must land in a `kb/` note BEFORE you cut
  it from `CLAUDE.md`. Nothing is lost — it moves, condensed.
- One section at a time; if context runs low, STOP at a clean boundary and report
  done vs remaining — never leave `CLAUDE.md` half-cut with notes half-written.
- Each KB note ≤ 50 lines, dense bullets/tables, no code dumps; SPLIT if bigger.
- NEVER move secrets/keys/tokens/PII into the KB — reference where they live.
- Keep `CLAUDE.md` a LEAN pointer; do NOT duplicate `kb/about-kb.md` into it.
- Cross-link each touched note to its related notes with `[[other-note]]`.

# OUTPUT
Print the `CLAUDE.md` size before vs after (lines), a short list mapping each moved
section → its new `kb/` note, and — if you stopped early — which sections are DONE
and which REMAIN. Report in the user's working language.
````

## Keeping the KB honest (drift check)

The KB's promise is that pointers stay accurate. Don't leave that to discipline —
[tools/kb-check.sh](tools/kb-check.sh) checks it for you. It's an optional,
dependency-light helper (pure git-bash — the prompts themselves stay Markdown-only):

```bash
bash tools/kb-check.sh              # every `path:line` resolves? exits 1 if not
bash tools/kb-check.sh --freshness  # also flag notes older than the code they cite (git)
```

Wire it into a pre-commit hook or your pre-release checklist so broken pointers
fail loudly. `verify.md` (and the `kb-verify` agent) run it first when auditing.

## License

[MIT](LICENSE).
