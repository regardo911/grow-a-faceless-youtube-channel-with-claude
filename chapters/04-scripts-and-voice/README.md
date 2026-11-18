# Chapter 4: Scripts People Watch to the End

Five script prompts with the fact check last, then five voice prompts. [`channel-brief.md`](channel-brief.md) is the channel's brain, the block at the bottom of the `CLAUDE.md` that `init` wrote; `setup-channel.sh` appends it. Change its Niche line to your Chapter 3 niche first.

## The five script prompts

`ex14` to `ex18` are Template 1 from Appendix A, one prompt per file. They ask for the brief's 130 to 150 words (my Chapter 4 run asked for 120 to 140) and have `[your niche]` and `[title]` slots where the book had the Moon. Fill the slots, then paste the five in order in one session.

| File | Example | Makes | Credit |
|---|---:|---|---|
| [`ex14-research.txt`](ex14-research.txt) | 14 | 8 facts, each with a source | |
| [`ex15-outline.txt`](ex15-outline.txt) | 15 | a 7-beat outline | @free_ai_guides |
| [`ex16-draft.txt`](ex16-draft.txt) | 16 | the narration | |
| [`ex17-retention-pass.txt`](ex17-retention-pass.txt) | 17 | the swipe-proof rewrite | |
| [`ex18-fact-check.txt`](ex18-fact-check.txt) | 18 | a PASS / FIX / CUT table and the final script | |

Never move the fact check: on my run the retention pass made a wrong line punchier, and only Example 18 caught it. For Example 17, add one sentence of your own and "Fit this line in without changing a word of it."

## The voice

| File | Example | Makes | Note |
|---|---:|---|---|
| [`ex19-three-voices.txt`](ex19-three-voices.txt) | 19 | the script in three Kokoro voices | a fourth, ElevenLabs, only if `ELEVENLABS_API_KEY` is in `.env` |
| [`ex20-emotion-tags.txt`](ex20-emotion-tags.txt) | 20 | a tagged script and `narr-tags.mp3` | needs a paid ElevenLabs key |
| [`ex21-pacing.txt`](ex21-pacing.txt) | 21 | `narr.wav`, one line at a time | @free_ai_guides |
| [`ex22-word-timings.txt`](ex22-word-timings.txt) | 22 | `timing.json` | fix added: "no time may be later than the length of narr.wav." |
| [`ex23-beat-map.txt`](ex23-beat-map.txt) | 23 | every sentence and pause, timed | |

Use Kokoro for your first 30 videos: it's free and you can monetize with it. Pick the voice a friend says sounds like a person, put its name in the brief's Voice line, and save ElevenLabs for a video that's already doing well.

Done when three scripts have a source line for every factual line, with a narration and a `timing.json` each.
