---
layout: default
title: "MIDI Envelope"
description: "Turn MIDI note events into control envelopes"
parent: Processes
grand_parent: Reference
permalink: /processes/midi-envelope.html
---

# MIDI Envelope

MIDI Envelope receives notes on **MIDI** and generates control values on **Out**. Connect Out to a parameter such as brightness, filter cutoff or spatial position; it is a control envelope, not an audio synthesizer.

See [Time Chooser]({{ site.baseurl }}/reference/time-chooser.html) for the duration controls shared by the envelope stages.

## Shape and triggering

**Envelope** offers ADSR, AD, AHD, AHDSR, DAHDSR, Curve and CurveSustain. The staged modes use **Delay**, **Attack**, **Hold**, **Decay**, **Sustain** and **Release** as applicable. **Attack curve** and **Decay curve** shape the segments. In staged modes the drawn **Curve** is an output transfer function, not a time trajectory.

In Curve mode the drawn curve is traversed over **Curve duration**. CurveSustain plays to **Sustain point**, holds while the note remains down, then traverses the remainder during release. Time controls use time choosers, including tempo-relative durations.

**Trigger** offers Retrigger (from the current level), Reset (from zero), and Legato (do not restart while a note is held). **Voicing** selects Mono or Poly. **Note priority** chooses Last, First, Lowest or Highest in Mono; **Voices** sets polyphony up to 32.

## Mapping and outputs

**Channel** (0 means all) and **Key range** filter triggering notes. **Velocity amount** controls peak scaling, **Key tracking** changes durations with pitch, and **Output range**, **Smooth** and **Resolution** control the outgoing signal.

In Poly mode **Combine** summarizes envelopes using Max, Sum, Average or Latest. **Voices** exposes individual envelope values. **Gate**, **Pitch**, **Velocity**, **Active** and **MIDI out** provide accompanying state and MIDI. Pitch is a MIDI note number, not a normalized 0–1 signal.

Use [Signal Display]({{ site.baseurl }}/processes/signal-display.html) to monitor the resulting envelope before connecting it to a destination.
