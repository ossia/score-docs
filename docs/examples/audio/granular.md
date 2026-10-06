---
layout: default
title: Granular synthesis approaches
description: "An example showing different approaches to granular synthesis"
parent: Audio
grand_parent: Examples
permalink: /examples/audio/granular.html
score: /examples/audio/granular.score
---

# Granular synthesis approaches

![Granola voices and a Faust granulator connected to shared filters and gain]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-granular.png)

This example explores several ways of turning recorded sound into grains and short repeating fragments. Continuous textures, MIDI-triggered grains and a simple sound-file loop offer different approaches to rhythm and timbre.

## Prepare the sounds

The download is a score document, not a sample archive. Relink these saved project-relative files, or substitute your own sounds:

- `Data/Techno-1/fx_09.wav`: the first, continuously running Granola voice.
- `Grand Pianos 06 80 BPM.wav`: both the second Granola voice and the sound file feeding Faust.
- `Data/Techno-1/sim_bass_23_01.wav`: the MIDI-triggered Granola voice.
- `Data/Techno-1/rhythm77_bd.wav`: the short-loop sound file.

Use a build with Granola, Faust and the Airwindows effects available. Select an audio output and start at a low listening level.

## Try it

1. Start playback and mute individual layers to hear each approach on its own. Change Position, Duration and Density on the first Granola: compare recognizable fragments with a dense, overlapping texture.
2. Listen to the piano Granola's changing playback position. Slow its sample-and-hold LFO to hear how selecting a new region changes the material.
3. Compare the third Granola, triggered by the `Jungl` pattern, with the continuously playing voices. Edit the pattern to explore rhythmic rather than continuous granular sound.
4. Try Grain Size, Speed and Probability in the Faust `Granulator`. Compare the results with Granola using the same piano source.
5. Lengthen the `rhythm77_bd` sound file's 0.04-second loop. Listen for the point where a repeating texture becomes a recognizable drum fragment.

Use the final Gain to control the combined level. The shared filters can help shape the mixture once you have explored the layers separately.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

