---
layout: default
title: Scala tuning and Wavecycle
description: "An example showing microtonal synthesis with Scala tuning files"
parent: Audio
grand_parent: Examples
permalink: /examples/audio/scales.html
score: /examples/audio/scales.score
---

# Scala tuning and Wavecycle

![Pattern sequencer connected through Midi Humanize to Midi scaler's tuning controls]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-scales.png)

This example demonstrates using Scala tuning files to explore pitch relationships beyond a fixed tuning. A sequenced MIDI pattern becomes tuned frequencies for Wavecycle, an oscillator with a hand-drawn waveform.

Midi scaler reads a Scala tuning file and keyboard mapping. The saved paths are `/mnt/sda1/scales/arabic_segah-mustaar_on_e.scl` and `/mnt/sda1/scales/128.kbm`. These are author-local files, not included in the download. Choose an appropriate `.scl` and `.kbm` on your machine before comparing tunings. The project points to [Scale Library](https://scalelibrary.org/) as a source of tuning files.

## Try it

1. Configure audio output, relink the tuning files and start playback. The Pattern sequencer has two stored patterns; select between them to change the note material.
2. Change Midi scaler's Frequency scale or tuning file while keeping the same pattern. Listen to how the relationships between notes change.
3. Edit Wavecycle's waveform to explore timbre independently of tuning. Compare the sound with and without the delay and chorus treatments.
4. Listen through a cycle of the `Deep frying` automation, which changes the lowpass effect's Dry/Wet over 36 seconds. Try a gentler curve to keep the tuned pitches clearer.

A small, fast LFO modulates Frequency adjust. Temporarily disconnect it when comparing the tuning's unmodulated frequencies. No external MIDI device is needed; the Scala files and the installed Airwindows support are the external requirements.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

