---
layout: default

title: Wavecycle
description: "Wavetable oscillator with hand-drawn waveforms"

parent: Processes
grand_parent: Reference

permalink: /processes/wavecycle.html
---
# Wavecycle

![Wavecycle]({{ site.img }}/reference/processes/wavecycle/wavecycle.png "Wavecycle")

Draw your own waveforms and hear them immediately. Wavecycle turns hand-drawn curves into audio oscillators, letting you sculpt sound by sculpting waves.

Perfect for creating custom timbres, experimental synthesis, or when you want total control over your oscillator's harmonic content. Draw harsh sawtooths, smooth sines, or impossible shapes that only exist in your imagination.

## How it works

Wavecycle reads the curve you draw and uses it as a wavetable - cycling through your waveform at audio rate to generate sound. The faster the frequency, the higher the pitch.

The curve inlet allows to click and drag to draw any shape you want. The horizontal axis is one complete cycle, the vertical axis is amplitude. Sharp corners create harsh harmonics, smooth curves sound gentle.


The frequency inlet is how fast to cycle through your waveform. Low frequencies for bass tones, high frequencies for piercing leads. The frequency parameter includes smoothing to prevent clicks when adjusting.

To plug for instance MIDI notes, one needs to take the MIDI pitch and convert it to frequency values:

![Wavecycle MIDI to frequency example]({{ site.img }}/reference/processes/wavecycle/wavecycle-mtof.png "Wavecycle MIDI to Frequency")


[Try it !]({{ site.scores }}/reference/processes/wavecycle.score)