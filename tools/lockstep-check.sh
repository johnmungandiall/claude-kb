#!/usr/bin/env bash
# lockstep-check.sh — verify THIS repo's duplicated (lockstep) blocks are still in
# sync, so a shared-block edit that missed a copy fails loudly instead of drifting
# silently. Repo-internal tooling: NOT shipped to target repos, NOT embedded in the
# prompts (that's kb-check.sh's job). The four sets it gates (see
# kb/runbooks/edit-a-prompt.md):
#   1) embedded kb-check.sh — first ```bash block in prompt.md / update.md / check.md
#      must byte-equal tools/kb-check.sh
#   2) about-kb template    — byte-identical in prompt.md + update.md
#   3) lean ## Knowledge Base block — prompt.md + update.md + slim.md (update.md's
#      "<keep existing …>" placeholders are the ONE allowed difference)
#   4) version marker       — kb/overview.md "last indexed … vN.N" == newest
#      kb/changelog.md entry's vN.N
# An extraction that comes back EMPTY is a hard error (a moved marker must not
# turn into a silent pass — the v2.9/v2.13 lesson).
#
# Deps: bash, awk, sed, diff, grep. Run from the repo root:
#   bash tools/lockstep-check.sh
set -u
[ -f "prompt.md" ] && [ -f "tools/kb-check.sh" ] || { echo "run from the claude-kb repo root"; exit 1; }
fail=0
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

say_ok()  { echo "  ok    $1"; }
say_bad() { echo "  DRIFT $1"; fail=1; }

# require a non-empty extraction, else hard-fail (marker moved / pattern broke)
need() { # $1=file $2=label
  [ -s "$1" ] || { echo "  ERROR $2: extracted nothing — marker moved? fix the marker or this script"; fail=1; return 1; }
}

# ---- 1) embedded kb-check.sh == tools/kb-check.sh -----------------------------
echo "[1/4] embedded kb-check.sh == tools/kb-check.sh"
for f in prompt.md update.md check.md; do
  awk '/^```bash$/{ if(!found){found=1; inb=1; next} } inb && /^```$/{ exit } inb{ print }' \
    "$f" >"$TMP/emb-$f"
  need "$TMP/emb-$f" "$f (bash block)" || continue
  if diff -q "$TMP/emb-$f" tools/kb-check.sh >/dev/null; then say_ok "$f"
  else say_bad "$f — embedded script differs from tools/kb-check.sh"; fi
done

# ---- 2) about-kb template identical in prompt.md + update.md -------------------
echo "[2/4] about-kb template: prompt.md == update.md"
for f in prompt.md update.md; do
  awk '/^   # About the KB/{ inb=1 } inb && /^   ```[ ]*$/{ exit } inb{ sub(/^   /,""); print }' \
    "$f" >"$TMP/tpl-$f"
  need "$TMP/tpl-$f" "$f (about-kb template)"
done
if diff -q "$TMP/tpl-prompt.md" "$TMP/tpl-update.md" >/dev/null 2>&1; then say_ok "byte-identical"
else say_bad "template differs (diff below)"; diff "$TMP/tpl-prompt.md" "$TMP/tpl-update.md" | sed 's/^/        /'; fi

# ---- 3) lean ## Knowledge Base block in prompt.md + update.md + slim.md --------
echo "[3/4] lean Knowledge Base block: prompt.md == update.md == slim.md"
for f in prompt.md update.md slim.md; do
  awk '/^   ## Knowledge Base \(read FIRST/{ inb=1 } inb && /^   ```[ ]*$/{ exit } inb{ sub(/^   /,""); print }' \
    "$f" >"$TMP/lean-$f"
  need "$TMP/lean-$f" "$f (lean block)"
done
# update.md alone says "keep existing" in the map placeholders — normalize that
sed -e 's/<keep existing 1-line>/<1-line>/' -e 's/<keep existing list>/<list feature notes>/' \
  "$TMP/lean-update.md" >"$TMP/lean-update-norm.md"
for pair in "update:$TMP/lean-update-norm.md" "slim:$TMP/lean-slim.md"; do
  name="${pair%%:*}"; file="${pair#*:}"
  if diff -q "$TMP/lean-prompt.md" "$file" >/dev/null 2>&1; then say_ok "prompt.md == ${name}.md"
  else say_bad "prompt.md vs ${name}.md (diff below)"; diff "$TMP/lean-prompt.md" "$file" | sed 's/^/        /'; fi
done

# ---- 4) overview version == newest changelog version ---------------------------
echo "[4/4] version marker: kb/overview.md == kb/changelog.md"
ov="$(grep -o 'v[0-9]\+\.[0-9]\+' kb/overview.md | head -1)"
cl="$(grep -o 'v[0-9]\+\.[0-9]\+' kb/changelog.md | head -1)"
if [ -z "$ov" ] || [ -z "$cl" ]; then
  echo "  ERROR version not found (overview='$ov' changelog='$cl')"; fail=1
elif [ "$ov" = "$cl" ]; then say_ok "$ov"
else say_bad "overview says $ov but newest changelog entry is $cl"; fi

[ "$fail" -eq 0 ] && { echo "lockstep-check: all sets in sync."; exit 0; }
echo "lockstep-check: DRIFT — fix every copy (kb/runbooks/edit-a-prompt.md) before committing."
exit 1
