# Chapter 8: One Command, One Finished Video

[`channel-short/SKILL.md`](channel-short/SKILL.md) is Template 5, word for word: the 12-step skill with the five fixes from my test run that belong in a skill. The other two are the caption rules in the style sheet. `setup-channel.sh` puts it in your folder, and then one line makes a finished Short:

```text
/channel-short What if Earth spun twice as fast?
```

My run: a 54.9-second Short, three thumbnails and the upload text in 30 minutes 16 seconds, hands off.

## The files

| File | Example | Makes | Note |
|---|---:|---|---|
| [`ex64-a-write-the-skill.txt`](ex64-a-write-the-skill.txt) | 64 | your own `SKILL.md`, from your notes | optional: setup already gave you Template 5 |
| [`ex64-b-run-the-skill.txt`](ex64-b-run-the-skill.txt) | 64 | a finished Short | the one line above |
| [`ex65-upload-helper.txt`](ex65-upload-helper.txt) | 65 | your own `upload.py` | or use the one from my run, below; only its dry run was tested, a live upload needs your sign-in |
| [`ex66-daily-task.txt`](ex66-daily-task.txt) | 66 | the Desktop scheduled task's prompt | needs the Claude desktop app; fill `[No / Yes]` yourself |
| [`ex67-thumbnail-a.txt`](ex67-thumbnail-a.txt) | 67 | one object and a question | fix added: "a clear gap between the words and the object" |
| [`ex68-thumbnail-b.txt`](ex68-thumbnail-b.txt) | 68 | a before/after with one number | fix added: put "UP TO 85°" on the bar |
| [`ex69-thumbnail-c.txt`](ex69-thumbnail-c.txt) | 69 | one dramatic image | fix added: the Moon "dark grey, with a cream rim all the way round, fully inside the frame" |
| [`template-3-thumbnails.txt`](template-3-thumbnails.txt) | | all three options in one prompt | Template 3; the skill uses it at step 10 |
| [`ex70-search-text.txt`](ex70-search-text.txt) | 70 | titles, description and tags for search | |
| [`ex71-review-page.txt`](ex71-review-page.txt) | 71 | your own `review.html` | @orenmeetsworld's idea |
| [`sunday-prompt.txt`](sunday-prompt.txt) | | steps 1 to 3 for the week's 7 ideas | replace `[ideas]` with seven from `ideas.md` |

## What Claude wrote on my run

Your Claude writes its own versions. These are mine, to compare against or to use if yours breaks; copy them into your channel folder.

- [`upload.py`](upload.py) uploads one video from an `upload.json`. One fix: if `aiLabel` is missing it stops instead of sending No, because the AI-use answer is yours. The dry run needs only `python3`:

  ```bash
  python3 upload.py videos/<slug>/upload.json --dry-run
  ```

  [`upload.example.json`](upload.example.json) shows the fields; its date and `file` are examples. A live upload needs `google-api-python-client` and `google-auth-oauthlib` in a Python 3.13 venv, plus Chapter 8's one-time Google Cloud setup that leaves `client_secret.json` in the folder.
- [`review.html`](review.html) plays any MP4 you name in the address and pins notes to the second. Open it by double-clicking it, then add `?video=your-file.mp4` to the address. The tiny local server I tried broke the seeking and stamped every note 0:00.0. Save downloads `notes.json`; the next run reads it when you say "read notes.json first".

## The schedule

Set up the Desktop scheduled task with `ex66` as its prompt: Frequency Daily, Keep computer awake on, Permission mode Accept edits, then click Run now once and choose "always allow" for `npx`, `ffmpeg` and `python`. A closed lid means no post that day; if your laptop can't stay awake, upload all seven on Sunday with `publishAt` a day apart. Run `upload.py` once by hand every Sunday, because the Google sign-in expires on day 7 while your app is in Testing.

Done when one command makes a finished video with a thumbnail and upload text, the schedule posts three days in a row without you, and the Sunday renewal is on your calendar.
