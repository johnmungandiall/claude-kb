#!/usr/bin/env bash
# kb-check.sh — make KB maintenance depend on automation, not memory.
#
# Checks every `path:line` pointer in kb/ actually resolves (file exists + line in
# range), so drift is caught by a script instead of by discipline. With
# --freshness it also flags notes that look older than the code they point to,
# derived from git (no hand-stamped dates).
#
# No dependencies beyond what git-bash already ships (grep/sed/sort/wc/git).
# Usage, from the repo root:
#   bash tools/kb-check.sh              # pointer resolve check (exits 1 on failure)
#   bash tools/kb-check.sh --freshness  # also flag git-stale notes (advisory)
#
# Pointer format it understands (and that the KB rules mandate): a backtick-wrapped
# full path from the repo root + ":" + a line number, e.g. `lib/foo/bar.dart:42`.
set -u

kb_dir="kb"
[ -d "$kb_dir" ] || { echo "no kb/ directory here — run from the repo root"; exit 0; }

# `path/with.ext:line` inside backticks (line ranges like :42-50 match the start).
ptr_re='`[A-Za-z0-9_./-]+\.[A-Za-z0-9_]+:[0-9]+'

problems=0
report() { echo "  ✗ $1"; problems=$((problems + 1)); }

echo "kb-check: resolving path:line pointers in $kb_dir/ ..."
while IFS= read -r hit; do
  note="${hit%%:*}"                       # kb/foo.md
  rest="${hit#*:}"; rest="${rest#*:}"     # strip "note:lineno:" → leaves the match
  ptr="${rest#\`}"                        # drop the leading backtick
  file="${ptr%:*}"
  ln="${ptr##*:}"
  if [ ! -f "$file" ]; then
    report "$note → \`$ptr\`  (file not found — use a full path from repo root)"
  else
    total=$(wc -l < "$file" | tr -d ' ')
    [ "$ln" -le "$total" ] || report "$note → \`$ptr\`  (file has only $total lines)"
  fi
done < <(grep -rnoE "$ptr_re" "$kb_dir" 2>/dev/null)

if [ "${1:-}" = "--freshness" ]; then
  echo "kb-check: git freshness (notes older than the code they point to) ..."
  find "$kb_dir" -name '*.md' | while IFS= read -r note; do
    note_t=$(git log -1 --format=%ct -- "$note" 2>/dev/null) || continue
    [ -n "$note_t" ] || continue
    grep -oE "$ptr_re" "$note" 2>/dev/null | sed -e 's/^`//' -e 's/:[0-9]*$//' \
      | sort -u | while IFS= read -r f; do
        [ -f "$f" ] || continue
        code_t=$(git log -1 --format=%ct -- "$f" 2>/dev/null)
        [ -n "$code_t" ] || continue
        [ "$code_t" -gt "$note_t" ] && echo "  ~ $note  (points to newer $f — re-check)"
      done
  done
fi

echo "---"
if [ "$problems" -eq 0 ]; then
  echo "kb-check: OK — all pointers resolve."
  exit 0
fi
echo "kb-check: $problems broken pointer(s) above."
exit 1
