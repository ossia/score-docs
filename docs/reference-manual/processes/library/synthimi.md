---
layout: default

title: Synthimi
description: "A polyphonic four-oscillator MIDI synthesizer"

parent: Processes
grand_parent: Reference

permalink: /processes/synthimi.html
---
# Synthimi

<!-- TODO screenshot: ![Synthimi]({{ site.img }}/reference/processes/synthimi.png "Synthimi") -->

A built-in polyphonic synthesizer driven by MIDI. It combines four oscillators, an
amplitude and filter envelope, a multimode filter and a modulation matrix, and outputs
stereo audio.

## MIDI input

Notes and controllers come in on the MIDI bus.

## Oscillators 1–4

Each oscillator has its own:

* **Amplitude**
* **Waveform**
* **Pitch** and **Octave**

## Envelopes

* **Amp ADSR** — attack/decay/sustain/release for the amplitude.
* **Filter ADSR** — envelope applied to the filter (enable with the filter-envelope
  toggle).

## Filter

* **Type** — filter mode.
* **Cutoff** and **Resonance**.

## Voicing

* **Polyphony mode** — how many simultaneous voices.
* **Portamento** — glide time between notes.
* **Unison** — stack detuned voices for a thicker sound.

## Drive / Modulation

* **Drive** — output saturation.
* **Modulation matrix** — route modulation sources to destinations.

## Output

A fixed stereo audio output.
