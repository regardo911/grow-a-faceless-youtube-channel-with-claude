# Chapter 2: Your Whole Channel Stack

Install once, about 15 minutes, most of it downloads. These are the book's lines, in the book's order. Paste each into your Mac's Terminal and wait for the prompt to come back before the next one.

## The install lines

**1. Claude Code** (Pro plan or higher). Then type `claude` and sign in.

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

**2. Homebrew**, only if your Mac answers `brew` with "command not found". Run the lines it prints under "Next steps" when it finishes.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then the three tools:

```bash
brew install node ffmpeg python@3.13
```

**3. The HyperFrames skill for Claude Code.** Name it at the start of a build: "Using /hyperframes" (or `/hyperframes:hyperframes` if Claude can't find it).

```bash
claude plugin marketplace add heygen-com/hyperframes
claude plugin install hyperframes@hyperframes
```

**4. Your channel's project folder.** `../../setup-channel.sh ~/my-channel` runs this `init` line for you if the folder doesn't exist yet.

```bash
npx -y hyperframes@0.9.64 init my-channel --resolution portrait --non-interactive
cd my-channel
```

**5. The free voice.**

```bash
python3.13 -m venv ~/hf-voice
~/hf-voice/bin/pip install kokoro-onnx soundfile
export HYPERFRAMES_PYTHON=~/hf-voice/bin/python
```

So it survives a restart:

```bash
echo 'export HYPERFRAMES_PYTHON=~/hf-voice/bin/python' >> ~/.zshrc
```

Test it. My Mac printed `Generated 4.0s of speech` in about 2.5 seconds.

```bash
npx -y hyperframes@0.9.64 tts "What if the Moon vanished tonight? The tides would shrink by about two thirds." -o narr.wav
```

**6. Word timings.** Writes `transcript.json`. The first run on a fresh Mac installs the speech recognizer, so it takes longer.

```bash
npx -y hyperframes@0.9.64 transcribe narr.wav --json
```

## The test clip, four ways

| File | Example | Makes | My run | Note |
|---|---:|---|---|---|
| [`ex04-test-clip-hyperframes.txt`](ex04-test-clip-hyperframes.txt) | 4 | the 5-second test clip | 5 s, 3.1 s render | fix added: "have the caption on screen from frame 0" |
| [`ex05-a-remotion-setup.txt`](ex05-a-remotion-setup.txt) | 5 | a Remotion project in `~/remotion-test` | | four Terminal lines; run these first |
| [`ex05-b-moonclip.txt`](ex05-b-moonclip.txt) | 5 | the same clip in Remotion | 5 s, 10.1 s | paste into `claude` inside `remotion-test` |
| [`ex06-plain-html-ffmpeg.txt`](ex06-plain-html-ffmpeg.txt) | 6 | the same clip with no framework | 5 s, 28.9 s | |
| [`cost-sheet-prompt.txt`](cost-sheet-prompt.txt) | | your `costs.md` | | fill the brackets |
| [`costs.md`](costs.md) | | the blank cost sheet (Appendix B) | | setup-channel.sh copies it in |

**Example 7** has no file: run `claude remote-control` in your channel folder, open the session on your phone, and paste Example 4's prompt with one line added at the end, "notify me when the render finishes."

Check the clip with this. You want `h264`, `1080`, `1920` and a duration of `5.000000`:

```bash
ffprobe -v error -show_entries stream=codec_name,width,height,duration -of compact out.mp4
```

Done when your 5-second `out.mp4` plays with the caption on screen from the first frame and `costs.md` shows a dollar figure per video. Keep HyperFrames: it was the fastest of the three on my Mac, with the voice and timings built in.
