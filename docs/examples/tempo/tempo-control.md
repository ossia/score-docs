---
layout: default

title: Tempo manipulation
description: "An example showing how to control and automate tempo"

parent: Tempo Examples
grand_parent: Examples

permalink: /examples/tempo/tempo-control.html
score: /examples/tempo/tempo.zip
---

# Tempo Manipulation

![Tempo Control Example]({{ site.img }}/examples/tempo/tempo.png "Tempo manipulation in ossia score")

This example demonstrates tempo control and musical timing features in ossia score.

## Overview

Variable tempo lets a composition accelerate, slow down or respond to a changing control signal. This example also compares inherited and local time signatures, and explores what happens to a recorded loop when its playback speed changes.

These techniques are useful for flexible musical arrangements and live performance: different sections can have their own timing, and a sound's pitch need not change whenever its duration does.

## Try it

Open the ZIP directly in score; it includes `Audio/000_AMEN.WAV`. Configure audio output at a low level. No external controller is required.

1. Start playback. `Parent signature` and `Custom signature` each contain a Metronome. Inspect their signature tracks: one follows the parent changes, while the other retains its local 4/4 during the parent's 3/4 section.
2. In `Re-pitching`, a Tempo curve changes the playback rate of the looping sound. Compare the following `Time-stretching` interval, which uses the same file with a different stretching mode. Listen for the difference in pitch as timing changes.
3. In `Speed`, an LFO varies the tempo between 20 and 120 BPM. Change its rate to compare a slow acceleration and deceleration with more rapid fluctuations. The BPM input overrides the drawn tempo while connected.
4. In `Free scrubbing`, select the Play tool with **P** and drag in the score background to explore playback position manually.

The sound processes retain a display name beginning `90bpm BlueB`, but the actual archive file is `Audio/000_AMEN.WAV`. Use the file inspector rather than the process label when relinking it. The separate LFO interval has an interactive end; stop the transport when finished.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Tempo]] - Tempo process reference
- [[Musical metrics]] - Time signatures, quantization, polyrhythm
- [[Scenario]] - Timeline container and timing
