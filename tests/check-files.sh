#!/usr/bin/env bash
# checks the file layout: every link in a README lands, every example has its file,
# and nothing in the repo would load into a reader's Claude Code session on clone.
# every path in this repo is ours and has no spaces, so word-splitting ls and grep output is fine
# shellcheck disable=SC2012,SC2013,SC2016
set -uo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd)
cd "$repo" || exit 2
pass=0 fail=0
ok()  { pass=$((pass + 1)); }
bad() { fail=$((fail + 1)); echo "  FAIL  $1"; }

echo "README links"
for readme in README.md BOOK-FIXES.md chapters/*/README.md; do
  dir=$(dirname "$readme")
  # relative markdown links only; web links and #anchors are skipped
  for link in $(grep -oE '\]\([^)#]+\)' "$readme" | sed -E 's/^\]\(//; s/\)$//' | grep -vE '^(https?|mailto):'); do
    if [ -e "$dir/$link" ]; then ok; else bad "$readme links to $link, which isn't there"; fi
  done
  # a file name in backticks that looks like one of ours must exist in that chapter folder
  for f in $(grep -oE '`(ex[0-9]{2,3}[a-z0-9-]*\.txt|template-[0-9][a-z0-9-]*\.txt|[a-z0-9-]+-prompt\.txt)`' "$readme" | tr -d '`' | sort -u); do
    if [ -e "$dir/$f" ] || [ -e "$f" ] || ls chapters/*/"$f" >/dev/null 2>&1; then ok; else bad "$readme names $f, which isn't in the repo"; fi
  done
done
echo "  $pass link and file-name checks so far"

echo "one file per example, Examples 1 to 100"
for n in $(seq 1 100); do
  nn=$(printf '%02d' "$n")
  files=$(ls chapters/*/ex"$nn"-*.txt 2>/dev/null | wc -l | tr -d ' ')
  pair=$(ls chapters/*/ex"$nn"-a-*.txt chapters/*/ex"$nn"-b-*.txt 2>/dev/null | wc -l | tr -d ' ')
  case $n in
    7|53|56)
      # printed as prose only: no file, and the chapter README says what to run instead
      if [ "$files" -eq 0 ] && grep -qE "Example $n([^0-9]|$)" chapters/*/README.md; then ok; else bad "Example $n: wants no file and a README line"; fi ;;
    *)
      if [ "$files" -eq 1 ] || { [ "$files" -eq 2 ] && [ "$pair" -eq 2 ]; }; then ok; else bad "Example $n: $files files"; fi ;;
  esac
done

echo "every chapter has a folder and a README"
for c in 01 02 03 04 05 06 07 08 09 10 11 12; do
  if ls -d chapters/"$c"-*/ >/dev/null 2>&1 && [ -f "$(ls -d chapters/"$c"-*/ | head -1)README.md" ]; then ok; else bad "chapter $c"; fi
done

echo "the files setup-channel.sh copies"
for f in chapters/04-scripts-and-voice/channel-brief.md chapters/06-animated-and-3d-shorts/style-sheet.md \
         chapters/08-one-command-one-video/channel-short/SKILL.md chapters/02-your-channel-stack/costs.md \
         chapters/09-get-paid-by-youtube/revenue-model.md chapters/10-paid-before-youtube-pays/prices.md; do
  if [ -s "$f" ]; then ok; else bad "$f missing or empty"; fi
done

echo "nothing that loads into a Claude Code session on clone"
hits=$(find . -path ./.git -prune -o \( -name CLAUDE.md -o -name .claude \) -print)
if [ -z "$hits" ]; then ok; else bad "found: $hits"; fi

echo "words that must not appear"
w='rec''eipt'   # split so this file doesn't trip its own check
if grep -rIil --exclude-dir=.git "$w" . >/dev/null || find . -path ./.git -prune -o -iname "*$w*" -print | grep -q .; then bad "the banned word for a cost"; else ok; fi
if grep -rIlF --exclude-dir=.git --exclude=check-files.sh '[COMPANION REPOSITORY' . >/dev/null; then bad "an unfilled placeholder"; else ok; fi

echo "prompt files hold only the prompt"
for f in chapters/*/*.txt; do
  # a header line would be pasted into Claude with the prompt
  if [ -s "$f" ] && ! head -1 "$f" | grep -qiE '^(# ?(example|ex ?[0-9]|chapter|prompt|file)|//|<!--)'; then ok; else bad "$f is empty or starts with a header"; fi
done

up=chapters/08-one-command-one-video/upload.py
if command -v python3 >/dev/null 2>&1; then
  echo "upload.py dry run (python3 found)"
  t=$(mktemp -d); trap 'rm -rf "$t"' EXIT
  printf 'stand-in' > "$t/short.mp4"
  python3 - "$t" <<'EOF'
import json, sys, pathlib
t = pathlib.Path(sys.argv[1])
cfg = json.load(open('chapters/08-one-command-one-video/upload.example.json'))
cfg['file'] = str(t / 'short.mp4')
(t / 'with.json').write_text(json.dumps(cfg))
cfg.pop('aiLabel')
(t / 'without.json').write_text(json.dumps(cfg))
EOF
  out=$(python3 "$up" "$t/with.json" --dry-run 2>&1); code=$?
  if [ $code -eq 0 ] && printf '%s' "$out" | grep -q '"containsSyntheticMedia": true'; then ok; else bad "dry run with aiLabel: $out"; fi
  if printf '%s' "$out" | grep -q '"privacyStatus": "private"'; then ok; else bad "a publishAt time should keep the video private"; fi
  out=$(python3 "$up" "$t/without.json" --dry-run 2>&1); code=$?
  if [ $code -ne 0 ] && printf '%s' "$out" | grep -q 'aiLabel'; then ok; else bad "no aiLabel should stop with a message naming it: $out"; fi
else
  echo "upload.py dry run skipped (no python3)"
fi

echo
echo "$pass checks passed, $fail failed"
[ "$fail" -eq 0 ] && [ "$pass" -gt 0 ]
