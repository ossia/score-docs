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

The archive compares inherited and local time signatures, sound-file stretching modes, a tempo driven by another process, and manual scrubbing.

## Follow the sections

Open the ZIP directly in score; it includes `Audio/000_AMEN.WAV`. Configure audio output at a low level; all metronomes and sound files feed the parent mix at `audio:/out/main`. No external controller is required.

1. Start playback. `Parent signature` and `Custom signature` each contain a Metronome. Inspect their signature tracks: one follows the parent changes, while the other retains its local 4/4 during the parent's 3/4 section.
2. In `Re-pitching`, a Tempo curve changes the playback rate of the looping sound. Compare the following `Time-stretching` interval, which uses the same file with a different stretching mode. Listen for the difference in pitch as timing changes.
3. In `Speed`, follow LFO → Micromap → Tempo's BPM input. The expression `x * 100 + 20` maps the LFO into a 20–120 BPM control range, overriding the process's drawn tempo while connected.
4. In `Free scrubbing`, select the Play tool with **P** and drag in the score background to explore playback position manually.

The sound processes retain a display name beginning `90bpm BlueB`, but the actual archive file is `Audio/000_AMEN.WAV`. Use the file inspector rather than the process label when relinking it. The separate LFO interval has an interactive end; stop the transport when finished.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Tempo]] - Tempo process reference
- [[Musical metrics]] - Time signatures, quantization, polyrhythm
- [[Scenario]] - Timeline container and timing
