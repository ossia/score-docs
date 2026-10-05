---
layout: default
title: Soundfonts, drum kits and a single-file sampler
description: "Combine MIDI-played Deuterium, sequenced Hydrogen kits and an arpeggiated Minibang sample."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/samplers.html
score: /examples/devices/samplers.zip
---

# Soundfonts, drum kits and a single-file sampler

![Soundfont sampler with a piano keyboard above sequenced drum-kit branches and compressors]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-samplers.png)

This patch has three sound sources with different MIDI inputs:

- Deuterium loads `Audio/4GMGS.sf2`, selects instrument 4 and reads the external `MIDI In:/` stream.
- A Pattern sequencer plays three Deuterium Hydrogen kits in parallel: `Data/Roland_TB909Kit/drumkit.xml`, `Data/Serge_ModularKit/drumkit.xml` and `Data/TD-7kit/drumkit.xml`.
- A looping Piano roll feeds an Arpeggiator and Minibang, which loads `Audio/001_miss.wav`. Its annotated reference note is 38: that note plays the sample at its original pitch.

## Play and compare

1. Open the ZIP directly in score. Check the five file selections above if any branch is silent. Hydrogen kits can also be installed from the Package Manager and relinked.
2. Select an audio output and start at a low level. The drum and Minibang branches have internal note generators and can play without a keyboard.
3. To play the soundfont, stop playback, edit `MIDI In` and select your controller, then restart and send notes. Change Deuterium's Instrument control to audition another soundfont program.
4. Mute individual kit processes to compare how the same drum pattern sounds through each kit. Their audio is summed into one Faust compressor; the soundfont uses a second compressor.
5. Follow Minibang through BarrVerb and Airwindows CreamCoat. All branches converge at Airwindows YNotLowpass and kStation, whose output feeds the parent mix at `audio:/out/main`.

The installed build needs Deuterium, Minibang, Faust, BarrVerb and Airwindows. The archive includes the sound assets in its `Audio/` and `Data/` folders.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

