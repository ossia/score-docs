---
layout: default
title: Scala tuning and Wavecycle
description: "Play one musical pattern in different tunings, then draw an oscillator waveform to change timbre without changing pitch relationships."
parent: Audio
grand_parent: Examples
permalink: /examples/audio/scales.html
score: /examples/audio/scales.zip
---

# Scala tuning and Wavecycle

![Pattern sequencer connected through Midi Humanize to Midi scaler's tuning controls]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-scales.png)

Hear the same pattern through a different set of pitch relationships, then change its tone without changing the tuning. Scala files determine the frequencies; Wavecycle supplies a hand-drawn oscillator waveform.
Midi scaler converts the MIDI pattern into frequencies using a Scala tuning and keyboard mapping. Wavecycle turns those frequencies into sound, and delay, chorus and filtering add a changing treatment around it.

## Try it

Open the ZIP directly in score: the tuning and keyboard-mapping files are included. Use a build with Airwindows support and configure audio output at a low listening level. No external MIDI device is required. [Scale Library](https://scalelibrary.org/) provides other tuning files to explore.

1. Start playback and switch between the Pattern sequencer's two stored patterns. Then keep one pattern selected for the next steps.
2. Select another Scala tuning with an appropriate keyboard mapping. Listen to which intervals between notes become narrower or wider, not just the overall pitch range.
3. Edit Wavecycle's waveform while keeping the tuning fixed. Brightness and harmonic content change; the intervals between notes do not.
4. Follow the `Deep frying` automation, which gradually changes the lowpass effect's Dry/Wet. Try a gentler curve to keep the tuned pitches clearer through the treatment.

A small, fast LFO modulates Frequency adjust. Temporarily disconnect it to hear the tuning without pitch modulation.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

