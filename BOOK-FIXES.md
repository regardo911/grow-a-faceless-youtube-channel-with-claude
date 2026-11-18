# Book fixes

Where the printed book doesn't work as written, what the repo does instead, and how to check it. The one-line prompt fixes the chapters print themselves are already in the prompt files; each chapter's README marks them.

## Chapter 6 and Chapter 12: the caption rule in both style sheets

Chapter 6's "Your Style Sheet" prints:

> Captions white, 68 px, 4 words at most per group, at y = 1000, right padding 220 px (clear of the Shorts buttons), each group on screen at least 1.0 s.

Chapter 8's skill test found that "4 words at most" and "at least 1.0 s each" can't both hold at 3.2 words a second, and Chapter 12, Example 95, says to use Template 2's rule in both sheets:

> each group on screen at least 1.0 s (a group may start a moment after its first word to get there), top at y = [N], left padding [N] px, right padding 220 px.

[`style-sheet.md`](chapters/06-animated-and-3d-shorts/style-sheet.md) and [`channel-2-style-sheet.md`](chapters/12-your-second-channel/channel-2-style-sheet.md) use Template 2's wording with each channel's numbers. The book gives no left-padding number for either channel, so both leave that clause out.

## Chapter 8, Examples 67 to 69: thumbnail size for a Short

The three prompts ask for "the Moon video at 3840x2160". Template 3, which the skill uses at step 10, says "at 3840x2160 (2160x3840 for a Short)".

The prompts are as printed plus the chapter's one-line fix at the end. [`template-3-thumbnails.txt`](chapters/08-one-command-one-video/template-3-thumbnails.txt) is as printed. For a Short, change the size in the prompt to 2160x3840.

## Chapter 8, Example 65: upload.py sends "No" for the AI-use answer when it's missing

Template 5, step 11, leaves the AI-use answer "for me to confirm", and Chapter 8's skill test lists hard-coding it as one of the seven mistakes. The `upload.py` from my run still read `"containsSyntheticMedia": cfg.get("aiLabel", False)`, so an `upload.json` without the field went up as No.

[`upload.py`](chapters/08-one-command-one-video/upload.py) stops with a message naming `aiLabel` when the field is missing, and `bash tests/check-files.sh` checks both cases. The rest of the file is as my run wrote it.

## Chapter 12, Example 97: the copy command "below" isn't printed

Example 97 says: "My copy command leaves it out on purpose (`--exclude videos`, below)." Search the book for `--exclude` or `rsync` and that sentence is the only hit. The copy happens in Example 98's prompt: "Copy my-channel to a new folder, channel-2, leaving out videos/."

[`ex98-clone-the-skill.txt`](chapters/12-your-second-channel/ex98-clone-the-skill.txt) is that prompt, as printed. It's the copy method.

## Chapter 12, Example 94: videos/moon-short.mp4 is never made

Example 94 breaks down `videos/moon-short.mp4`. No step writes that file: Chapter 5's loudness line writes `moon-final.mp4` in the folder root, and the Chapter 8 skill writes `videos/<slug>/short.mp4`.

[`ex94-break-down-a-video.txt`](chapters/12-your-second-channel/ex94-break-down-a-video.txt) is as printed. Change the path to your own final file before you paste it.
