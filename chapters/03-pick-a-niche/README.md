# Chapter 3: Pick a Niche That Already Pays

One afternoon, before you make anything: find the videos that beat their channel's size, then write the page that picks your niche. Every prompt reads public YouTube pages with yt-dlp, which needs no key:

```bash
brew install yt-dlp
```

| File | Example | Makes |
|---|---:|---|
| [`ex08-who-made-it-first.txt`](ex08-who-made-it-first.txt) | 8 | `search-moon.csv`, sorted by views per subscriber |
| [`ex09-rank-three-niches.txt`](ex09-rank-three-niches.txt) | 9 | one `outliers-<niche>.csv` per niche and a ranking |
| [`ex10-reverse-engineer-a-channel.txt`](ex10-reverse-engineer-a-channel.txt) | 10 | a one-page read-out of one channel |
| [`ex11-title-formulas.txt`](ex11-title-formulas.txt) | 11 | 3 to 5 title formulas |
| [`ex12-thumbnail-patterns.txt`](ex12-thumbnail-patterns.txt) | 12 | a thumbnail grid and a tally |
| [`ex13-thirty-ideas.txt`](ex13-thirty-ideas.txt) | 13 | 30 ranked ideas |
| [`niche-brief-prompt.txt`](niche-brief-prompt.txt) | | `niche-brief.md`, one page |

`ex08` adds the chapter's fix as its last line: "ignore any video under 10,000 views." Without it, two brand-new channels with a few hundred views topped my table.

Run them in order in one session and save Example 13's list as `ideas.md`; Chapter 8 takes its 7 weekly ideas from it. Make them yours by swapping the search phrase (Example 8), the niches and handles (9), the channel (10) and the "My niche" line (13). Your Chapter 2 render time goes in the brief prompt's `[N]`.

You're done when `niche-brief.md` names one niche and gives the reason in three counts: the median views per subscriber, how many videos beat their channel's size, and how long one video takes you to make.
