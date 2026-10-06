---
layout: default
title: Cues, loops and exclusive playback
description: "An example showing how to organize and trigger audio and visual cues"
parent: Basics
grand_parent: Examples
permalink: /examples/basics/cues.html
score: /examples/basics/cues.zip
---

# Cues, loops and exclusive playback

![Play-once and repeating color automations beside tween comparisons and audio cue intervals]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-cues.png)

This example demonstrates cue-based performance: recalling settings, repeating gestures and choosing whether audio clips can overlap. A visual preview makes parameter changes easy to compare with the timing of their cues.

## Visual cues and transitions

Open the ZIP directly in score and start playback. The shader image responds to color, intensity and blur settings stored in the OSC device tree; no external OSC application is required.

- Trigger `Send cue 1` and `Send cue 2` to recall different colors.
- Compare `Play once` with `Repeat`. One gesture ends with its interval; the other loops until you trigger its end.
- Try the independent intensity cues, then the connected sequence. Independent cues let you choose freely, whereas the sequence imposes an order and timing bounds.
- Change the blur manually, then compare `Tween 1`, `Tween 2` and `No tween`. Tween begins from the current value rather than jumping to the curve's initial setting.

The preview uses score's native ISF shaders, not Qt Quick 3D. For external control, the saved OSC device listens on UDP 9997 and sends to `127.0.0.1:9996`.

## Audio cues and loops

Configure audio output and begin at a low level; the sound files are bundled in the archive. Open `Scenario-nonexclusive` and trigger several sound intervals to hear them overlap. Then compare `Scenario-exclusive`, where starting one interval stops the others in that scenario.

Loop switches use the root interval's bar quantization, so a requested change waits for a musical boundary. Try requesting a switch at different points in a bar and listen to when it takes effect.

The annotations also introduce root start and stop states for initialization and shutdown cues. Compare ordinary Stop with Stop and reinitialize: they do not recall the same state.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

