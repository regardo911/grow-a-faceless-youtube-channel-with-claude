---
name: channel-short
description: Make one finished YouTube Short for this channel from a
  one-line idea, with its thumbnail and upload text. Use when I type
  /channel-short followed by an idea.
---

# One idea in, one finished Short out

Read CLAUDE.md first: the channel brief and the style sheet are the
rules. Work in videos/<slug>/ (slug = the idea in kebab-case), as its
own HyperFrames project. Do every step; stop and ask only if a step
fails twice.

1. Facts. Find 6 facts for the idea, each with a source I can open.
   Write sources.md (fact, source, the line from the source).
2. Script. Write script.txt, one sentence per line, 130 to 150
   words, by the brief's script rules, using only facts in sources.md.
3. Fact check (last). Check every factual line of script.txt against
   sources.md. Fix or cut any line that goes beyond its source. Write
   factcheck.md (line, source, PASS/FIX/CUT).
4. Voice. Voice each line on its own with npx -y hyperframes@0.9.64
   tts, then join them with 0.2 s of silence between lines (0.6 s at
   the start) into narr.wav. Report the length; it must be 45 to 55 s
   (fix with the gaps, never the words).
5. Timings. npx -y hyperframes@0.9.64 transcribe narr.wav --json.
   Give every SCRIPT word a time: match script words to transcript
   words in order, spread the times over any word the transcript
   wrote differently, and keep each line's words inside that line's
   real clip window from step 4. Save timing.json.
6. Scenes. One scene per script line, timed from timing.json. Write
   scenes.json (start, end, line, what is on screen).
7. Build. Build the video by the style sheet. Captions from
   timing.json. Play narr.wav.
8. Check and look. Run npx -y hyperframes@0.9.64 check and fix every
   error. Snapshot one frame per scene, look at them, and fix the 3
   worst problems.
9. Render. npx -y hyperframes@0.9.64 render -o short.mp4. Measure the
   loudness; if it's under -16 LUFS, bring the audio to -14 with
   ffmpeg loudnorm, video copied. Report size, length, render time.
10. Thumbnails. Three options by Template 3, as one-frame HyperFrames
    pages saved with snapshot: thumb-a.png, thumb-b.png, thumb-c.png.
11. Upload text. upload.json with the video file (step 9's final MP4,
    after the loudness fix), title (under 60 characters, ends with
    #shorts), description (2 lines plus the sources), 5 tags, and
    the AI-use answer left for me to confirm.
12. Report. One message: the files, the length, the render time, and
    the one thing you would still fix.
