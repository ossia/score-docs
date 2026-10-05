---
layout: default
title: Granular synthesis approaches
description: "Compare autonomous and MIDI-driven Granola, a Faust granulator, and short sound-file loops."
parent: Audio
grand_parent: Examples
permalink: /examples/audio/granular.html
score: /examples/audio/granular.score
---

# Granular synthesis approaches

![Granola voices and a Faust granulator connected to shared filters and gain]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-granular.png)

This patch combines three Granola voices, a Faust granulator and a very short sound-file loop. The voices converge on a Lowpass, an Airwindows Highpass and a final Gain routed through the interval to `audio:/out/main`.

## Prepare the sounds

The download is a score document, not a sample archive. Relink these saved project-relative files, or substitute your own sounds:

- `Data/Techno-1/fx_09.wav`: the first, continuously running Granola voice.
- `Grand Pianos 06 80 BPM.wav`: both the second Granola voice and the sound file feeding Faust.
- `Data/Techno-1/sim_bass_23_01.wav`: the MIDI-triggered Granola voice.
- `Data/Techno-1/rhythm77_bd.wav`: the short-loop sound file.

Use a build with Granola, Faust and the Airwindows effects available. Select an audio output and start at a low listening level.

## Follow the graph

1. Start playback. Change Position, Duration and Density on the first Granola to hear different regions and grain overlaps.
2. Follow the sample-and-hold LFO into the piano Granola's Position. Its output passes through `kPlate240` before joining the lowpass.
3. Inspect the third Granola: Continuous is disabled. The `Jungl` Pattern sequencer triggers its MIDI input while a Drift LFO moves Position.
4. Follow the piano sound file into the Faust `Granulator`. Compare its Grain Size, Speed and Probability controls with Granola's controls.
5. Inspect `rhythm77_bd`: its 0.04-second loop and 0.01-second offset provide a simple repeating slice. A Gain of about 0.042 attenuates it before mixing.

The final Gain controls the combined result; individual branches can be muted to compare approaches without the other layers masking them.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

