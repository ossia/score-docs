---
layout: default
title: Cues, loops and exclusive playback
description: "Trigger visual parameter snapshots and compare independent audio cues with exclusive loops."
parent: Basics
grand_parent: Examples
permalink: /examples/basics/cues.html
score: /examples/basics/cues.zip
---

# Cues, loops and exclusive playback

![Play-once and repeating color automations beside tween comparisons and audio cue intervals]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-cues.png)

The archive combines three cue demonstrations with a native ISF shader preview. Open the ZIP directly in score.

## Parameter cues

`ComplexColorPlots` feeds Multi Pass Gaussian Blur and Color Monochrome, whose output targets `Window:/`. Their blur, intensity and color controls read the `OSC` device tree.

1. Start playback and trigger `Send cue 1` and `Send cue 2`. They send different RGB lists to `OSC:/color`, changing the monochrome tint.
2. Trigger `Play once`: its intensity curve and color gradient finish with their interval. Compare `Repeat`, whose two processes loop while the interval waits for its interactive end.
3. Compare the separate intensity cues with the connected cue chain. The former can be triggered independently; the latter must progress in order and includes minimum and maximum interval bounds.
4. Set blur to a new value, then compare `Tween 1`, `Tween 2` and `No tween`. Tween starts the first segment from the current device value rather than the curve's drawn start.

The saved OSC device listens on UDP `0.0.0.0:9997` and sends to `127.0.0.1:9996`. Its addresses are `/width`, `/blur`, `/intensity` and `/color`. The shader preview reads the same tree internally, so an external OSC application is optional. This uses score's native shader pipeline, not Qt Quick 3D.

## Audio cue behavior

Open `Scenario-nonexclusive` and trigger its sound intervals: more than one can run concurrently. Then inspect `Scenario-exclusive`: starting an interval stops the other intervals in that scenario. Its loop triggers use the root interval's bar quantization, so a requested switch waits for a musical boundary.

The sound processes reference the bundled `Audio/angelpads.wav`, `Audio/001_laughter.wav`, `Audio/000_AMEN.WAV` and `Audio/000_PLEAD.WAV`. Configure audio output and listen at a low level; the sound processes feed the parent mix at `audio:/out/main`.

The annotations also point out the root start and stop states. Inspect these when designing initialization and shutdown cues: ordinary Stop and Stop and reinitialize do not recall the same state.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

