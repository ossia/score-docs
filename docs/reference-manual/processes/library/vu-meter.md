---
layout: default

title: VU Meter
description: "Monitor multichannel audio peak and RMS levels"

parent: Processes
grand_parent: Reference

permalink: /processes/vu-meter.html
---

# VU Meter

**VU Meter**, in **Monitoring**, displays the level of each channel of an audio
bus, with peak, RMS and peak-hold indications.

## Connections

Connect the signal to **Audio**. The channel count follows the incoming bus.
To listen and meter at the same time, branch the source to both the meter and
the normal audio destination. **There is no audio-through outlet**: inserting
only a meter at the end of a chain does not route sound to the speakers.

**Levels** is a value-list output containing three linear-amplitude numbers per
channel: peak envelope, RMS envelope and held peak. For two channels its order is
`[peak0, rms0, hold0, peak1, rms1, hold1]`. These are not dB values; the graphical
meter converts them for display. The envelopes include release smoothing, so
Levels is not a list of instantaneous audio samples.

## Workflow

Place the meter before or after an effect to compare signal levels, or monitor a
multichannel [Audio device]({{ site.baseurl }}/devices/audio-device.html) bus.
Keep the containing interval executing while observing it. The meter measures
levels; it does not attenuate, limit or prevent clipping. Adjust gain in the
source, effect or destination when a signal is too loud.
