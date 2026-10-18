---
layout: default
title: Monitoring values, MIDI, audio and textures
description: "Use plots, meters and previews to see whether a patch is producing the data you intended."
parent: Basics
grand_parent: Examples
permalink: /examples/basics/monitoring.html
score: /examples/basics/monitoring.score
---

# Monitoring values, MIDI, audio and textures

![MIDI note, audio level, point and texture displays arranged beside their source processes]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-monitoring.png)

When a patch does not produce the expected sound or image, look at the signal before changing the artwork. This score places displays beside generated signals so you can distinguish a missing event, an unexpected range and a value interpreted in the wrong way.

## Overview

A meter answers “how strong is the sound?”, a plot answers “how does this value move?”, and a point view answers “where does this pair of values place something?”. The LED and texture previews make color and image data visible. These are observation tools you can reuse inside a performance patch, not additional media outputs to compose.

## Try it

Start playback in nodal view. No physical controller, sound file or network destination is needed.

- Watch the MIDI note display next to the converted MIDI values, then the synth's VU meter and plotted RMS envelope: a note event is instantaneous, while the resulting sound level rises and decays. The saved audio branch is not routed to speakers.
- Change an automation in the scalar, list or 2D examples. The same change appears as a curve or a moving point.
- Look at RGB01 and Lightness01 in the LED Views. One groups components into colors; the other treats them as separate intensities. An unexpected preview may be an interpretation problem, not bad input.
- Press Bang, then hold Button. Pulse View shows a single impulse for Bang and repeated messages for the held Button.
- Inspect the generated LED patterns and shader texture preview. Use the previews to check the result before adapting these signals to physical lights or a projection.

Synthimi is required for the audio-analysis branch. The texture preview uses the default library's `GLSL_shaders/sophia-digital-art/colors.fs` shader and score's native graphics processing; no separate Window device is needed.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

