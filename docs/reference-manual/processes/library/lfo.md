---
layout: default

title: LFO
description: "Low-frequency oscillator control signal"

parent: Processes
grand_parent: Reference

permalink: /processes/lfo.html
---
# LFO

![LFO]({{ site.img }}/reference/processes/lfo.png "LFO Example")

The **LFO** generates a control value at its **Out** port: connect it to a parameter to make that parameter oscillate. It does not generate an audio signal.

This page describes the current development-build LFO (v3). Older scores may contain **LFO (old)** or **LFO (v2)**, which retain their own controls rather than automatically becoming v3.

## Period and synchronization

**Period** is the duration of one cycle, not its frequency: free range **0.01–60 seconds**, default **1 second**. A one-second period corresponds to 1 Hz; a two-second period to 0.5 Hz.

Use the [time chooser]({{ site.baseurl }}/reference/time-chooser.html) readout to select straight, dotted or triplet note values. **Lock to bars** affects synchronized mode only:

- Off: cycles accumulate from the playback start or the last **Retrigger**.
- On: cycles are calculated from the timeline's musical position, keeping their alignment through tempo changes, jumps and loops. **Retrigger** establishes a new origin at the current musical position.

**Retrigger** restarts the cycle; **Phase** still applies to its starting position. Musical periods are whole-note fractions: a `1/1` cycle is four quarter notes, not necessarily one bar in a different time signature.

## Waveform and shape

The waveform selector offers sine, triangle, rising saw, falling ramp, square, sample-and-hold, three noise variants and drift. Square and sample-and-hold each have an **every-tick** and an **on-change** variant. Choose on-change when a downstream process should receive only the steps, rather than repeated copies of the held value. Sample-and-hold chooses a new random value at each of the cycle's two steps.

**Shape** ranges from 0 to 1 (default **0.5**). It changes the rise/fall balance of sine and triangle, the step width of square and sample-and-hold, the curve of the ramps, and the roughness of drift.

## Output range and phase

| Control | Range; default | Meaning |
|---|---|---|
| **Ampl.** | 0–2; **0.5** | Multiplies the waveform, whose base range is −1 to 1. |
| **Offset** | −1–1; **0.5** | Added after amplitude scaling. |
| **Phase** | 0–360 degrees; **0** | Constant phase offset. 0 and 360 represent the same point; values outside the range wrap. |
| **Jitter** | 0–180 degrees; **0** | Adds a random phase offset within ±this amount on each execution tick. This is phase variation, not output-amplitude noise. |

The default amplitude and offset produce values from 0 to 1. For a bipolar modulation around zero, set Offset to 0. The destination's own range still determines which values are useful.

## Older saved LFOs

The earlier variants remain separately registered for saved scores and are marked deprecated. Their frequency-based timing and phase controls must not be interpreted using the v3 units above. To use the new Period, Shape or Lock to bars controls, add a current LFO and deliberately re-create the desired modulation and connections.