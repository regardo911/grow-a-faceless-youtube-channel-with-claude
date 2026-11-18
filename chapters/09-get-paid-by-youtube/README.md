# Chapter 9: Get Paid by YouTube

A revenue model from your own numbers, and a Sunday loop where Claude reads last week and picks next week.

The model. After your first full week of posting, paste [`revenue-model-prompt.txt`](revenue-model-prompt.txt) with every bracket replaced by your own number (Studio for views and subscribers, your plan for the rest), RPM blank until you're paid. It fills `revenue-model.md` (the blank [Appendix B sheet](revenue-model.md), already in your folder). Re-run it monthly and read any date past month 6 as a direction.

The loop. Export your week from YouTube Studio (Analytics, Advanced mode, Export current view, CSV) and save it in your channel folder as `last-week.csv`.

| File | Example | Makes |
|---|---:|---|
| [`ex72-read-last-week.txt`](ex72-read-last-week.txt) | 72 | a 5-line read-out of `last-week.csv` |
| [`ex73-next-seven-topics.txt`](ex73-next-seven-topics.txt) | 73 | next week's 7 Shorts |
| [`retention-py-prompt.txt`](retention-py-prompt.txt) | 74 | `retention.py`, which pulls one video's retention curve |
| [`ex74-drop-off-second.txt`](ex74-drop-off-second.txt) | 74 | the second viewers leave, and the line spoken there |
| [`ex75-compare-hooks.txt`](ex75-compare-hooks.txt) | 75 | which first line kept more viewers |
| [`ex76-originality-pass.txt`](ex76-originality-pass.txt) | 76 | what's really different across the week's 7 |
| [`weekly-loop-prompt.txt`](weekly-loop-prompt.txt) | | `week-NN.md` and an updated `revenue-model.md` |

`retention.py` needs the YouTube Analytics API switched on in your Google project and its own sign-in (`yt-analytics.readonly` and `youtube.readonly`). In Example 74, put in your own video length and line start times from `timing.json`. Give Example 76 the scripts, not just the titles.

To build `weekly.md`, the one prompt file the loop reads, join the five example prompts:

```bash
cat ex72-*.txt ex73-*.txt ex74-*.txt ex75-*.txt ex76-*.txt > ~/my-channel/weekly.md
```

Then paste `weekly-loop-prompt.txt` in your Sunday sitting, before you approve the week's scripts.

## Practice files

[`samples/`](samples/) holds the three files the examples ran on, built by hand as practice numbers, not a real channel. To try the prompts before you have a week of your own, copy them into your channel folder and use the SAMPLE name in each prompt. The export and the hooks file disagree about v01. That's my slip, and Example 75 shows Claude catching it.

Done when you have a month-by-month model from your own numbers, and next week's seven topics each point at a real video from your export.
