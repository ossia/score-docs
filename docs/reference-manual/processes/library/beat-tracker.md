---
layout: default
title: "Beat Tracker"
description: "Follow tempo and beat phase from audio or control events"
parent: Processes
grand_parent: Reference
permalink: /processes/beat-tracker.html
---

# Beat Tracker

Beat Tracker estimates tempo and maintains a beat clock from live audio or incoming beat events. It does not change the timeline until its outputs are connected to the desired controls.

## Inputs and setup

**Source** selects Audio, Events, or Audio + Events. Audio arrives at **In**, with channels summed to mono. In Events mode, send pulses to **Beat**: integers and floats are interpreted as beat numbers, while impulses and other values mean an unnumbered beat. **Events per beat** accommodates subdivisions, such as 24 pulses per beat for MIDI clock.

For audio, select **Band**, set **Gate (dB)** above background noise and constrain **Min BPM** / **Max BPM** with **Limit BPM range**. **Transport tempo hint** helps choose between half-time and double-time interpretations. **Clock filter**, **Whitening**, **Lookahead (ms)** and **Offset (ms)** refine detection and output timing.

## Outputs and performance controls

- **Tempo** is the estimated BPM; connect it to an interval’s Tempo inlet to drive tempo.
- **Speed** is a playback-rate multiplier that corrects phase as well as tempo; use it with a synchronizer or Speed inlet instead when following position matters.
- **Phase** and **Bar phase** run from 0 towards 1; **Beat index** counts beats and **Next beat (s)** predicts the next beat.
- **Beat**, **Downbeat** and **Onset** emit timing events. **Confidence**, **Locked** and **Valid** let the patch decide whether to trust the result.

Use **Tap** to establish tempo while unlocked or reset phase while locked; **Resync** declares the downbeat without changing tempo. **x2** and **/2** correct tempo-octave mistakes. **Nudge -/+** correct alignment. **Hold** freezes tempo but still follows phase; **Follow** off freezes the clock and stops analysis. Set **Beats per bar** to the intended meter.

Sparse, ambiguous or silent audio can lose lock. Monitor Confidence and Valid and provide a suitable manual fallback rather than assuming continuous reliable tracking. See [Analysis]({{ site.baseurl }}/processes/analysis.html) for onset and other audio descriptors.
