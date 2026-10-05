---
layout: default

title: Arpeggiator
description: "Turn held MIDI notes into timed patterns"

parent: Processes
grand_parent: Reference

permalink: /processes/arpeggiator.html
---
# Arpeggiator

The **Arpeggiator** takes held notes at its MIDI **in** port and produces a repeating note pattern at MIDI **out**. Connect a MIDI keyboard or MIDI-generating process to the input and a synthesizer to the output. Release the input notes to remove them from the pattern.

This page describes version 2, whose **Rate** uses the [time chooser]({{ site.baseurl }}/reference/time-chooser.html).

## Controls

| Control | Choices or range | Behavior |
|---|---|---|
| **Arpeggios** | Forward, Backward, F->B, B->F, Chord, Random | Ascending, descending, alternating-direction, simultaneous-chord or random selection. Default: Forward. |
| **Octave** | 1–7; default **1** | Adds octave copies; 1 uses the original notes only. Copies outside MIDI pitches 0–127 are omitted. |
| **Octave mode** | Both, Above, Below | Chooses where octave copies are added. Default: Both. |
| **Repeat** | 1–8; default **1** | Repeats each step before proceeding. Chord mode instead plays the expanded chord together. |
| **Rate** | Free duration 0.01–4 seconds; default **0.125 seconds** | Time between steps, or a synchronized straight, dotted or triplet note value. |

Despite its label, **Rate** is a duration, not hertz. In synchronized mode, steps fall on the musical grid. In free mode, the duration is converted to a grid spacing at the current tempo; this process still schedules its steps through the musical-grid mechanism rather than acting as an independent wall-clock timer.

At each step, the previous output notes end and the next note or chord starts. **Chord** includes the octave expansion and sounds its notes together; **Random** selects from the expanded pattern at each step.

## MIDI limitations

The current engine tracks held notes by pitch, not by input MIDI channel, and generates notes on **channel 1**. It is not a transparent MIDI router: do not rely on it to forward controllers, program changes or other non-note messages. Route those separately if your instrument needs them.

## Older saved processes

**Arpeggiator (old)** remains separately registered and uses its earlier rate selector. It shares the pattern engine but is not automatically converted to the new time-chooser version. Insert a current Arpeggiator and re-create the intended timing and connections to update a score.

See [MIDI Utilities]({{ site.baseurl }}/processes/midi-utilities.html) for complementary note-processing tools.
