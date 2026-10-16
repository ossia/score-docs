---
layout: default
title: "Four-source Audio Merger"
description: "Keep four sound sources separate while carrying and monitoring them as one multichannel stream."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/audio-merger.html
score: "/reference/processes/audio-merger.zip"
---

# Four-source Audio Merger

![Four sound waveforms feeding Audio Merger, followed by RMS and four plotted level traces.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-audio-merger.png)

Keep several sounds together without collapsing them into a stereo mix. Here, **Audio Merger** gathers four sample sources into one multichannel stream, while an RMS display shows their activity separately. This is useful when a later stage needs to route, analyse or spatialize each sound independently.

The merger preserves channels rather than adding their waveforms together. Think of its output as a bundle of signals: the bundle can travel through one cable, but each channel still needs an intentional destination if you want to hear it.

## Try it

Open the ZIP directly in score; the four samples are included. Start playback and watch the level traces. Replace one source and compare which traces change: the other sources remain separate.

To listen, add an **Audio Channel Extractor** after the merger and route the selected channels to your audio output at a low level. Selecting a different range lets you audition another part of the bundle. Do not expect the merger to downmix every source automatically to stereo; compare the [channel-extraction example]({{ site.baseurl }}/reference/process-examples/audio-channel-extractor.html).

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

