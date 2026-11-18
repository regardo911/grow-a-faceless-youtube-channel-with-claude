#!/usr/bin/env bash
# setup-channel.sh <channel-folder>
# turns a folder into the channel folder chapters 2, 4, 6 and 8 build by hand.
# adds to what's there, never overwrites. safe to run twice.
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
ch="$here/chapters"

if [ $# -ne 1 ] || [ -z "$1" ]; then
  echo "usage: ./setup-channel.sh <channel-folder>     e.g. ./setup-channel.sh ~/my-channel" >&2
  exit 2
fi

target=${1%/}
# a quoted "~/my-channel" reaches us unexpanded, so match the literal tilde
# shellcheck disable=SC2088
case "$target" in
  "~") target=$HOME ;;
  "~/"*) target="$HOME/${target#\~/}" ;;
esac

if [ ! -d "$target" ]; then
  if ! command -v npx >/dev/null 2>&1; then
    echo "npx not found. Do Chapter 2's install lines first (brew install node ffmpeg python@3.13), then run this again." >&2
    exit 1
  fi
  parent=$(dirname "$target")
  if [ ! -d "$parent" ]; then
    echo "$parent doesn't exist. Make it first, or pick a folder inside one that does." >&2
    exit 1
  fi
  # the book's chapter 2 line, run from the parent so init gets a bare folder name as printed
  echo "running Chapter 2's init for $target (the first run downloads HyperFrames)"
  (cd "$parent" && npx -y hyperframes@0.9.64 init "$(basename "$target")" --resolution portrait --non-interactive)
  [ -d "$target" ] || { echo "init finished but $target wasn't made. Run the Chapter 2 init line by hand and look at its output." >&2; exit 1; }
fi

target=$(cd "$target" && pwd)
if [ "$target" = "$here" ]; then
  echo "that's this repo. Point it at your channel folder, e.g. ~/my-channel" >&2
  exit 2
fi

echo "setting up $target"

# chapter 4: "Don't replace it. Add your brief to the bottom." the style sheet goes under it (chapter 6).
claude_md="$target/CLAUDE.md"
add_block() {
  local heading=$1 file=$2 from=$3
  if [ -f "$claude_md" ] && grep -qF "$heading" "$claude_md"; then
    echo "kept   CLAUDE.md: $heading (already there)"
    return
  fi
  # a blank line first, so the block never runs into the last line of the file
  if [ -s "$claude_md" ]; then printf '\n' >> "$claude_md"; fi
  cat "$file" >> "$claude_md"
  echo "added  CLAUDE.md: $heading  ($from)"
}
if [ ! -f "$claude_md" ]; then
  : > "$claude_md"
  echo "made   CLAUDE.md (there was none; init normally writes one)"
fi
add_block "## Channel brief" "$ch/04-scripts-and-voice/channel-brief.md" "Chapter 4"
add_block "## Style sheet (every Short)" "$ch/06-animated-and-3d-shorts/style-sheet.md" "Chapter 6"

place() {
  local from=$1 rel=$2 why=$3
  if [ -e "$target/$rel" ]; then
    echo "kept   $rel (already there)"
  else
    mkdir -p "$(dirname "$target/$rel")"
    cp "$from" "$target/$rel"
    echo "made   $rel  ($why)"
  fi
}
place "$ch/08-one-command-one-video/channel-short/SKILL.md" ".claude/skills/channel-short/SKILL.md" "Chapter 8, the /channel-short skill"
place "$ch/02-your-channel-stack/costs.md" "costs.md" "Chapter 2"
place "$ch/09-get-paid-by-youtube/revenue-model.md" "revenue-model.md" "Chapter 9"
place "$ch/10-paid-before-youtube-pays/prices.md" "prices.md" "Chapter 10"

for d in videos/approved videos/posted refs; do
  if [ -d "$target/$d" ]; then
    echo "kept   $d/ (already there)"
  else
    mkdir -p "$target/$d"
    echo "made   $d/"
  fi
done

cat <<EOF

Done. Before your first video:
  1. The brief and style sheet at the bottom of CLAUDE.md hold the book's space-channel values.
     Change the Niche line to yours (Chapter 3 finds it) and the hex codes to your look (Chapter 6).
  2. Put 3 reference frames in refs/ (Chapter 6).
  3. cd "$target" && claude
     then type:  /channel-short What if Earth spun twice as fast?
EOF
