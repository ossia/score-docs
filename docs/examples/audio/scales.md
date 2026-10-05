---
layout: default
title: Scala tuning and Wavecycle
description: "Convert a MIDI pattern to tuned frequencies with Scala files and drive a waveshape oscillator."
parent: Audio
grand_parent: Examples
permalink: /examples/audio/scales.html
score: /examples/audio/scales.score
---

# Scala tuning and Wavecycle

![Pattern sequencer connected through Midi Humanize to Midi scaler's tuning controls]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-scales.png)

Pattern sequencer → Midi Humanize → Midi scaler turns MIDI notes into frequencies. Wavecycle uses those frequencies to play a hand-drawn waveform; its Frequency inlet can accept a list for polyphonic output.

Midi scaler reads a Scala tuning file and keyboard mapping. The saved paths are `/mnt/sda1/scales/arabic_segah-mustaar_on_e.scl` and `/mnt/sda1/scales/128.kbm`. These are author-local files, not included in the download. Choose an appropriate `.scl` and `.kbm` on your machine before comparing tunings. The project points to [Scale Library](https://scalelibrary.org/) as a source of tuning files.

## Follow the sound

1. Configure audio output, relink the tuning files and start playback. The Pattern sequencer has two stored patterns; select between them to change the note material.
2. Change Midi scaler's Frequency scale or tuning file and listen to the pitch relationships. Its frequency output also passes through Repetition Filter to trigger an ADSR, so pitch changes articulate the sound.
3. Follow Wavecycle into the parallel Airwindows `TapeDelay2` and `ChorusEnsemble` branches. They join at Gain, whose level is controlled by the ADSR.
4. Follow Gain through Compressor, Airwindows `XLowpass` and Stereo Mixer to the parent mix at `audio:/out/main`. The looping `Deep frying` automation increases XLowpass's Dry/Wet over 36 seconds of score time.

A small, fast LFO modulates Frequency adjust. Temporarily disconnect it when comparing the tuning's unmodulated frequencies. No external MIDI device is needed; the Scala files and the installed Airwindows support are the external requirements.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

