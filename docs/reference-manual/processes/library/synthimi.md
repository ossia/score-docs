---
layout: default
title: Synthimi
description: "A four-oscillator MIDI synthesizer with envelopes and fixed modulation modes"
parent: Processes
grand_parent: Reference
permalink: /processes/synthimi.html
---

# Synthimi

**Synthimi** is a MIDI-driven synthesizer supplied by the optional Synthimi add-on. It is not guaranteed to be present in every score build. Connect a MIDI source to **In** and route the fixed stereo **Out** to an audio destination.

## Oscillators

Each of the four oscillators has the same controls:

| Control | Meaning |
|---|---|
| Osc N Amp. | Amplitude, 0–1. |
| Osc N Wave | Sine, Square, Tri, Saw or Noise. |
| Osc N Pitch | Pitch offset in semitones, -12 to +12. |
| Osc N Oct | Octave offset, -5 to +5. |

The MIDI note supplies the base pitch. Start with **Modmatrix** set to **S**, one oscillator audible and the other amplitudes at 0 to hear one waveform clearly.

## Envelopes, filter and voices

- **Amp. Attack**, **Amp. Decay**, **Amp. Sustain**, **Amp. Release** shape each note's amplitude. Attack, decay and release are time controls; sustain is a 0–1 level.
- **Filter** enables or bypasses the filter stage. **Type** selects **LPF** or **HPF**.
- **Cutoff** sets the base frequency in Hz (20–20000); the filter envelope multiplies this frequency during the note. **Reso** controls filter Q (0.1–10), not a percentage.
- **Flt. Attack**, **Flt. Decay**, **Flt. Sustain**, **Flt. Release** shape the filter envelope.
- **Polyphony** selects **Mono** or **Poly**. It is not a numeric voice-count selector.
- **Porta** controls pitch-glide time for Mono operation.
- **Unison** selects 0–16 additional subvoices. More unison and simultaneous notes require more audio processing.
- **Drive** controls output saturation, 0–1.

## Modmatrix

This is a selector for five fixed oscillator-combination algorithms, **not** an editable routing matrix:

| Mode | Combination |
|---|---|
| S | Sum of the four oscillator signals. |
| C | Serial phase-modulation chain: 1 into 2 into 3 into 4; output from oscillator 4. |
| CSP | Two additive-phase chains, 1 into 2 and 3 into 4; their outputs are summed. |
| CST | Two chains using multiplication of the carrier phase by the preceding oscillator signal; their outputs are summed. |
| CSC | Oscillator 1 modulates 2; the signals from 2 and 3 together modulate oscillator 4. |

Oscillator amplitudes affect modulation as well as loudness in the chain modes. In **C** and **CSC**, oscillator 4 is the final output, so setting its amplitude to 0 silences that chain.

## First patch

Use a MIDI note source with both note-on and note-off events, **Polyphony: Poly**, **Modmatrix: S**, **Unison: 0**, and one Sine oscillator. Temporarily bypass **Filter** to isolate the oscillator and amplitude envelope. Route **Out** at a conservative monitoring level, then enable the filter and add oscillators or modulation. This separates MIDI-routing problems from a silent final oscillator, filter setting or envelope.
