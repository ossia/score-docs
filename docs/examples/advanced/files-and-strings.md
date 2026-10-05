---
layout: default
title: Files, strings and serialization
description: "Read text and bytes, transform lines, serialize values and record or replay device data."
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/files-and-strings.html
score: /examples/advanced/files-and-strings.zip
---

# Files, strings and serialization

![Object filter, Serialize and Deserialize connected beneath the device recording graph]({{ site.baseurl }}/assets/scores/thumbnails/examples-advanced-files-and-strings.png)

Read text and bytes, transform lines, serialize values and record or replay device data.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/files-and-strings.zip)

## Files and side effects

Open the ZIP directly in score. It bundles `fables.txt` and `sample.data`, referenced as `<PROJECT>:fables.txt` and `<PROJECT>:sample.data`. Use a writable project directory: the connected Write File process writes `<PROJECT>:output-%t.file` as transformed lines arrive. Its Mode is Write, not Append; events replace the current target file. `%t` inserts the date/time in the filename.

Start playback, press Read File's Read control to load sample.data, and inspect Data, Bytes, EOF, Success and Error. Read File Line is asynchronous; press Open to open fables.txt, then Beat metronome's quarter-note output drives Next. Rewind restarts line traversal. Its Line output is split on spaces, joined with `::`, and sent to the display and Write File. The bytes branch converts the original line to integer bytes and back to a string.

Regex receives each line with `FABLE.*([IXVLM]+)`. Compare Match, Groups, Matched, Unmatched and the capture-group display as headings and prose pass through. The regex engine uses RE2 syntax.

## Serialization and device playback

Change Vec2f to trigger two round trips. Object filter builds `{ name: "foo", x: .[0], y: .[1] }` for JSON Serialize → Deserialize. A parallel Text round trip uses the literal delimiter `, `; keep the serializer and parser delimiters consistent. The Jk Object filter add-on is required for the object-building branch.

The OSC device listens on UDP 9997 and sends to `127.0.0.1:9996`. An LFO and Value delay feed Pattern applier at `OSC:/foo.*`. CSV is saved in Playback mode, targeting `OSC:/bar.*`, with timestamped Colon-separated data from `<PROJECT>:recording.csv`. Pattern combiner displays the bar values.

`recording.csv` is not included in the archive. To exercise that branch, first choose Record mode and the `OSC:/foo.*` pattern to record the generated values to a writable file, then switch back to Playback and `OSC:/bar.*`. Do not interpret absent playback values as a failure of the separate file/string examples. Avoid overwriting an existing recording you want to keep.
