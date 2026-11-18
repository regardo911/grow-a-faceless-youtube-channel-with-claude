# Chapter 6: Animated and 3D Shorts Drawn in Code

Twenty style prompts, one per look, then the style sheet that turns them into one channel.

## The style sheet

[`style-sheet.md`](style-sheet.md) is my channel-1 sheet; `setup-channel.sh` appends it to your `CLAUDE.md` under the brief. It adds three lines the chapter tells you to write in: Template 2's caption wording ([BOOK-FIXES.md](../../BOOK-FIXES.md)), "On a yellow subject, the keyword is white", and "Match the look of refs/*.png." Change the hex codes and font to your look, or start from the blank [`template-2-style-sheet.txt`](template-2-style-sheet.txt).

For `refs/`, paste: "Save one PNG frame from each of these videos into refs/: [video] at [second], [video] at [second], [video] at [second]."

## The twenty styles

Swap the subject and captions for your niche; keep the look, motion and format lines. The last column names the matching `claude-animation-skills` command where the book gives one.

| File | Example | Style | Credit or command |
|---|---:|---|---|
| [`ex32-3d-cartoon-rings.txt`](ex32-3d-cartoon-rings.txt) | 32 | 3D cartoon "what if" (the five-part skeleton, parts marked) | |
| [`ex33-map-route.txt`](ex33-map-route.txt) | 33 | a map where the route draws itself | `/map-route` |
| [`ex34-stick-figures.txt`](ex34-stick-figures.txt) | 34 | stick figures | `/stick-figure` |
| [`ex35-isometric.txt`](ex35-isometric.txt) | 35 | isometric figures | |
| [`ex36-kinetic-type.txt`](ex36-kinetic-type.txt) | 36 | kinetic type | |
| [`ex37-paper-and-paint.txt`](ex37-paper-and-paint.txt) | 37 | paper texture and paint, drawn in code | |
| [`ex38-a-design-a-cast.txt`](ex38-a-design-a-cast.txt) | 38 | design a two-character cast (run first) | @free_ai_guides' cast prompt, adapted |
| [`ex38-b-bean-short.txt`](ex38-b-bean-short.txt) | 38 | a Short with two original characters | |
| [`ex39-particles.txt`](ex39-particles.txt) | 39 | particles | |
| [`ex40-physics.txt`](ex40-physics.txt) | 40 | physics | |
| [`ex41-parallax.txt`](ex41-parallax.txt) | 41 | 2.5D parallax | |
| [`ex42-chart.txt`](ex42-chart.txt) | 42 | a chart that draws itself | `/graph` |
| [`ex43-style-from-a-reference.txt`](ex43-style-from-a-reference.txt) | 43 | a style copied from a reference clip | @Y0urDumble's reference prompt, trimmed |
| [`ex44-low-poly.txt`](ex44-low-poly.txt) | 44 | low-poly 3D | `/low-poly` |
| [`ex45-voxel.txt`](ex45-voxel.txt) | 45 | voxel blocks | |
| [`ex46-flat-vector.txt`](ex46-flat-vector.txt) | 46 | flat-vector space explainer | |
| [`ex47-ink-line-art.txt`](ex47-ink-line-art.txt) | 47 | black ink line art | `/minimalistic-graphics` |
| [`ex48-exploded-cutaway.txt`](ex48-exploded-cutaway.txt) | 48 | exploded 3D cutaway | `/breakdown` |
| [`ex49-log-scale-zoom.txt`](ex49-log-scale-zoom.txt) | 49 | a log-scale zoom | |
| [`ex50-whiteboard.txt`](ex50-whiteboard.txt) | 50 | whiteboard marker | |
| [`ex51-morph-loop.txt`](ex51-morph-loop.txt) | 51 | one shape that morphs and loops | |

Point Example 43 at a video of your own; mine used my Example 1 clip, `moon-3d.mp4`. And watch every render asking "is that what happens?" My whiteboard lever tipped the wrong way while every frame looked fine.

## The optional command collection

Don't skip the middle line, or the install hangs at "installing Playwright's Chromium". It's done when it prints "ready".

```bash
git clone https://github.com/artemnovitckii/claude-animation-skills.git ~/claude-animation-skills
cd ~/claude-animation-skills/kit && npm install playwright@1.65.1
cd ~/claude-animation-skills && ./install.sh
```

## The seven Shorts

Run the Chapter 4 and 5 steps on ideas 2 to 8, with this line at the top of every build prompt: "Follow the style sheet in CLAUDE.md and match refs/*.png." Done when seven Shorts share one look, and no two share a storyline and ending or an opening shot.
