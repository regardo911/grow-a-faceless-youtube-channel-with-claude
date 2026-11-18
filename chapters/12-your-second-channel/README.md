# Chapter 12: Your Second Channel by Day 30

Channel 2 is a copy of your channel folder with two files changed: the `CLAUDE.md` (niche, voice, angle and style sheet) and the skill's name. You don't run `setup-channel.sh` again; Example 98 makes the copy.

1. Rank the second niche with `ex93`. Then run Chapter 3's Example 13 and its brief prompt on it, saved as `ideas-ch2.md` and `niche-brief-ch2.md`, so channel 1's files stay as they are.
2. Break down a video you have the right to use with `ex94`. Change its `videos/moon-short.mp4` to your own final file first; no step in the book makes that one ([BOOK-FIXES.md](../../BOOK-FIXES.md)).
3. Write the new style sheet (`ex95`) and pick the voice (`ex96`).
4. Make the copy with `ex98`, then change the brief with `ex97`. Inside `channel-2/`, rename `ideas-ch2.md` and `niche-brief-ch2.md` to `ideas.md` and `niche-brief.md`, and delete `token.json` and `token-analytics.json` before channel 2's first upload, or `upload.py` posts to channel 1.
5. Make the first video step by step with `ex99`, then give channel 2 its own Desktop scheduled task an hour after channel 1's: Chapter 8's `ex66` with `/machine-short` in place of `/channel-short`. Make the same swap in `sunday-prompt.txt`.
6. Plan both channels with `ex100`.

## The prompts

| File | Example | Makes | Credit |
|---|---:|---|---|
| [`ex93-second-niche.txt`](ex93-second-niche.txt) | 93 | one niche, scored | |
| [`ex94-break-down-a-video.txt`](ex94-break-down-a-video.txt) | 94 | a shot-by-shot breakdown | `JuneYaooo/rea-video` |
| [`ex95-new-style-sheet.txt`](ex95-new-style-sheet.txt) | 95 | channel 2's style sheet | |
| [`channel-2-style-sheet.md`](channel-2-style-sheet.md) | 95 | what Example 95 wrote on my run, caption line fixed | |
| [`ex96-new-voice.txt`](ex96-new-voice.txt) | 96 | channel 2's narration in `bm_george` | |
| [`ex97-brand-swap.txt`](ex97-brand-swap.txt) | 97 | a brand file and a list of files that still mention channel 1 (my run edited 15 lines of CLAUDE.md instead) | |
| [`ex98-clone-the-skill.txt`](ex98-clone-the-skill.txt) | 98 | `channel-2/` without `videos/`, skill renamed `machine-short` | |
| [`ex99-channel-2-first-video.txt`](ex99-channel-2-first-video.txt) | 99 | channel 2's first Short | |
| [`ex100-next-30-days.txt`](ex100-next-30-days.txt) | 100 | 30 days of posts for both channels | |

Use `channel-2-style-sheet.md` in place of channel 1's sheet in `channel-2/CLAUDE.md` if you're building a machines channel, or as the model for your own.

Done when channel 2 has its first video live and its own daily schedule, and the 30-day plan covers both channels.
