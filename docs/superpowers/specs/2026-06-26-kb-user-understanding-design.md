# Design — KB that also understands the user (`kb/about-you.md`)

**Date:** 2026-06-26
**Status:** Approved (design)
**Topic:** Extend claude-kb so the KB captures and self-evolves an understanding of the *user*, not just the code.

## Problem

Today claude-kb maps only the **code**: `kb/overview.md`, `architecture.md`,
`features/*`, `conventions.md`, `glossary.md`. Every session re-learns the user's
preferences, working style, and goals from scratch. The user wants the KB to also
**understand the user and keep evolving that understanding** — as a first-class
benefit of the KB, portable to any repo where claude-kb is pasted.

## Goal

Add one compact, self-maintaining note — `kb/about-you.md` — that records durable
facts about the user across four areas, is read FIRST alongside the code KB, and
is updated in the SAME session whenever Claude learns something durable about the
user. Same discipline as the existing code AUTO-MAINTAIN rule, applied to the
person instead of the code.

## Chosen approach

**A — one new self-evolving note (recommended).** A single `kb/about-you.md`
keeps user knowledge in one clear place, easy to read-first and easy to update.

Rejected alternatives:
- **B — spread user facts into existing notes** (goals → overview, rules →
  conventions): mixes user with code, hard to evolve, no single read-first target.
- **C — a top-level file outside `kb/`** (e.g. `USER.md`): breaks the "`kb/` is the
  one map" model and the read-first wiring; portability/clarity suffer.

## Design details

### 1. New note: `kb/about-you.md`

Compact (≤ 50 lines, bullets/tables — same rules as every KB note). Four sections:

| Section | Captures |
|---------|----------|
| **Working style** | terse vs detailed answers, language (e.g. Telugu/English), tests wanted or not, how much to ask vs "take over" |
| **Tech & preferences** | favored tools, libraries, frameworks, patterns the user likes/avoids |
| **Project goals** | what the user is trying to achieve in this repo |
| **Decisions & rules** | standing "do this / don't do that" instructions given earlier |

Each item is tagged **`[confirmed]`** (user stated/approved it) or **`[inferred]`**
(Claude's guess, not yet confirmed). Cross-links to `[[conventions]]` /
`[[overview]]` where relevant.

### 2. Self-evolve rule (USER AUTO-MAINTAIN)

A new rule, parallel to the code AUTO-MAINTAIN rule, added to the CLAUDE.md
template (in both prompts) and to this repo's own CLAUDE.md:

> Whenever the user states or corrects a **durable** preference, goal, or rule
> about how they want you to work, record/update it in `kb/about-you.md` in the
> SAME session. Read it FIRST (with the code KB) each session. Tag items
> `[confirmed]` vs `[inferred]`; promote `[inferred]` → `[confirmed]` only when
> the user confirms. Capture lasting habits, not one-off chatter.

### 3. Accuracy & privacy guard

- Only **durable** facts — not transient, task-specific chat.
- `[inferred]` items must be visibly marked and never treated as fact until
  confirmed.
- No secrets/credentials; this is a preference map, not a data dump.
- Note stays per-repo (lives in that repo's `kb/`), matching the existing model.

### 4. Wiring (files to change)

1. **`prompt.md`** (init): add `kb/about-you.md` to the file-tree spec (STEP 3),
   add the USER AUTO-MAINTAIN rule to the `## Knowledge Base` template (STEP 4),
   add its line to the KB map.
2. **`update.md`** (upgrade): add a step that creates `kb/about-you.md` if missing
   and injects the USER AUTO-MAINTAIN rule into existing setups; bump version.
3. **`README.md`**: mirror both prompt changes into the embedded fenced blocks
   (the README-sync rule just added to CLAUDE.md), and a short "What's new" note.
4. **This repo (dogfood):** create `kb/about-you.md` for this repo, update the
   KB map in `CLAUDE.md`, refresh `kb/conventions.md`/`glossary.md` and the
   `last indexed` marker in `kb/overview.md`. Bump KB version to 2.1.

## Out of scope (YAGNI)

- Cross-repo / global user profile syncing — per-repo only for now.
- Any automated PII detection beyond the simple "no secrets, durable only" rule.
- Provider-specific memory integrations (Claude Code memory, etc.) — the note is
  plain Markdown, portable by design.

## Success criteria

- Pasting `prompt.md` on a fresh repo produces a `kb/about-you.md` and a CLAUDE.md
  whose Knowledge Base section includes the USER AUTO-MAINTAIN rule.
- Pasting `update.md` on an existing setup adds the note + rule without rebuilding.
- README's embedded prompts match the standalone files exactly.
- This repo's own KB demonstrates the feature (dogfooded).
