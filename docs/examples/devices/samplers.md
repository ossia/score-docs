---
layout: default
title: Soundfonts, drum kits and a single-file sampler
description: "An example showing how to play and sequence samples with built-in samplers"
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/samplers.html
score: /examples/devices/samplers.zip
---

# Soundfonts, drum kits and a single-file sampler

![Soundfont sampler with a piano keyboard above sequenced drum-kit branches and compressors]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-samplers.png)

This example demonstrates three approaches to playing sampled sound: a soundfont instrument, layered drum kits and a single sample played at different pitches. It combines live MIDI playing with sequenced material, so you can compare the instruments within one arrangement.

## Included sounds

- `Audio/4GMGS.sf2` is the soundfont played from the external MIDI input.
- The Roland TB909, Serge Modular and TD-7 Hydrogen kits in `Data/` play the same drum pattern.
- `Audio/001_miss.wav` is played by Minibang with an arpeggiated piano-roll pattern. Its reference note is 38, which plays the sample at its original pitch.

## Play and compare

1. Open the ZIP directly in score. If a layer is silent, check its file selection against the archive's `Audio/` and `Data/` folders. Hydrogen kits can also be installed from the Package Manager and relinked.
2. Select an audio output and start at a low level. The drum and Minibang branches have internal note generators and can play without a keyboard.
3. To play the soundfont, stop playback, edit `MIDI In` and select your controller, then restart and send notes. Change Deuterium's Instrument control to audition another soundfont program.
4. Mute individual kit processes to compare how the same rhythm changes with each set of drum sounds. Then combine two kits to explore layering.
5. Change Minibang's piano-roll notes or the arpeggiator's settings. Listen to how transposing a single recording changes both pitch and character, and compare it with the soundfont instrument.

The installed build needs Deuterium, Minibang, Faust, BarrVerb and Airwindows. The archive includes the sound assets in its `Audio/` and `Data/` folders.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

