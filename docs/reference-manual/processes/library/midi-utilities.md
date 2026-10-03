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

The currently implemented modes are:
- Forward: plays the notes in order (1-2-3-1-2-3)
- Backwards: plays the notes in reverse order (3-2-1-3-2-1)
- F->B: first forward then backwards (1-2-3-3-2-1)
- B->F: first backwards then forward (3-2-1-1-2-3)
- Chord: repeats the chord currently being held

See [Arpeggiator]({{ site.baseurl }}/processes/arpeggiator.html) for its current timing and pattern controls.

## Chord

![Chord]({{ site.img }}/reference/processes/chord.png "Chord example")

This process transforms an input note into a chord.

For instance, if "Major" is selected: C3 -> C3 E3 G3

## MIDI scale

![MIDI scale]({{ site.img }}/reference/processes/midi-scale.png "MIDI scale example")

This process allows to transpose and make the input MIDI fit into predetermined scales, to prevent wrong notes for instance.

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

## MIDI Envelope

[MIDI Envelope]({{ site.baseurl }}/processes/midi-envelope.html) turns note-on/off events into control envelopes. Choose staged or drawn shapes, mono/poly voicing and a voice-combination mode, then connect Out to the parameter to animate.

## MIDI Humanize

[MIDI Humanize]({{ site.baseurl }}/processes/midi-humanize.html) varies note timing, velocity, length and pitch. Chord grouping preserves chord timing, while a nonzero Seed makes a repeatable take. Early timing adds real latency.

## Entity To MIDI

[Entity To MIDI]({{ site.baseurl }}/processes/entity-to-midi.html) maps tracked positions and identities to sustained or triggered notes, including MPE expression. Feed it [Point Tracker]({{ site.baseurl }}/processes/point-tracker.html) records when detections are not already in a stable order.

# Example: using the step sequencer to drive MIDI inputs

![MIDI sequencer example]({{ site.img }}/reference/processes/midi-sequencer-example.png "MIDI sequencer example")