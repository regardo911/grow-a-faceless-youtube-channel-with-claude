# Chapter 7: A Full 7-Minute YouTube Video

Save [`ex52-directors-brief.txt`](ex52-directors-brief.txt) as `brief.md` in the video's own folder, change "THE FILM IN ONE LINE" to yours, and approve the scene plan at gate 1 before anything renders. Then work down the list in order.

| File | Example | Makes | Note |
|---|---:|---|---|
| [`ex52-directors-brief.txt`](ex52-directors-brief.txt) | 52 | `brief.md` and a scene plan | lines from @0xMovez and @renproton |
| no file | 53 | the long script and narration | see below |
| [`ex54-shot-list.txt`](ex54-shot-list.txt) | 54 | every shot, timed | @Y0urDumble; fix added: "no shot longer than 15 seconds" |
| [`ex55-two-minute-chunks.txt`](ex55-two-minute-chunks.txt) | 55 | 4 chunks, their render commands, a storyboard | fix added: "move each boundary to the nearest pause in timing.json." |
| no file | 56 | chunk 1, rendered | see below |
| [`ex57-archive-images.txt`](ex57-archive-images.txt) | 57 | two photos you may use, with usage lines in `sources.md` | |
| [`ex58-lower-third.txt`](ex58-lower-third.txt) | 58 | a name bar, last chunk re-rendered | |
| [`ex59-mechanism-diagram.txt`](ex59-mechanism-diagram.txt) | 59 | the diagram that explains the idea | |
| [`ex60-blender-prop.txt`](ex60-blender-prop.txt) | 60 | a 3D prop and a 6-angle look sheet (optional) | @renproton; the `mcp-for-blender` README |
| [`ex61-loudness-and-mix.txt`](ex61-loudness-and-mix.txt) | 61 | the film at -14 LUFS | |
| [`ex62-taste-pass-1.txt`](ex62-taste-pass-1.txt) | 62 | a list of every boring stretch, nothing fixed | |
| [`ex63-taste-pass-2.txt`](ex63-taste-pass-2.txt) | 63 | the fixes and one whole-film render | fix added: "never join two sentences in one caption." |

Example 53 is Chapter 4's five prompts with three changes: "900 to 1,000 words", "four parts: cold open, three chapters with a spoken chapter title, close", and "a new fact or turn at least every 30 seconds." The narration should land between 6:30 and 7:30 before you build anything.

Example 56 is the chunk 1 command, then "Make a contact sheet of the chunk, one frame every 10 seconds."

```bash
npx -y hyperframes@0.9.64 render --start 0 --end 120 -o chunk-0.mp4
```

Render the whole film in one piece for the final (half the time of four chunks on my Mac) and keep chunks for fixing one part. After Example 62, pick the three problems a viewer would notice first and rewrite the first line of `ex63` to name them; mine names a beetle, a coral reef and a static frame.

## The Blender route (optional)

`ex60` runs Blender headless and needs only Blender. To let Claude work in the Blender window instead, `brew install uv`, then run these with your Blender version in place of `5.3`:

```bash
mkdir -p ~/Library/Application\ Support/Blender/5.3/scripts/addons
claude mcp add blender uvx mcp-for-blender
uvx mcp-for-blender install-addon
```

In Blender: Edit → Preferences → Add-ons, search "MCP", tick MCP for Blender. Press N in the 3D view and open the MCP for Blender tab. It should say Connected on localhost:9876.

Done when the full video renders whole, plays start to finish with captions in sync, and your cost sheet shows its machine time and the plan usage you measured with `/usage` before the brief and after the final render.
