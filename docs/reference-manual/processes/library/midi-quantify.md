---
layout: default

title: Midi Quantify
description: "Delay MIDI notes onto a grid and choose how their duration is determined"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-quantify.html
---
# Midi Quantify

The process named **Midi quantify** receives MIDI notes at **in** and schedules their starts and endings before sending them to MIDI **out**. Put it between a live MIDI source and an instrument to constrain note timing. Non-note MIDI messages pass through unchanged.

This page describes version 2.

## Grid and Tightness

**Grid** sets the spacing between possible note starts. Its free range is **0–4 seconds**, default **0.125 seconds**. Zero lets notes start as they arrive. Use the [time chooser]({{ site.baseurl }}/reference/time-chooser.html) for straight, dotted or triplet note values.

- A free grid is measured from the playback origin in samples.
- A synchronized grid follows the timeline's musical position, so it remains aligned to the beats when playback starts elsewhere in the score.

**Tightness** ranges from 0 to 1, default **0.8**. At 1, an off-grid note waits for the next grid point. Reducing it allows a note played just after a grid point to start immediately: the acceptance window is `(1 − Tightness) × half a grid step`. At the default 0.8, this is 10% of a step. This is causal processing: it never moves a live note backwards in time.

## Length and Duration

**Length** determines how note endings are handled:

| Choice | Behavior |
|---|---|
| **UntilNoteOff** (default) | End on the incoming note-off. If a note is released before its delayed start, it still plays for the duration it was originally held. |
| **FixedDuration** | End after Duration measured from the scheduled start, regardless of the input note-off. |
| **EndOnGrid** | End at the next point of the Duration grid after the scheduled start, regardless of the input note-off. |

**Duration** has a free range of **0–8 seconds**, default **0.25 seconds**, and its own independent time chooser. For example, synchronize Grid to `1/8`, choose FixedDuration, and set Duration to `1/16` for eighth-note starts with sixteenth-note lengths. Duration is not used in UntilNoteOff mode.

A repeated note-on for the same channel and pitch replaces a waiting note and ends an already sounding one before rescheduling it. Transport discontinuities release sounding notes and discard pending starts rather than leaving them queued for a later position.

## Older saved processes

**Midi quantify (old)** remains available to load existing scores with its earlier quantification and duration controls. It is not automatically replaced with v2. Re-create the intended settings and connections in a new Midi quantify process to use Grid, Length and the two time choosers.

See [MIDI Utilities]({{ site.baseurl }}/processes/midi-utilities.html) for other note transformations.
