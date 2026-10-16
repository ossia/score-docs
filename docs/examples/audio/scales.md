---
layout: default
title: Scala tuning and Wavecycle
description: "Compare tunings on the same musical pattern, then draw an oscillator waveform to explore pitch relationships and timbre separately."
parent: Audio
grand_parent: Examples
permalink: /examples/audio/scales.html
score: /examples/audio/scales.zip
---

# Scala tuning and Wavecycle

![Pattern sequencer connected through Midi Humanize to Midi scaler's tuning controls]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-scales.png)

Hear the same pattern through a different set of pitch relationships, then change its tone without changing the tuning. Scala files determine the frequencies; Wavecycle supplies a hand-drawn oscillator waveform. Keeping these choices separate is useful when building a musical vocabulary for a piece rather than starting from a fixed synth preset.

Midi scaler converts the MIDI pattern into frequencies using a Scala tuning and keyboard mapping. Wavecycle turns those frequencies into sound, and delay, chorus and filtering add a changing treatment around it.

## Prepare and compare

Open the ZIP directly in score: the tuning and keyboard-mapping files are included. Use a build with Airwindows support and configure audio output at a low listening level. No external MIDI device is required. [Scale Library](https://scalelibrary.org/) provides other tuning files to explore.

1. Start playback and switch between the Pattern sequencer's two stored patterns. Then keep one pattern fixed so you have a consistent phrase for comparing tunings.
2. Select another Scala tuning with an appropriate keyboard mapping while keeping the pattern fixed. Listen to which note relationships become closer or wider, rather than judging only the overall pitch range.
3. Edit Wavecycle's waveform while keeping the tuning fixed. Listen for changes in brightness and harmonic content rather than changes to the note relationships.
4. Follow the `Deep frying` automation, which gradually changes the lowpass effect's Dry/Wet. Try a gentler curve to keep the tuned pitches clearer through the treatment.

A small, fast LFO modulates Frequency adjust. Temporarily disconnect it when comparing unmodulated frequencies; otherwise you are hearing tuning and pitch modulation together.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

