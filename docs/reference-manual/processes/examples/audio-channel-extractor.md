---
layout: default
title: "Extracting Channels from an Eight-channel Recording"
description: "Explore individual channels in a multichannel recording."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/audio-channel-extractor.html
score: "/reference/processes/audio-channel-extractor.zip"
---

# Extracting Channels from an Eight-channel Recording

![Eight-channel recording connected to Audio Channel Extractor, RMS and a multichannel signal display.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-audio-channel-extractor.png)

This example lets you isolate part of an eight-channel recording and see when those channels are active. **Audio Channel Extractor** selects a range, and an RMS display shows its level over time.

The included recording is `Audio/8_Channel_ID.wv`; First channel and Last channel are initially set to 3 and 6. The example monitors the extracted audio rather than connecting eight loudspeakers.

## Try it

Open the ZIP directly in score. Start playback and observe the RMS display as the channel-identification recording progresses. Change the first and last channel controls to a smaller range and compare which parts of the recording remain visible.

For an audible comparison, explicitly connect the extracted audio to the desired hardware output channels and start at a low level. The root interval retains `audio:/out/main`, but the demonstrated cable path ends in analysis. The archive supplies the multichannel recording; no external sample package is needed.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

