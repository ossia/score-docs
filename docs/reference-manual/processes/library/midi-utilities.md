---
layout: default

title: MIDI utilities
description: "MIDI utility processes in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-utilities.html
---

# MIDI utilities

## Arpeggiator

![Arpeggiator]({{ site.img }}/reference/processes/arpeggiator.png "Arpeggiator example"){:.floatleft}

The classic arpeggiator effect. Play a chord on your keyboard and let the process create
new notes from it.

Some of its patterns:
- Forward: plays the notes in order (1-2-3-1-2-3)
- Backward: plays the notes in reverse order (3-2-1-3-2-1)
- F->B: first forward then backwards (1-2-3-3-2-1)
- B->F: first backwards then forward (3-2-1-1-2-3)
- Chord: repeats the chord currently being held

See [Arpeggiator]({{ site.baseurl }}/processes/arpeggiator.html) for all its patterns and its timing, velocity and latch controls.

## Chord

![Chord]({{ site.img }}/reference/processes/chord.png "Chord example")

This process transforms an input note into a chord.

For instance, if "Major" is selected: C3 -> C3 E3 G3

Its Mode picks where the chord comes from:
- Chord: the chord type chosen in the list, with up to Num. Notes notes.
- Harmonizer: the Intervals list, in semitones from the played note.
- Memory: a chord of its own for each key, from the Memory list.

The Memory list has one row per key: the key, then the semitones of each note
from that key, e.g. `C4: 0 4 7` (C4 is MIDI note 60; `60: 0 4 7` works too).
Rows are added with "+", removed with "x", and edited by double-clicking them; a
key without a row plays itself. To fill it from a keyboard, turn on Learn, play
a chord, release it, then press the key that will trigger it: the row for that
key appears in the list.

## MIDI scale

![MIDI scale]({{ site.img }}/reference/processes/midi-scale.png "MIDI scale example")

This process allows to transpose and make the input MIDI fit into predetermined scales, to prevent wrong notes for instance.

Lowest and Range limit it to part of the keyboard: only the notes from Lowest
to Lowest + Range are scaled and transposed, the others pass unchanged. For
instance the preset "Fifth up above C4 only" has Lowest at 60 (C4) and
Transpose at 7: C4 plays G4 and E4 plays B4, while every key below C4 plays
itself.

## Quantifier

![Quantifier]({{ site.img }}/reference/processes/quantifier.png "Quantifier example")

This process quantifies input MIDI onto the musical grid.

See [Midi Quantify]({{ site.baseurl }}/processes/midi-quantify.html) for the distinction between onset and release quantization.

## MIDI pitch

![MIDI pitch]({{ site.img }}/reference/processes/midi-pitch.png "MIDI pitch example")

This process allows to extract the pitch of a MIDI note as a simple value.

## Pulse to note

![Pulse to note]({{ site.img }}/reference/processes/pulse-to-note.png "Pulse to note example")

This process allows to convert input signals into MIDI.

* If the input is of type impulse, then the default velocity and default pitch are used.
* If the input is of type int, then it is used as pitch and the velocity is set with the default velocity.
* If the input is of type vec2, then the first element is the pitch, the second is the velocity.

## Midi Glide

Midi Glide makes a stream monophonic: one note sounds at a time, chosen among
the keys held as a monophonic synthesizer does.

| Control | Meaning |
| --- | --- |
| **Priority** | The held key that sounds: **Last** pressed, **Low**est or **High**est. A key that does not win is remembered. |
| **On release** | When the sounding key is released while others are held: **Stop** ends the note and forgets the keys still held; **Return** goes back to the held key that wins, at the velocity it was played with. |
| **Transition** | **Retrigger** ends a note before starting the next. **Legato** starts the next one first, which a synthesizer in legato ("fingered") mode plays as a slide: glide, and no new attack. |
| **Latch** | **Toggle**: the note keeps sounding when its key is released, until another key takes over. **Momentary**: the same while **Hold** is pressed; the latched note ends when Hold is let go. |

The defaults (Last, Stop, Retrigger, no latch) are a plain monophonic legato.

## Midi transform

Midi transform turns one kind of MIDI message into another. Its **Value**
outlet gives the value of each message it produces, at the time of the message:

* note on and note off: the velocity; CC: the controller value; poly
  pressure: the pressure (0 to 127);
* program change, channel pressure, MTC quarter frame, song select: the data
  byte (0 to 127);
* pitch bend: -1 to 1, 0 at the center;
* song position: 0 to 16383, in sixteenth notes;
* tune request and real-time messages: no value.

Messages that pass through untransformed have no value. With **Into** set to
Note on, the note-off that ends a produced note gives 0.

## Midi value shaper

Midi value shaper reshapes velocities, controllers, pitch bend or pressure. Its
**Value** outlet gives each shaped value as it is sent, at its time: 0 to 127
for velocities, controllers and pressure, -1 to 1 for pitch bend.

## Midi sustain

Midi sustain holds notes after their key is released, like a sustain pedal: CC
64 of each channel, or the **Pedal** button, which holds every channel while it
is pressed.

## MIDI Envelope

[MIDI Envelope]({{ site.baseurl }}/processes/midi-envelope.html) turns note-on/off events into control envelopes. Choose staged or drawn shapes, mono/poly voicing and a voice-combination mode, then connect Out to the parameter to animate.

## MIDI Humanize

[MIDI Humanize]({{ site.baseurl }}/processes/midi-humanize.html) varies note timing, velocity, length and pitch. Chord grouping preserves chord timing, while a nonzero Seed makes a repeatable take. Early timing adds real latency.

## Entity To MIDI

[Entity To MIDI]({{ site.baseurl }}/processes/entity-to-midi.html) maps tracked positions and identities to sustained or triggered notes, including MPE expression. Feed it [Point Tracker]({{ site.baseurl }}/processes/point-tracker.html) records when detections are not already in a stable order.

# Example: using the step sequencer to drive MIDI inputs

![MIDI sequencer example]({{ site.img }}/reference/processes/midi-sequencer-example.png "MIDI sequencer example")