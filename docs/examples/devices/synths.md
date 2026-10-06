---
layout: default
title: MIDI synth and drum effects patch
description: "An example showing how to combine built-in synthesizers and audio effects"
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/synths.html
score: /examples/devices/synths.score
---

# MIDI synth and drum effects patch

![Parallel Synthimi effects feeding ChorusEnsemble above Kaboom's filter and saturator chain]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-synths.png)

This example demonstrates shaping a live synthesizer and drum performance with separate effects. It is a compact companion to [Playing synths on MIDI channels 1 and 10]({{ site.baseurl }}/examples/devices/midi-to-synths.html), with a different saved Kaboom drum sound.

The lead combines saturation and vibrato in parallel before a shared chorus, while filtering and saturation shape the drums. This lets you develop contrasting sounds for two instruments without changing their MIDI performance.

## Play the patch

1. Stop playback and edit `MIDI In` to select your keyboard or software MIDI source. Set up the audio device and lower the output level before starting: the saved IronOxide5 input and output trims are boosted.
2. Start playback and send notes on channel 1 to hear Synthimi's detuned saw voices. No internal sequencer supplies notes.
3. Switch the source to channel 10 and send drum notes, beginning with note 36, which is present in the saved device tree. Inspect Kaboom's selected voice and change Pitch or its pitch envelope to compare the drum sound.
4. Adjust ChorusEnsemble's Dry/Wet for the lead, then ZLowpass2's frequency and Compresaturator's Drive for the drums. Try a restrained lead with aggressive drums, then reverse the balance. Listen to each of the lead's parallel treatments separately to hear what it adds.

No sample files are referenced. The installed build must include Synthimi, Kaboom and Airwindows, and an actual MIDI input must be selected if the saved default device is unavailable.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

