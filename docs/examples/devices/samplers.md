---
layout: default
title: Soundfonts, drum kits and a single-file sampler
description: "Compare a live soundfont instrument, layered drum kits and a pitched recording within one sampled-sound arrangement."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/samplers.html
score: /examples/devices/samplers.zip
---

# Soundfonts, drum kits and a single-file sampler

![Soundfont sampler with a piano keyboard above sequenced drum-kit branches and compressors]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-samplers.png)

The same notes can produce very different musical material depending on how recordings become an instrument. Here you can play a soundfont live, hear one rhythm through several drum kits, and transpose a single recording with an arpeggiated pattern. Compare these approaches before choosing how to build a sampled instrument for a performance.

## Three ways to organize recordings

The soundfont provides selectable instrument programs for incoming MIDI. The drum section sends the same pattern to Roland TB909, Serge Modular and TD-7 kits, making it easy to hear what the choice of kit contributes to a rhythm.

Minibang takes a different approach: one recording is played at different pitches by a piano roll and arpeggiator. Its reference note is 38, which plays the recording at its original pitch. Unlike selecting another soundfont program or kit, transposing this layer reshapes the same source sound.

## Play and compare

1. Open the ZIP directly in score; the soundfont, kits and recording are included. If a layer is silent, check its sampler's file selection. You can also install Hydrogen kits from the Package Manager and relink a drum layer.
2. Select an audio output and start quietly. The drum and Minibang branches generate their own notes, so you can explore them without a keyboard.
3. To play the soundfont, stop playback, edit `MIDI In` and select your controller. Restart, repeat a short phrase, and change Deuterium's Instrument control to hear how another program changes that phrase.
4. Mute individual kit processes and compare the same rhythm through each kit. Then combine two: listen for hits that reinforce one another and hits whose different attacks make the rhythm feel busier.
5. Change Minibang's piano-roll notes or arpeggiator settings. Compare notes around the reference pitch with a wider range, listening to how the recording's character changes as well as its pitch.

The build needs Deuterium, Minibang, Faust, BarrVerb and Airwindows. Keep the archive's sound folders with the score if you extract it manually.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

