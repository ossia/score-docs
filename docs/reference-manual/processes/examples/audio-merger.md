---
layout: default
title: "Four-source Audio Merger"
description: "Assemble four sample sources into a multichannel stream and inspect its level."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/audio-merger.html
score: "/reference/processes/audio-merger.score"
---

# Four-source Audio Merger

Four Sound processes feed separate inputs of **Audio Merger**. The merged audio goes into RMS, then Signal display. This demonstrates channel assembly rather than a stereo summing mixer: the analysis receives the merged multichannel stream.

## Requirements

Install the `dirt-samples` library package. The saved sources are:

- `alex/001_drumx2.wav`
- `fest/000_foo.wav`
- `flick/002_10.wav`
- `koy/01_left.wav`

Each path is under `<LIBRARY>:packages/dirt-samples/`. No sample media is bundled with this loose score.

## Try it

Start playback and watch the RMS trace. Replace or mute one source to see its contribution to the analysis. To audition individual output channels, add an Audio Channel Extractor and explicitly route it to your audio output; do not assume the merger automatically downmixes all channels to stereo. Compare the [channel-extraction example]({{ site.baseurl }}/reference/process-examples/audio-channel-extractor.html).

[Download this example]({{ site.scores }}{{ page.score }})
