# Chapter 5: Your First Video, Live This Weekend

Eight prompts, pasted in order into one Claude session in your channel folder. Start with `script.txt`, `narr.wav` and `timing.json` from Chapter 4 in the folder.

| File | Example | Makes | Credit |
|---|---:|---|---|
| [`ex24-scene-list.txt`](ex24-scene-list.txt) | 24 | `scenes.json`, one scene per script line | |
| [`ex25-layout-stills.txt`](ex25-layout-stills.txt) | 25 | `index.html` and three stills, no render yet | @free_ai_guides (the no-repeated-text rule) |
| [`ex26-motion.txt`](ex26-motion.txt) | 26 | motion that starts on a word | |
| [`ex27-captions.txt`](ex27-captions.txt) | 27 | captions drawn in the video | |
| [`ex28-music-and-sound.txt`](ex28-music-and-sound.txt) | 28 | sound cues and a loudness reading | |
| [`ex29-render-and-look.txt`](ex29-render-and-look.txt) | 29 | `out.mp4` and a 12-frame contact sheet | @0xMovez |
| [`ex30-title-and-description.txt`](ex30-title-and-description.txt) | 30 | 5 titles and a description with sources | |
| [`ex31-upload-sheet.txt`](ex31-upload-sheet.txt) | 31 | `upload-sheet.md`, every Studio field | |

After Example 29, read the contact sheet yourself, fix the worst problem and render again. Then run the loudness line on that final render. The file it writes is the one you upload:

```bash
ffmpeg -y -i out.mp4 -c:v copy -af loudnorm=I=-14:TP=-1.5:LRA=11 -c:a aac -b:a 192k moon-final.mp4
```

Rename `moon-final.mp4` to your own video's name. My narration-led renders all came out around -20 LUFS, so this line belongs on every final.

Live means public on your channel, playing start to finish on your phone, with every caption on screen while its words are spoken. Set Visibility to Public before you close Studio, or it saves as private.
