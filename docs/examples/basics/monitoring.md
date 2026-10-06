---
layout: default
title: Monitoring values, MIDI, audio and textures
description: "An example showing how to monitor audio, video and control data"
parent: Basics
grand_parent: Examples
permalink: /examples/basics/monitoring.html
score: /examples/basics/monitoring.score
---

# Monitoring values, MIDI, audio and textures

![MIDI note, audio level, point and texture displays arranged beside their source processes]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-monitoring.png)

This example demonstrates how to observe the different kinds of data used in a score. Monitors make it easier to understand a patch and find out where an unexpected value or missing event originates.

## Overview

The examples cover MIDI notes, audio levels, numerical signals, points, colors and textures. Each display presents the same underlying information differently: an audio meter shows a level, a signal plot shows changes over time, and a point view interprets values as coordinates.

## Try it

Start playback in nodal view. No physical controller, sound file or network destination is needed.

- Compare the MIDI note display with the converted MIDI values. Watch the synth's VU meter and the plotted RMS envelope; the saved audio branch is not routed to speakers.
- Compare scalar, list and 2D signals. Try changing an automation and observe how its values appear as curves or moving points.
- Compare RGB01 and Lightness01 in the LED Views: one groups components into colors, while the other displays individual intensities.
- Press Bang, then hold Button, to compare a single impulse with repeated messages in Pulse View.
- Inspect the generated LED patterns and the shader texture preview.

Synthimi is required for the audio-analysis example. The texture preview uses the default library's `GLSL_shaders/sophia-digital-art/colors.fs` shader and score's native graphics processing; it does not require a separate Window device.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

