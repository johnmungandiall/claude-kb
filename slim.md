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
   - NO DRIFT: changed a value/name/contract that lives in MORE THAN ONE place? update
     every copy and search the old value to zero. A trap noted in a feature note also
     gets a stub in `kb/gotchas.md`; a multi-step procedure gets a `kb/runbooks/` note.
     End a code/config change with a "KB: updated <note>" / "no change needed" line.

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
