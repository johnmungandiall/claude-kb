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
   - `kb/subprojects/<name>.md`— one per sub-project/package: purpose, stack, entry point, how it wires to the rest (omit if single-project repo)
   - `kb/features/<name>.md`— one per major feature: purpose, key files as `path:line`, key functions
   - `kb/conventions.md`   — naming, folder rules, patterns used
   - `kb/glossary.md`      — domain/business terms
   - `kb/gotchas.md`       — known traps / footguns / "do NOT do X" (only if any exist)
   - `kb/changelog.md`     — dated one-line history of notable KB changes
   - `kb/cheatsheet.md`    — one-page run/build/test commands + key entry points
4. Update `CLAUDE.md` at the repo root (create it if missing). PRESERVE all existing
   content — only add/refresh a section named exactly `## Knowledge Base` containing:
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
   marker in `kb/overview.md`. Never let code and KB drift apart. Append a dated
   one-line entry to `kb/changelog.md` for notable changes.

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
   Repo-specific prefs live here; prefs that apply across ALL the user's projects,
   also persist to the host's long-term memory (e.g. Claude Code memory) when available.

   Map of the KB:
   - kb/overview.md — <1-line>
   - kb/architecture.md — <1-line>
   - kb/about-you.md — what the USER prefers: working style, tech, goals, rules
   - kb/subprojects/ — <list sub-projects, if any>
   - kb/features/ — <list feature notes>
   - kb/conventions.md, kb/glossary.md
   - kb/gotchas.md, kb/changelog.md, kb/cheatsheet.md — traps, KB history, command cheatsheet (optional)
   ```
   Fill the 1-line summaries from the actual files. Do not duplicate KB content into
   CLAUDE.md — link to it. Keep this section tight.

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
- CLAUDE.md stays a POINTER to `kb/`, never a copy of it (keeps every session cheap).

# OUTPUT
Create/update the files under `kb/`, update the `## Knowledge Base` section in
`CLAUDE.md`, then print a short list of what changed.
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
   marker in `kb/overview.md`. Never let code and KB drift apart. Append a dated
   one-line entry to `kb/changelog.md` for notable changes.

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
   Repo-specific prefs live here; prefs that apply across ALL the user's projects,
   also persist to the host's long-term memory (e.g. Claude Code memory) when available.

   Map of the KB:
   - kb/overview.md — <keep existing 1-line>
   - kb/architecture.md — <keep existing 1-line>
   - kb/about-you.md — what the USER prefers: working style, tech, goals, rules
   - kb/subprojects/ — <list sub-projects, if any>
   - kb/features/ — <keep existing list>
   - kb/conventions.md, kb/glossary.md
   - kb/gotchas.md, kb/changelog.md, kb/cheatsheet.md — traps, KB history, command cheatsheet (optional)
   ```
2. Create `kb/about-you.md` if it is missing — a compact note (≤ 50 lines) of
   durable facts about the USER: working style, tech preferences, project goals,
   and standing rules, each tagged [confirmed]/[inferred]. If it already exists,
   leave its content untouched. Ensure its line is in the KB map above.
3. Create `kb/gotchas.md`, `kb/changelog.md`, and `kb/cheatsheet.md` if they are
   useful for this repo (skip any that do not apply); add their line to the KB map.
4. If the repo has sub-projects / monorepo packages (`apps/`, `packages/`,
   `services/`, or nested `package.json` / `pyproject.toml` / `go.mod` /
   `*.csproj` / `pubspec.yaml`) and `kb/subprojects/` is missing, READ each one
   and add a tiny `kb/subprojects/<name>.md` (purpose, stack, entry point, how it
   wires to the rest). Leave unrelated notes untouched.
5. Add missing `[[other-note]]` cross-links: older setups were generated without
   them, so scan each `kb/` note and link it to its related notes (e.g. a feature
   note → `[[conventions]]`, `[[glossary]]`). Add only links; don't rewrite content.
6. Bump the "last indexed" marker in `kb/overview.md`.

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
1. Read every `kb/` note. For each concrete claim — especially `path:line`
   references — open the referenced file and confirm it still says what the note
   claims. A note written from a stale guess is the #1 problem; verify, don't assume.
2. Classify each finding:
   - STALE `path:line` — the line moved or the file/function no longer exists.
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

# OUTPUT
Print two short lists: FIXED (what you changed) and NEEDS-CONFIRMATION (drift you
found but did not auto-fix, with the `path:line` and why).
````

## License

[MIT](LICENSE).
