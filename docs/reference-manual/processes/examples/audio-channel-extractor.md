---
layout: default
title: "Extracting Channels from an Eight-channel Recording"
description: "Select part of an eight-channel recording and follow its activity before routing it to speakers."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/audio-channel-extractor.html
score: "/reference/processes/audio-channel-extractor.zip"
---

# Extracting Channels from an Eight-channel Recording

![Eight-channel recording connected to Audio Channel Extractor, RMS and a multichannel signal display.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-audio-channel-extractor.png)

Isolate a few channels from a multichannel recording before deciding where to send them. **Audio Channel Extractor** selects a contiguous range from the included eight-channel identification recording; the level traces reveal when the selected channels are active. This is a useful check when preparing a multichannel installation or untangling a recording's channel order.

The First channel and Last channel controls start at 3 and 6. The extracted audio feeds analysis rather than a loudspeaker setup, so the initial result is visual.

## Try it

Open the ZIP directly in score and start playback. Follow the level traces as the recording identifies its channels, then narrow the selection with First channel and Last channel. Compare which events remain: selection removes channels from the bundle rather than mixing them together.

For an audible comparison, explicitly connect the extracted audio to the intended hardware output channels and start at a low level. The recording is included; no external sample package or eight-speaker system is needed to explore the displays.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

