#!/usr/bin/env bash
# runs setup-channel.sh against throwaway folders. offline: every folder is pre-made,
# so init (the one step that needs the network) never runs.
# each check is a string eval'd when it runs, so its $vars are meant to stay unexpanded here
# shellcheck disable=SC2016,SC2034
set -uo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd)
setup="$repo/setup-channel.sh"
ch="$repo/chapters"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

pass=0 fail=0
ok()  { pass=$((pass + 1)); echo "  ok    $1"; }
bad() { fail=$((fail + 1)); echo "  FAIL  $1"; }
check() { if eval "$2"; then ok "$1"; else bad "$1"; fi; }
count() { grep -cF "$1" "$2" 2>/dev/null || true; }

echo "first run on a folder init already made"
c="$tmp/my-channel"; mkdir -p "$c"
printf '# HyperFrames rules\nstand-in line that init wrote\n' > "$c/CLAUDE.md"
out=$(bash "$setup" "$c" 2>&1); code=$?
check "exits 0" '[ $code -eq 0 ]'
check "init's CLAUDE.md kept, not replaced" 'grep -q "stand-in line that init wrote" "$c/CLAUDE.md"'
check "brief heading in CLAUDE.md once" '[ "$(count "## Channel brief" "$c/CLAUDE.md")" = 1 ]'
check "style sheet heading in CLAUDE.md once" '[ "$(count "## Style sheet (every Short)" "$c/CLAUDE.md")" = 1 ]'
check "brief sits above the style sheet" '[ "$(grep -nF "## Channel brief" "$c/CLAUDE.md" | cut -d: -f1)" -lt "$(grep -nF "## Style sheet" "$c/CLAUDE.md" | cut -d: -f1)" ]'
check "the whole brief went in" 'grep -qF "My angle: I explain the mechanism on screen" "$c/CLAUDE.md"'
check "the whole style sheet went in" 'grep -qF "Match the look of refs/*.png." "$c/CLAUDE.md"'
check "SKILL.md byte-identical to the repo's" 'cmp -s "$ch/08-one-command-one-video/channel-short/SKILL.md" "$c/.claude/skills/channel-short/SKILL.md"'
check "costs.md copied" 'cmp -s "$ch/02-your-channel-stack/costs.md" "$c/costs.md"'
check "revenue-model.md copied" 'cmp -s "$ch/09-get-paid-by-youtube/revenue-model.md" "$c/revenue-model.md"'
check "prices.md copied" 'cmp -s "$ch/10-paid-before-youtube-pays/prices.md" "$c/prices.md"'
for d in videos/approved videos/posted refs; do check "$d/ made" '[ -d "$c/$d" ]'; done
check "prints the next step" 'printf "%s" "$out" | grep -qF "/channel-short What if Earth spun twice as fast?"'

echo "second run, after the reader edited a sheet"
echo "| my own row |" >> "$c/costs.md"
before=$(cat "$c/CLAUDE.md")
out=$(bash "$setup" "$c" 2>&1); code=$?
check "exits 0" '[ $code -eq 0 ]'
check "CLAUDE.md unchanged" '[ "$(cat "$c/CLAUDE.md")" = "$before" ]'
check "brief still once" '[ "$(count "## Channel brief" "$c/CLAUDE.md")" = 1 ]'
check "style sheet still once" '[ "$(count "## Style sheet (every Short)" "$c/CLAUDE.md")" = 1 ]'
check "the reader's edit to costs.md survived" 'grep -qF "| my own row |" "$c/costs.md"'
check "says kept for files already there" 'printf "%s" "$out" | grep -qF "kept   costs.md (already there)"'

echo "a folder with a space in its name"
s="$tmp/my channel"; mkdir -p "$s"; printf 'init rules\n' > "$s/CLAUDE.md"
bash "$setup" "$s" >/dev/null 2>&1; code=$?
check "exits 0" '[ $code -eq 0 ]'
check "skill in place" '[ -f "$s/.claude/skills/channel-short/SKILL.md" ]'
check "brief added" '[ "$(count "## Channel brief" "$s/CLAUDE.md")" = 1 ]'

echo "a folder with no CLAUDE.md"
n="$tmp/no-claude-md"; mkdir -p "$n"
out=$(bash "$setup" "$n" 2>&1); code=$?
check "exits 0" '[ $code -eq 0 ]'
check "CLAUDE.md made with both blocks" '[ "$(count "## Channel brief" "$n/CLAUDE.md")" = 1 ] && [ "$(count "## Style sheet (every Short)" "$n/CLAUDE.md")" = 1 ]'
check "says it made CLAUDE.md" 'printf "%s" "$out" | grep -qF "made   CLAUDE.md"'

echo "a new folder and no npx on PATH"
bin="$tmp/bin"; mkdir -p "$bin"
# only what the script needs, so a node install on this machine can't leak in
for t in bash env dirname basename cat grep cp mkdir; do ln -s "$(command -v "$t")" "$bin/$t"; done
out=$(PATH="$bin" "$bin/bash" "$setup" "$tmp/brand-new" 2>&1); code=$?
check "exits non-zero" '[ $code -ne 0 ]'
check "points at Chapter 2's install line" 'printf "%s" "$out" | grep -qF "brew install node ffmpeg python@3.13"'
check "made no folder" '[ ! -e "$tmp/brand-new" ]'

echo "pointed at the repo itself"
bash "$setup" "$repo" >/dev/null 2>&1; code=$?
check "refuses" '[ $code -ne 0 ]'
check "wrote nothing into the repo" '[ ! -e "$repo/.claude" ] && [ ! -e "$repo/CLAUDE.md" ]'

echo
echo "$pass checks passed, $fail failed"
[ "$fail" -eq 0 ] && [ "$pass" -gt 0 ]
