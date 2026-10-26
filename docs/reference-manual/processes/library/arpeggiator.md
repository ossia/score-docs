---
layout: default

title: Arpeggiator
description: "Turn held MIDI notes into timed patterns"

parent: Processes
grand_parent: Reference

permalink: /processes/arpeggiator.html
---
# Arpeggiator

The **Arpeggiator** takes held notes at its MIDI **in** port and produces a repeating note pattern at MIDI **out**. Connect a MIDI keyboard or MIDI-generating process to the input and a synthesizer to the output. Release the input notes to remove them from the pattern, unless a **Latch** keeps them.

This page describes version 2, whose **Rate** uses the [time chooser]({{ site.baseurl }}/reference/time-chooser.html).

## Pattern

| Control | Choices or range | Behavior |
|---|---|---|
| **Arpeggios** | see below; default **Forward** | The order of the steps. |
| **Rate** | Free duration 0.01–4 seconds; default **0.125 seconds** | Time between steps, or a synchronized straight, dotted or triplet note value. |
| **Gate** | 0.01–2; default **1** | Length of a note as a proportion of a step. At 1 a note lasts until the next step starts; below, it ends earlier; above, it overlaps the next step. A pitch played again by the next step ends first. |
| **Swing** | 0–1; default **0** | Delays every second step, counted from the bar line: 0.5 puts it on the triplet, 1 at 5/6 of the pair of steps. |
| **Octave** | 1–7; default **1** | Adds octave copies; 1 uses the original notes only. Copies outside MIDI pitches 0–127 are omitted. |
| **Octave mode** | Both, Above, Below; default **Both** | Where the octave copies are added. |

The patterns, for held notes 1-2-3 from the lowest:

| Pattern | Steps |
|---|---|
| **Forward** | 1-2-3 |
| **Backward** | 3-2-1 |
| **F->B** | 1-2-3-3-2-1: the top and the bottom twice |
| **B->F** | 3-2-1-1-2-3 |
| **Chord** | every held note at each step |
| **Random** | a step picked at random each time |
| **Up/Down** | 1-2-3-2: the top and the bottom once |
| **Down/Up** | 3-2-1-2 |
| **Converge** | 1-3-2: from the outside in |
| **Diverge** | 2-3-1: from the inside out |
| **Low Up** | 1-2-1-3: the lowest note between each of the others |
| **High Up** | 3-1-3-2: the highest note between each of the others |
| **As played** | the notes in the order their keys were pressed |

With **Octave** above 1, Forward, Backward, F->B, B->F, Random and As played play the whole pattern, then the whole pattern again in each added octave: above first, then below with **Both**. Up/Down, Down/Up, Converge, Diverge, Low Up and High Up instead run through all the notes of all the octaves as one set, from the lowest; a pitch that is both a held note and an octave copy of another plays once. **Chord** adds the octave copies to the chord.

Despite its label, **Rate** is a duration, not hertz. In synchronized mode, steps fall on the musical grid. In free mode, the duration is converted to a grid spacing at the current tempo; this process still schedules its steps through the musical-grid mechanism rather than acting as an independent wall-clock timer.

## Steps

| Control | Choices or range | Behavior |
|---|---|---|
| **Repeat** | 1–8; default **1** | Plays each step this many times before the next. It has no effect on **Chord**, which already plays the whole chord at every step. |
| **Retrigger** | Off, Note, Beat; default **Off** | Starts the pattern again from its first step on each newly pressed key (**Note**) or on each beat (**Beat**). The velocity decay starts over as well. |
| **Seed** | 0–10000; default **0** | For **Random**: at 0 the choices are free; any other value gives the same sequence each time the process starts, and each time the seed is set. |

## Velocity

| Control | Choices or range | Behavior |
|---|---|---|
| **Accent every** | 0–16; default **0** | Every Nth step, counting from the first step of the chord, plays at **Accent vel.**; 0 turns accents off. |
| **Accent vel.** | 1–127; default **127** | The velocity of the accented steps. |
| **Vel. decay** | 0–1; default **0** | At each step since the chord started, the velocity moves this proportion of the remaining way towards **Decay target**. 0 keeps the played velocity. |
| **Decay target** | 1–127; default **1** | The velocity the decay tends towards. |
| **Pressure** | Off, Channel, Poly, Both; default **Off** | Lets aftertouch set the velocity of the following steps: channel pressure for every note, poly pressure for its own key. The latest kind of pressure received wins. A new chord, started with no note left playing, goes back to the key velocities. |

A step's velocity is the key's velocity, or the pressure's, then decayed, then replaced on accented steps. For a note repeat, choose **Chord**, a **Rate** and a **Pressure** mode: the held notes repeat at the rate, at the velocity of the key pressure.

## Latch

| Control | Choices or range | Behavior |
|---|---|---|
| **Latch** | Off, Toggle, Momentary; default **Off** | **Toggle**: released notes keep playing until a key is pressed while none is held, which starts a new chord. **Momentary**: released notes keep playing while **Latch hold** is on. |
| **Latch hold** | on / off | With the **Momentary** latch: keeps the released notes playing while on. Turning it off stops the notes no longer held. |

## MIDI messages

Notes are played on **channel 1**, whatever channel they came in on; held notes are tracked by pitch, not by channel.

Everything that is not a note passes through to the output at the time it came in: controllers, program changes, pitch bend and the rest. Pressure messages are the exception while **Pressure** uses them: channel pressure with Channel or Both, poly pressure with Poly or Both are taken by the arpeggiator and not forwarded.

**All Notes Off** and **All Sound Off** (controllers 123 and 120) end every note the arpeggiator plays, forget the held and latched notes, start the pattern again from its first step, and are forwarded.

Stopping the score, or the process, does the same: notes end, held and latched notes are forgotten, and the pattern starts from its first step.

## Older saved processes

**Arpeggiator (old)** remains separately registered and uses its earlier rate selector. It shares the pattern engine but is not automatically converted to the new time-chooser version. Insert a current Arpeggiator and re-create the intended timing and connections to update a score.

See [MIDI Utilities]({{ site.baseurl }}/processes/midi-utilities.html) for complementary note-processing tools.
