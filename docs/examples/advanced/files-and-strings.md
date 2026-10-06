---
layout: default
title: Files, strings and serialization
description: "An example showing how to read, transform and record text and data"
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/files-and-strings.html
score: /examples/advanced/files-and-strings.zip
---

# Files, strings and serialization

![Object filter, Serialize and Deserialize connected beneath the device recording graph]({{ site.baseurl }}/assets/scores/thumbnails/examples-advanced-files-and-strings.png)

This example demonstrates working with text files and structured values in score. It brings together small experiments in transforming text, exchanging serialized data and recording device activity.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/files-and-strings.zip)

## Read and transform text

Open the ZIP directly in score. It includes `fables.txt` and `sample.data`. Use a writable project directory: the Write File process saves transformed lines to `<PROJECT>:output-%t.file`, with the date and time inserted in the filename. Its Write mode replaces the current target file rather than appending to it.

Start playback and try the two ways of reading a file:

- Press Read File's Read control to load the sample data. Inspect the result and status outputs.
- Press Read File Line's Open control to open the fables. The metronome advances through the text; Rewind returns to the beginning.

Compare each original line with the transformed text. Try another separator in the split-and-join example, or change the regular expression to select a different part of the text. The saved expression matches fable headings and captures their Roman numerals; the regex engine uses RE2 syntax. A separate conversion demonstrates reading a string as bytes and reconstructing it.

## Exchange structured values

Change Vec2f and compare JSON serialization with delimiter-separated text. The JSON example constructs an object, while the text example uses `, ` between components. Keep the serializer and parser delimiters consistent. The object-building example requires the Jk Object filter add-on.

## Record and replay device values

The device example records generated control values for later playback at other addresses. The saved CSV process is in Playback mode, but `recording.csv` is not included.

To try it, choose Record mode and the `OSC:/foo.*` pattern, and select a writable file. Then switch to Playback and `OSC:/bar.*` to inspect the replayed values. Avoid overwriting an existing recording you want to keep. Missing playback data does not prevent the independent text-file examples from running.

The OSC device listens on UDP 9997 and sends to `127.0.0.1:9996` if you also want to observe the values in another application.
