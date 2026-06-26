# KB User-Understanding Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a self-evolving `kb/about-you.md` note so the KB maps the *user* (working style, tech preferences, goals, standing rules) — not just the code.

**Architecture:** Markdown-only repo. Two prompt files (`prompt.md` init, `update.md` upgrade) define the template that claude-kb writes into target repos; `README.md` embeds verbatim copies of both prompts; this repo dogfoods its own KB under `kb/`. The feature is added by editing both prompts, mirroring them into the README's fenced blocks, then dogfooding the note in this repo's own `kb/`.

**Tech Stack:** Markdown. No build/test framework — verification = `grep`/`diff`/re-read of file content. The key automated check is an exact diff between each README fenced block and its standalone prompt file.

## Global Constraints

- Every KB note ≤ 50 lines; dense bullets/tables; no code dumps. (verbatim from spec / `kb/conventions.md:11`)
- `CLAUDE.md` stays a POINTER to `kb/`, never a copy of KB content. (`kb/conventions.md:15`)
- `README.md` embeds the FULL text of `prompt.md` and `update.md`; any prompt edit MUST be mirrored into the matching README fenced block exactly. (`CLAUDE.md` "Editing the prompts")
- Items about the user are tagged `[confirmed]` (user stated/approved) or `[inferred]` (guess; promote only on confirmation). Never store secrets.
- KB version bumps to **2.1**.
- Scratchpad for temp files: `C:\Users\User\AppData\Local\Temp\claude\d--GitHub-claude-kb\0eea31b9-e433-4ee9-b9f3-5b80a95eb956\scratchpad`.

### Reusable text blocks (use verbatim where referenced)

**Block U — USER UNDERSTANDING rule** (CLAUDE.md template body, indented 3 spaces inside the fenced template in the prompts; 0 spaces in this repo's real CLAUDE.md):

```
USER UNDERSTANDING (mandatory): the KB also maps the USER, not just the
code. `kb/about-you.md` records durable facts about how the user wants you
to work — working style, tech preferences, project goals, and standing
rules. Read it FIRST alongside the code notes. Whenever the user states or
corrects a durable preference, goal, or rule, update `kb/about-you.md` in
the SAME session. Tag each item [confirmed] (user said/approved it) or
[inferred] (your guess); promote [inferred] → [confirmed] only when the
user confirms. Capture lasting habits, not one-off chatter; never store secrets.
```

**Block M — KB map line** (added to "Map of the KB" lists, right after the `kb/architecture.md` line):

```
- kb/about-you.md — what the USER prefers: working style, tech, goals, rules
```

**Block T — file-tree spec line** (prompt.md STEP 3 only, right after the `kb/architecture.md` line):

```
   - `kb/about-you.md`    — durable facts about the USER: working style, tech preferences, goals, standing rules; tag each [confirmed]/[inferred]
```

---

### Task 1: Add the user note to `prompt.md` (init prompt)

**Files:**
- Modify: `prompt.md` (STEP 3 file tree ~line 28; template body ~line 60; KB map ~line 63)

**Interfaces:**
- Consumes: nothing.
- Produces: the canonical wording (Block U, Block M, Block T) that Task 3 mirrors into README verbatim.

- [ ] **Step 1: Add the file-tree line (Block T) after the architecture line**

In `prompt.md`, find:
```
   - `kb/architecture.md`  — module map + data flow; for monorepos, how sub-projects connect
   - `kb/subprojects/<name>.md`— one per sub-project/package: purpose, stack, entry point, how it wires to the rest (omit if single-project repo)
```
Insert Block T between those two lines so it reads:
```
   - `kb/architecture.md`  — module map + data flow; for monorepos, how sub-projects connect
   - `kb/about-you.md`    — durable facts about the USER: working style, tech preferences, goals, standing rules; tag each [confirmed]/[inferred]
   - `kb/subprojects/<name>.md`— one per sub-project/package: purpose, stack, entry point, how it wires to the rest (omit if single-project repo)
```

- [ ] **Step 2: Insert the USER UNDERSTANDING rule (Block U) into the template**

In `prompt.md`, find the SUB-AGENTS paragraph end and the `Map of the KB:` line inside the fenced template:
```
   you tell it to.

   Map of the KB:
```
Replace with (Block U indented 3 spaces to match the fenced template, blank line before `Map of the KB:`):
```
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
```

- [ ] **Step 3: Add the KB map line (Block M) after the architecture map line**

In `prompt.md`, find inside the `Map of the KB:` block:
```
   - kb/architecture.md — <1-line>
   - kb/subprojects/ — <list sub-projects, if any>
```
Insert Block M (indented 3 spaces) between them:
```
   - kb/architecture.md — <1-line>
   - kb/about-you.md — what the USER prefers: working style, tech, goals, rules
   - kb/subprojects/ — <list sub-projects, if any>
```

- [ ] **Step 4: Verify all three insertions are present**

Run:
```bash
grep -n "about-you" prompt.md
grep -n "USER UNDERSTANDING" prompt.md
```
Expected: `about-you` appears on 3 lines (file tree, map, and inside Block U); `USER UNDERSTANDING` appears once.

- [ ] **Step 5: Commit**

```bash
git add prompt.md
git commit -m "feat: add kb/about-you.md user note to init prompt"
```

---

### Task 2: Add the user note to `update.md` (upgrade prompt)

**Files:**
- Modify: `update.md` (template body ~line 36; KB map ~line 39; insert new step after step 1; renumber steps 2-4)

**Interfaces:**
- Consumes: Block U, Block M from Task 1 (use identical wording).
- Produces: the upgrade-path wording Task 3 mirrors into the README update block.

- [ ] **Step 1: Insert the USER UNDERSTANDING rule (Block U) into the template**

In `update.md`, find:
```
   you tell it to.

   Map of the KB:
```
Replace with (Block U, 3-space indent, blank line before `Map of the KB:`):
```
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
```

- [ ] **Step 2: Add the KB map line (Block M) after the architecture map line**

In `update.md`, find:
```
   - kb/architecture.md — <keep existing 1-line>
   - kb/subprojects/ — <list sub-projects, if any>
```
Insert Block M (3-space indent) between them:
```
   - kb/architecture.md — <keep existing 1-line>
   - kb/about-you.md — what the USER prefers: working style, tech, goals, rules
   - kb/subprojects/ — <list sub-projects, if any>
```

- [ ] **Step 3: Insert a new numbered step (create the note) after step 1**

In `update.md`, find the start of step 2:
```
2. If the repo has sub-projects / monorepo packages (`apps/`, `packages/`,
```
Insert a new step before it and renumber this one to 3:
```
2. Create `kb/about-you.md` if it is missing — a compact note (≤ 50 lines) of
   durable facts about the USER: working style, tech preferences, project goals,
   and standing rules, each tagged [confirmed]/[inferred]. If it already exists,
   leave its content untouched. Ensure its line is in the KB map above.
3. If the repo has sub-projects / monorepo packages (`apps/`, `packages/`,
```

- [ ] **Step 4: Renumber the remaining steps (old 3 → 4, old 4 → 5)**

In `update.md`, change:
```
3. Add missing `[[other-note]]` cross-links: older setups were generated without
```
to:
```
4. Add missing `[[other-note]]` cross-links: older setups were generated without
```
and change:
```
4. Bump the "last indexed" marker in `kb/overview.md`.
```
to:
```
5. Bump the "last indexed" marker in `kb/overview.md`.
```

- [ ] **Step 5: Verify insertions and clean step numbering**

Run:
```bash
grep -n "about-you" update.md
grep -nE "^[0-9]\. " update.md
```
Expected: `about-you` on 3 lines; the numbered steps read `1. 2. 3. 4. 5.` with no duplicates or gaps.

- [ ] **Step 6: Commit**

```bash
git add update.md
git commit -m "feat: add kb/about-you.md upgrade step to update prompt"
```

---

### Task 3: Mirror both prompts into `README.md` and bump version

**Files:**
- Modify: `README.md` (init fenced block ~lines 82-173; update fenced block ~lines 181-244; add "What's new in v2.1" before line 59)

**Interfaces:**
- Consumes: the final `prompt.md` and `update.md` from Tasks 1-2.
- Produces: README fenced blocks byte-identical to the standalone prompt files (verified by diff).

- [ ] **Step 1: Re-apply Task 1's three edits inside the README init block**

In `README.md`, the first ` ````markdown ` fenced block (init prompt) is a verbatim copy of `prompt.md`. Apply the exact same three insertions from Task 1 (Block T in the STEP 3 file tree, Block U before `Map of the KB:`, Block M after the architecture map line) inside that block.

- [ ] **Step 2: Re-apply Task 2's edits inside the README update block**

In `README.md`, the second fenced block (update prompt, starts at "# ROLE / You are UPGRADING") is a verbatim copy of `update.md`. Apply the same edits from Task 2: Block U before `Map of the KB:`, Block M after the architecture map line, the new step 2, and renumbering old 3→4 / old 4→5.

- [ ] **Step 3: Verify exact sync between README blocks and standalone prompts**

Run (extracts the 1st and 3rd 4-backtick-fenced blocks and diffs them):
```bash
SP="C:/Users/User/AppData/Local/Temp/claude/d--GitHub-claude-kb/0eea31b9-e433-4ee9-b9f3-5b80a95eb956/scratchpad"
awk '/^````/{n++; next} n==1' README.md > "$SP/readme_init.txt"
awk '/^````/{n++; next} n==3' README.md > "$SP/readme_update.txt"
diff "$SP/readme_init.txt" prompt.md && echo "INIT IN SYNC"
diff "$SP/readme_update.txt" update.md && echo "UPDATE IN SYNC"
```
Expected: both diffs empty; prints `INIT IN SYNC` and `UPDATE IN SYNC`. If a diff shows lines, fix the README block to match the standalone file and re-run.

- [ ] **Step 4: Add the "What's new in v2.1" note**

In `README.md`, find:
```
## What's new in v2.0
```
Insert above it:
```
## What's new in v2.1

- **The KB now understands you, not just the code** — a new `kb/about-you.md`
  note records your working style, tech preferences, goals, and standing rules,
  and keeps itself updated as you work. Claude reads it first, every session.

```

- [ ] **Step 5: Commit**

```bash
git add README.md
git commit -m "docs: mirror about-you prompt changes into README + v2.1 note"
```

---

### Task 4: Dogfood — add `kb/about-you.md` and wire this repo's KB

**Files:**
- Create: `kb/about-you.md`
- Modify: `CLAUDE.md` (add Block U after SUB-AGENTS paragraph; add Block M to KB map)
- Modify: `kb/conventions.md` (add a note rule line for about-you)
- Modify: `kb/glossary.md` (add a term row)
- Modify: `kb/overview.md` (version → 2.1; refresh `last indexed`; add `[[about-you]]` to See also)

**Interfaces:**
- Consumes: nothing from other tasks (independent dogfood).
- Produces: a live example of the feature in this repo's own KB.

- [ ] **Step 1: Create `kb/about-you.md` with seeded, tagged facts**

Create `kb/about-you.md`:
```markdown
# About You — durable facts about the user (read FIRST, like the code KB).

Tag each item [confirmed] (user said/approved) or [inferred] (a guess; promote on confirmation). Lasting habits only — no one-off chatter, no secrets.

## Working style
- Prefers SIMPLE Telugu, everyday words, no technical jargon. [confirmed]
- Says "take over" → wants you to decide and drive; ask few questions, then act. [confirmed]

## Tech & preferences
- (none recorded yet — add as learned)

## Project goals
- Extend claude-kb so the KB also understands the USER and self-evolves, not just maps code. [confirmed]

## Decisions & rules
- Keep README's embedded prompts in sync with `prompt.md` / `update.md`. [confirmed]

See [[conventions]] for note rules, [[overview]] for what this repo is.
```

- [ ] **Step 2: Add Block U + Block M to this repo's `CLAUDE.md`**

In `CLAUDE.md`, find:
```
SUB-AGENTS & SKILLS: the KB is the shared map for EVERY agent, not just this
session. When you dispatch a sub-agent (Task/Agent) or run a skill/workflow
that reads or edits code, pass the same rule in its instructions — read the
relevant `kb/` notes FIRST to orient, and update them in the SAME session
after changing code. A sub-agent starts cold, so it won't use the KB unless
you tell it to.

Map of the KB:
```
Replace with (Block U at 0-space indent for the real file):
```
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
```
Then in the `Map of the KB:` list, find:
```
- kb/architecture.md — repo layout and target-project KB data flow
```
and insert after it:
```
- kb/about-you.md — what the USER prefers: working style, tech, goals, rules
```

- [ ] **Step 3: Add a note rule to `kb/conventions.md`**

In `kb/conventions.md`, under `## KB note rules (enforced in prompts)`, find:
```
- `CLAUDE.md` is a pointer only — never duplicate KB content there.
```
Insert before it:
```
- `kb/about-you.md` maps the USER (style, tech, goals, rules), not code; tag items [confirmed]/[inferred]. See [[glossary]].
```

- [ ] **Step 4: Add a glossary term to `kb/glossary.md`**

In `kb/glossary.md`, add a row at the end of the table:
```
| **about-you** | `kb/about-you.md` — durable user prefs (style, tech, goals, rules); the USER half of the KB |
```

- [ ] **Step 5: Bump version + last-indexed in `kb/overview.md`**

In `kb/overview.md`, replace:
```
- **version:** 2.0 — cross-linking (`[[other-note]]`) enforced as a first-class rule, plus a MANDATORY "read the KB FIRST" directive in the `CLAUDE.md` template.
- **last indexed:** 2026-06-26 / verify + cross-link pass
```
with:
```
- **version:** 2.1 — adds `kb/about-you.md`: the KB now also maps the USER (working style, tech, goals, rules) and self-evolves, not just the code.
- **last indexed:** 2026-06-26 / about-you feature
```
And in the `See also:` line, append `, [[about-you]]` before the trailing period.

- [ ] **Step 6: Verify dogfood files**

Run:
```bash
test -f kb/about-you.md && echo "NOTE EXISTS"
grep -c "about-you" CLAUDE.md kb/overview.md kb/conventions.md kb/glossary.md
grep -n "USER UNDERSTANDING" CLAUDE.md
```
Expected: `NOTE EXISTS`; each file reports ≥1 `about-you` match; `USER UNDERSTANDING` appears once in `CLAUDE.md`.

- [ ] **Step 7: Confirm `kb/about-you.md` is ≤ 50 lines**

Run:
```bash
wc -l kb/about-you.md
```
Expected: well under 50.

- [ ] **Step 8: Commit**

```bash
git add kb/about-you.md CLAUDE.md kb/conventions.md kb/glossary.md kb/overview.md
git commit -m "feat: dogfood kb/about-you.md and wire this repo's KB (v2.1)"
```

---

## Notes for the implementer

- This repo has **no automated test suite**; "verification" steps are `grep`/`diff`/`wc` content checks. Do not invent a test runner.
- The em dash `—`, arrow `→`, and `≤`/`≥` characters appear in the existing files; preserve them exactly (UTF-8).
- Task 3's diff check is the single most important gate — the README copies must match the standalone prompts byte-for-byte. If `awk` block extraction misbehaves on CRLF line endings, normalize both sides with `sed 's/\r$//'` before `diff`.
