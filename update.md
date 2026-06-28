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
   - A code pointer is a `path:line` the checker can RESOLVE — a full path from
     the repo root (preferred) or one relative to the note (markdown links work);
     never a bare filename or a `name()` ref with no path. Name the function/class
     too: the NAME is the durable anchor, the line a hint that may drift (grep it).
   - Release history lives ONLY in `kb/changelog.md`; `kb/overview.md` keeps a
     one-line `last indexed: <date>` and nothing more — don't duplicate history.
   - Don't rely on discipline — run `tools/kb-check.sh` (created by the claude-kb
     setup: resolves every pointer; `--freshness` flags notes older than the code)
     via the sample `tools/hooks/pre-commit` or before release.

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
8. Create `tools/kb-check.sh` and a sample `tools/hooks/pre-commit` if missing —
   the drift checker the rules reference, so the KB is verified by a script, not by
   memory (older setups never got these). Write `tools/kb-check.sh` with exactly
   this content:

```bash
#!/usr/bin/env bash
# kb-check.sh — verify KB code pointers RESOLVE and their line is in range, in
# WHATEVER form they are written: `path:line` (backtick), [text](path):line
# (markdown link), path):line (stray paren). The path may be root-relative OR
# relative to the note itself (e.g. ../../lib/...). A ref with no file path (e.g.
# start():226) is flagged as uncheckable. With --freshness, also flag notes older
# than the code they cite (git). Deps: git-bash builtins only. From the repo root:
#   bash tools/kb-check.sh [--freshness]
set -u
kb="kb"; [ -d "$kb" ] || { echo "run from the repo root (no kb/ here)"; exit 0; }
bad=0
resolve() {  # <note> <path> -> prints the existing file (root- or note-relative), else nothing
  [ -f "$2" ] && { printf '%s' "$2"; return; }
  [ -f "$(dirname "$1")/$2" ] && printf '%s' "$(dirname "$1")/$2"
}
# pointers that carry a file path:  <path>.<ext> [optional )] : <line>
while IFS= read -r hit; do
  note="${hit%%:*}"; r="${hit#*:}"; ptr="${r#*:}"
  ln="${ptr##*:}"; p="${ptr%:*}"; p="${p%\)}"
  f="$(resolve "$note" "$p")"
  if [ -z "$f" ]; then
    echo "  x $note -> $ptr  (file not found)"; bad=$((bad + 1))
  else
    t=$(wc -l < "$f" | tr -d ' '); [ "$ln" -le "$t" ] || { echo "  x $note -> $ptr  (file has $t lines)"; bad=$((bad + 1)); }
  fi
done < <(grep -rnoE '[A-Za-z0-9_./-]+\.[A-Za-z0-9_]+\)?:[0-9]+' "$kb" 2>/dev/null)
# refs with NO file path (e.g. the function form start():226) — uncheckable, must be fixed
while IFS= read -r hit; do
  note="${hit%%:*}"; m="${hit#*:}"; m="${m#*:}"
  echo "  ? $note -> $m  (no file path — write it as a path:line)"; bad=$((bad + 1))
done < <(grep -rnoE '[A-Za-z_][A-Za-z0-9_]*\([^)]*\):[0-9]+' "$kb" 2>/dev/null)
if [ "${1:-}" = "--freshness" ]; then
  find "$kb" -name '*.md' | while IFS= read -r note; do
    nt=$(git log -1 --format=%ct -- "$note" 2>/dev/null) || continue; [ -n "$nt" ] || continue
    grep -oE '[A-Za-z0-9_./-]+\.[A-Za-z0-9_]+\)?:[0-9]+' "$note" 2>/dev/null \
      | sed -e 's/):[0-9]*$//' -e 's/:[0-9]*$//' | sort -u | while IFS= read -r p; do
        f="$(resolve "$note" "$p")"; [ -n "$f" ] || continue
        ct=$(git log -1 --format=%ct -- "$f" 2>/dev/null); [ -n "$ct" ] || continue
        [ "$ct" -gt "$nt" ] && echo "  ~ $note  (points to newer $f — re-check)"
      done
  done
fi
[ "$bad" -eq 0 ] && { echo "kb-check: OK — all pointers resolve."; exit 0; }
echo "kb-check: $bad problem(s) above."; exit 1
```

   and `tools/hooks/pre-commit`:

```bash
#!/usr/bin/env bash
# claude-kb sample pre-commit hook — block the commit if any KB pointer is broken.
# Install (pick one):
#   cp tools/hooks/pre-commit .git/hooks/pre-commit   # copy it in
#   git config core.hooksPath tools/hooks             # or point git at this dir
exec bash tools/kb-check.sh
```

   Run `bash tools/kb-check.sh` once to confirm pointers resolve; tell the user how
   to install the hook (it is opt-in).
9. Bump the "last indexed" marker in `kb/overview.md`.

# RULES
- Incremental ONLY: do not regenerate unchanged KB files.
- Every `path:line` you add must come from code you actually OPENED — no guesses.
- Cross-link related notes with `[[other-note]]`; a note with no links is incomplete.
- Keep the `## Knowledge Base` section tight.

# OUTPUT
Before finishing, RUN `bash tools/kb-check.sh` — this both confirms the KB's
pointers resolve AND proves you actually created the tool. If the command fails
because the file is missing, you skipped step 8: create `tools/kb-check.sh` and
`tools/hooks/pre-commit` now, then re-run it. Do NOT report done until it runs.
Then print a short list of exactly what changed.
