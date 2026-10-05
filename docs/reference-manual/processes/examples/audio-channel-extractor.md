---
layout: default
title: "Extracting Channels from an Eight-channel Recording"
description: "Select a channel range and inspect it with RMS."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/audio-channel-extractor.html
score: "/reference/processes/audio-channel-extractor.zip"
---

# Extracting Channels from an Eight-channel Recording

The bundled `Audio/8_Channel_ID.wv` file feeds **Audio Channel Extractor**, followed by RMS and Signal display. The saved First channel and Last channel controls are 3 and 6. The graph is an analysis path, not eight separate loudspeaker connections.

## Try it

Open the ZIP directly in score. Start playback and observe the RMS display as the channel-identification recording progresses. Change the first and last channel controls to a smaller range and compare which parts of the recording remain visible.

For an audible comparison, explicitly connect the extracted audio to the desired hardware output channels and start at a low level. The root interval retains `audio:/out/main`, but the demonstrated cable path ends in analysis. The archive supplies the multichannel recording; no external sample package is needed.

[Download this example]({{ site.scores }}{{ page.score }})
