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

   ## No silent drift
   - LOCKSTEP SETS: before calling a change done, ask whether the value/name/contract
     you changed lives in MORE THAN ONE place — a version string, an enum mirrored by a
     switch, an allowlist duplicated in build + runtime, a field set on the server and
     parsed on the client, a default repeated in code + docs. Edit one member, then
     search the repo for the OLD value: zero stale hits or you are not done. Record each
     set as an explicit KB invariant ("change X → also change Y, Z, because …") and
     cross-link every member's note.
   - CENTRAL TRAPS: a trap you record inside a feature/module note MUST also get a
     one-line stub + `[[gotchas]]` link in the central `kb/gotchas.md` index, or the
     next person won't find it. Read `kb/gotchas.md` first when behavior surprises you.
   - RUNBOOKS: a multi-step procedure (cutting a release, deploying, rotating a secret,
     onboarding) needs a `kb/runbooks/<name>.md` listing EVERY file/step/artifact to
     touch, in order — a build/run command list is NOT a runbook. Capture it the first
     time you carry the procedure out.
   - VISIBLE UPKEEP: end any turn that changed code/config with a status line — "KB:
     updated <note(s)>" or "KB: no change needed because <reason>" — so the user never
     has to ask whether the KB was updated.

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
   - PREFER a name-anchored pointer: a markdown link to the file, then the symbol
     in backticks with its line, like `[lib/app.dart](../lib/app.dart)` then
     `` `start()`:<line> `` (a name with no same-line link binds to the note's first
     link / primary file). The NAME is the durable anchor; the line is a hint — so
     the checker can confirm the symbol is still on that line and `--fix` can
     relocate it when code moves. A bare `[file](path):<line>` / `` `path:<line>` ``
     is only existence + range checked. Never a bare filename. (Write illustrative
     examples with a `<line>` placeholder, NOT a real number, so the checker skips them.)
   - Release history lives ONLY in `kb/changelog.md`; `kb/overview.md` keeps a
     one-line `last indexed: <date>` and nothing more — don't duplicate history.
   - Don't rely on discipline — run `tools/kb-check.sh` (verifies all three pointer
     styles; `--fix` auto-repairs drifted line numbers by the name anchor;
     `--freshness` flags notes older than the code) via the sample
     `tools/hooks/pre-commit` or before release.

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
   - NO DRIFT: changed a value/name/contract that lives in MORE THAN ONE place? update
     every copy and search the old value to zero. A trap noted in a feature note also
     gets a stub in `kb/gotchas.md`; a multi-step procedure gets a `kb/runbooks/` note.
     End a code/config change with a "KB: updated <note>" / "no change needed" line.

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
# kb-check.sh — verify (and optionally auto-fix) the code pointers in kb/ so they
# keep resolving to real code instead of drifting silently. Handles the 3 pointer
# styles a KB actually uses:
#   A) markdown-link : [text](../rel.ext):LINE       path relative to the note's dir   [must resolve]
#   B) backtick path : `repo/rel.ext:LINE`            path relative to the repo root    [must resolve]
#   C) name-anchored : `name()`:LINE / `Name`:LINE    file = same-line md-link / (basename.ext) hint,
#                                                      else the note's primary file (its first link).
#                                                      The NAME is the anchor; the line is a hint.
#
# Drift test: a C pointer is STALE if the symbol it names is not on the cited line
# (catches the in-range case where code merely moved); A/B are checked for file +
# line-in-range. A name not found anywhere in its file is left unchecked (it's a
# cross-file mention, not a pointer). A/B that don't resolve are hard errors.
#
# Modes:
#   (none)        report only; exit 1 if any A/B pointer is broken
#   --fix         rewrite a drifted :line in place when the named symbol has ONE
#                 unambiguous definition in the file; report the rest
#   --freshness   also flag notes older (git mtime) than the code they cite
#
# Deps: bash, awk, grep, sed, wc, git, realpath. Run from the repo root:
#   bash tools/kb-check.sh [--fix|--freshness]
set -u
kb="kb"
[ -d "$kb" ] || { echo "run from the repo root (no kb/ here)"; exit 0; }
ROOT="$(pwd)"; MODE="${1:-}"
INDEX="$(mktemp)"; RECS="$(mktemp)"; FIXES="$(mktemp)"
trap 'rm -f "$INDEX" "$RECS" "$FIXES" "$FIXES.one"' EXIT
git ls-files >"$INDEX" 2>/dev/null || : >"$INDEX"

# ---- per-note awk pass -> TSV records:  note \t nline \t kind \t file \t cline \t sym \t raw
#      C falls back to the note's primary file ($def). sym = own name (C) / line's idents (A,B).
emit='
function join(d,r,  s,n,a,i,k,o,res){ s=d"/"r; n=split(s,a,"/"); k=0
  for(i=1;i<=n;i++){ if(a[i]==""||a[i]==".")continue; if(a[i]==".."){if(k>0)k--;continue} o[++k]=a[i] }
  res=""; for(i=1;i<=k;i++)res=(res==""?o[i]:res"/"o[i]); return res }
function last(s){ sub(/\([^()]*\)$/,"",s); sub(/.*\./,"",s); return s }
BEGIN{ while((getline l<idx)>0){ b=l; sub(/.*\//,"",b); cnt[b]++; pth[b]=l } }
{
  s=$0
  ids=""; t=s; while(match(t,/`[A-Za-z_][A-Za-z0-9_.]*(\(\))?`/)){ w=substr(t,RSTART,RLENGTH); t=substr(t,RSTART+RLENGTH)
    gsub(/`/,"",w); w=last(w); if(w!="") ids=(ids==""?w:ids","w) }
  ctx=""; if(match(s,/\]\([^)]+\)/)){ c=substr(s,RSTART,RLENGTH); sub(/^\]\(/,"",c); sub(/\)$/,"",c); ctx=join(dir,c) }
  hint=""; if(match(s,/\([A-Za-z0-9_]+\.[A-Za-z0-9_]+\)/)){ h=substr(s,RSTART,RLENGTH); gsub(/[()]/,"",h); if(cnt[h]==1) hint=pth[h] }
  t=s; while(match(t,/\]\([^)]+\.[A-Za-z0-9_]+\):[0-9]+/)){ m=substr(t,RSTART,RLENGTH); t=substr(t,RSTART+RLENGTH)
    rel=m; sub(/^\]\(/,"",rel); sub(/\):[0-9]+$/,"",rel); ln=m; sub(/.*:/,"",ln)
    print FILENAME"\t"FNR"\tA\t"join(dir,rel)"\t"ln"\t"ids"\t"m }
  t=s; while(match(t,/`[A-Za-z0-9_.\/-]+:[0-9]+`/)){ m=substr(t,RSTART,RLENGTH); t=substr(t,RSTART+RLENGTH)
    z=m; gsub(/`/,"",z); p=z; sub(/:[0-9]+$/,"",p); ln=z; sub(/.*:/,"",ln)
    if(p ~ /[\/.]/) print FILENAME"\t"FNR"\tB\t"p"\t"ln"\t"ids"\t"m }
  cf=(ctx!=""?ctx:(hint!=""?hint:def))
  t=s; while(match(t,/`[^`]+`:[0-9]+/)){ m=substr(t,RSTART,RLENGTH); t=substr(t,RSTART+RLENGTH)
    nm=m; sub(/`:[0-9]+$/,"",nm); sub(/^`/,"",nm); ln=m; sub(/.*:/,"",ln)
    print FILENAME"\t"FNR"\tC\t"cf"\t"ln"\t"last(nm)"\t"m }
}'

: >"$RECS"
while IFS= read -r note; do
  [ -n "$note" ] || continue
  ndir="$(dirname "$note")"
  def=""; rel="$(grep -oE '\]\([^)]+\.[A-Za-z0-9_]+\)' "$note" 2>/dev/null | head -1 | sed -E 's/^\]\(//; s/\)$//')"
  if [ -n "$rel" ]; then cand="$(cd "$ndir" && realpath -m "$rel" 2>/dev/null)"; case "$cand" in "$ROOT"/*) [ -f "$cand" ] && def="${cand#"$ROOT"/}";; esac; fi
  if [ -z "$def" ]; then bp="$(grep -oE '`[A-Za-z0-9_./-]+\.[A-Za-z0-9_]+:[0-9]+`' "$note" 2>/dev/null | head -1 | tr -d '`' | sed -E 's/:[0-9]+$//')"
    [ -n "$bp" ] && [ -f "$ROOT/$bp" ] && def="$bp"; fi
  awk -v idx="$INDEX" -v dir="$ndir" -v def="$def" "$emit" "$note" >>"$RECS"
done < <(git ls-files "$kb/*.md" 2>/dev/null || find "$kb" -name '*.md')

# escape a symbol for safe use inside an ERE
esc(){ sed 's/[][(){}.^$*+?\\|/]/\\&/g' <<<"$1"; }
# ---- unambiguous DEFINITION line of a symbol, else nothing. A definition is `name(...)`
#      followed by a body (`{`/`=>`/`async`), or `class/enum/... name` — never a bare call
#      (ends `;`), a `.name(` method call, or a // comment. Empty unless exactly one match.
declln(){ local f="$1" e; e="$(esc "$2")"
  grep -anE "(^|[^A-Za-z0-9_.])${e}[[:space:]]*\([^)]*\)[[:space:]]*((async|sync)\*?[[:space:]]*)?(\{|=>)|(class|enum|mixin|extension|typedef|abstract class)[[:space:]]+${e}([^A-Za-z0-9_]|$)" "$f" 2>/dev/null \
    | grep -vE "//.*${e}" \
    | cut -d: -f1 | sort -un | { mapfile -t L; [ "${#L[@]}" -eq 1 ] && [[ "${L[0]:-}" =~ ^[0-9]+$ ]] && echo "${L[0]}"; }; }

bad=0; ok=0; warn=0; skip=0; fixed=0; probs=""; warns=""
online(){ local e; e="$(esc "$3")"; sed -n "${2}p" "$1" | grep -aqE "(^|[^A-Za-z0-9_])$e([^A-Za-z0-9_]|$)"; }  # <file> <line> <sym>
infile(){ local e; e="$(esc "$2")"; grep -aqE "(^|[^A-Za-z0-9_])$e([^A-Za-z0-9_]|$)" "$1"; }                 # <file> <sym>
while IFS=$'\t' read -r note nl kind file cl sym raw; do
  [ -n "$file" ] || { skip=$((skip+1)); continue; }
  f="$ROOT/$file"
  if [ ! -f "$f" ]; then
    [ "$kind" = "C" ] && { skip=$((skip+1)); continue; }
    probs+="  x $note:$nl   $raw   — no such file: $file"$'\n'; bad=$((bad+1)); continue
  fi
  # a C name not present in the file is a cross-file mention, not a pointer here
  if [ "$kind" = "C" ] && [ -n "$sym" ] && ! infile "$f" "$sym"; then skip=$((skip+1)); continue; fi
  total=$(wc -l <"$f" | tr -d ' '); drift=""
  if [ "$cl" -gt "$total" ]; then drift="line $cl past end of file ($total lines)"
  elif [ "$kind" = "C" ] && [ -n "$sym" ]; then online "$f" "$cl" "$sym" || drift="\`$sym\` not on line $cl (moved)"
  else c="$(sed -n "${cl}p" "$f")"; [ -z "${c//[[:space:]]/}" ] && drift="line $cl is blank (anchor moved)"; fi
  [ -z "$drift" ] && { ok=$((ok+1)); continue; }

  newln=""; [ -n "$sym" ] && newln="$(declln "$f" "${sym%%,*}")"
  if [ -n "$newln" ] && [ "$newln" != "$cl" ]; then
    if [ "$MODE" = "--fix" ]; then printf '%s\t%s\t%s\t%s\n' "$note" "$nl" "$raw" "${raw%:*}:$newln" >>"$FIXES"; fixed=$((fixed+1))
    else warns+="  ~ $note:$nl   $raw   — $drift → looks like :$newln (run --fix)"$'\n'; warn=$((warn+1)); fi
  elif [ "$kind" = "C" ]; then skip=$((skip+1))   # can't relocate a name with no clear definition — advisory only
  else probs+="  x $note:$nl   $raw   — $drift"$'\n'; bad=$((bad+1)); fi
done <"$RECS"

if [ "$MODE" = "--fix" ] && [ -s "$FIXES" ]; then
  for note in $(cut -f1 "$FIXES" | sort -u); do
    awk -F'\t' -v N="$note" '$1==N{print $2"\t"$3"\t"$4}' "$FIXES" >"$FIXES.one"
    awk -v map="$FIXES.one" 'BEGIN{ while((getline l<map)>0){ split(l,a,"\t"); ol[a[1]]=a[2]; nw[a[1]]=a[3] } }
      { if(FNR in ol){ o=ol[FNR]; n=nw[FNR]; i=index($0,o); if(i>0) $0=substr($0,1,i-1) n substr($0,i+length(o)) } print }' \
      "$note" >"$note.tmp" && mv "$note.tmp" "$note"
    awk -F'\t' -v N="$note" '$1==N{print "  ~ fixed "$1"   "$3" → "$4}' "$FIXES"
  done
fi

[ -n "$probs" ] && { echo "BROKEN (explicit-file pointers):"; printf '%s' "$probs"; }
[ -n "$warns" ] && { echo "STALE (name-anchored — fix the line or grep the name):"; printf '%s' "$warns"; }

if [ "$MODE" = "--freshness" ]; then
  echo "freshness (note older than cited code):"
  awk -F'\t' '$4!=""{print $1"\t"$4}' "$RECS" | sort -u | while IFS=$'\t' read -r note file; do
    [ -f "$ROOT/$file" ] || continue
    nt=$(git log -1 --format=%ct -- "$note" 2>/dev/null); [ -n "$nt" ] || continue
    ct=$(git log -1 --format=%ct -- "$file" 2>/dev/null); [ -n "$ct" ] || continue
    [ "$ct" -gt "$nt" ] && echo "  ~ $note  — cites newer $file (re-check)"
  done
fi

echo "kb-check: checked $ok, fixed $fixed, warn $warn, skipped $skip (name-only), broken $bad."
[ "$bad" -eq 0 ] && exit 0 || exit 1
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

   Run `bash tools/kb-check.sh --fix` (auto-repairs drifted line numbers), then
   `bash tools/kb-check.sh` to confirm `broken 0`; tell the user how to install the
   hook (it is opt-in).
9. Bump the "last indexed" marker in `kb/overview.md`.

# RULES
- Incremental ONLY: do not regenerate unchanged KB files.
- Every `path:line` you add must come from code you actually OPENED — no guesses.
- Cross-link related notes with `[[other-note]]`; a note with no links is incomplete.
- Keep the `## Knowledge Base` section tight.

# OUTPUT
Before finishing, RUN `bash tools/kb-check.sh --fix` then `bash tools/kb-check.sh`
— this auto-repairs drifted line numbers, confirms the KB's pointers resolve, AND
proves you actually created the tool. If the command fails because the file is
missing, you skipped step 8: create `tools/kb-check.sh` and `tools/hooks/pre-commit`
now, then re-run it. Do NOT report done until it ends in `broken 0`. Then print a
short list of exactly what changed (including any `:line`s `--fix` corrected).
