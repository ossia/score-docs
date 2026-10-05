---
layout: default

title: Faust Synthesis example
description: "An example demonstrating various synthesis in multiple patches with Faust"

parent: Audio
grand_parent: Examples

permalink: /examples/audio/faust-synthesis.html
score: /examples/audio/faust-synthesis.score
---

# Faust Synthesis

![Faust Synthesis Example]({{ site.img }}/examples/audio/faust-synthesis.png "Sound Synthesis with Faust")

This score sequences Faust physical models and effects without external samples or a MIDI controller. The DSP code is embedded in the document; use a build with Faust support and configure the root interval's audio output for your device before listening.

## Follow the synthesis

1. Start at a low listening level. At 2 seconds, ChurchBell and tibetanBowl become active. A square LFO drives the bell's gate, while Piano roll supplies the bowl's MIDI notes and a sample-and-hold LFO changes its excitation selector.
2. Their mixed Gain output feeds a separate Freeverb interval, then Gain and Limiter. An automation changes both source gain and reverb intensity.
3. At 20 seconds, `Buzz` starts. A Pattern sequencer drives Sitar and NylonGuitarMidi; a Step sequencer changes the sitar's resonance. The sitar runs through a lowpass and pitch shifter, while the guitar has its own reverb. Both feed a compressor and the shared Freeverb branch.
4. At 28 seconds, `Pitch` begins: a looping automation passes through the `Noisify` expression filter into pitchShifter's semitone control. A second automation changes the expression's `b` parameter.
5. Trigger Buzz's end to return to the bowl section through the zero-duration interval. Freeverb and Pitch have their own interactive ends, so stop them separately or use Stop.

Open a Faust process's script editor to inspect its physical-model or effect code. The final Limiter sends to the parent mix; unlike many newer examples, this document has no saved `audio:/out/main` binding on its root, so check that destination if the graph runs silently.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Audio plugins]] - Complete guide to VST, VST3, CLAP, LV2, JSFX plugins
- [[Faust]] - Writing and using Faust DSP code
- [[Audio Effects]] - Built-in audio effect processes
- [[Supported protocols and formats]] - All supported audio plugin formats
