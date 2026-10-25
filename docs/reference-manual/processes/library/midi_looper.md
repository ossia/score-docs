---
layout: default

title: MIDI looper
description: "Record notes and controllers in passes, play them back in time, and turn the loop into a MIDI clip of the timeline"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-looper.html
---
# MIDI Looper

![MIDI looper]({{ site.img }}/reference/processes/midi_looper.png "The MIDI looper playing a two bar phrase")

The process named **Looper (MIDI)** records the notes, controllers, pitch bend and pressure it receives at **in** into a loop, and plays them back at **out**. It shares its transport, timing, undo, sync groups, capture and timeline features with the [audio looper]({{ site.baseurl }}/processes/audio-looper.html); this page describes what is particular to MIDI.

The recording keeps its own timing: quantize, transpose and channel changes only apply on playback, and can be changed at any time without losing anything.

## Passes and overdubs

Each recording or overdub is a pass. **Undo** hides the last pass, **Redo** shows it again, **Clear** forgets everything.

**Overdub** chooses what a pass does to the notes of the passes under it:

| Choice | Behavior |
|---|---|
| **Merge** (default) | Every pass is heard. |
| **Replace** | A pitch played in a pass silences that pitch in earlier passes, over the part of the loop the pass went through. The rest of the loop is untouched. |

Controllers always replace their own earlier values over the part of the loop a pass went through: a pass that moves CC 74 replaces the earlier CC 74 curve there, and leaves CC 1 and pitch bend alone. Two curves of one controller never fight.

## The view

The view shows one lane per pass, as the audio looper does: up to eight lanes, the oldest passes sharing the first lane when there are more. Each lane is a small piano roll of its own pass, over the pitches that pass played. Notes a later pass replaced are drawn dimmed.

## Erasing a pass

As with the [audio looper]({{ site.baseurl }}/processes/audio-looper.html#erasing-a-pass), any pass can be erased while the loop plays, with the **x** of its lane or with **Layer** and **Erase layer**. Its notes and controllers go; the passes over it stay where they are, and the loop keeps its length. Erasing the pass being overdubbed is the same as Undo, and erasing the only pass empties the loop. The notes the loop was playing end, as with Undo.

What only the erased pass replaced is heard again. What a later pass replaced as well stays replaced: if the second pass and the third both played a C over the C of the first one, erasing the second leaves the first one's C silent, because the third still replaces it.

## Notes at the edges of the loop

**Held notes** chooses what a note held across the end of the loop does: **Wrap** (default) carries it on from the start of the loop, **Truncate** ends it with the loop.

**Grace (ms)**, default 60, is for a note played slightly before a recording or an overdub starts: it is recorded on the first beat instead of being lost.

A note held on the input is never sent twice when the loop plays the same note.

## Quantize

**Grid** and **Quantize** pull the notes towards a grid when they are played back. At a Quantize of 0 the notes play as recorded; at 1 they play on the grid. **Quantize ends** pulls the ends of the notes too.

## Notes and channels

- **Transpose** moves the notes of the loop by semitones.
- **In channel** chooses the channel recorded; 0 records them all.
- **Out channel** plays the loop on one channel; 0 keeps the recorded ones.
- **Passthrough** chooses when the input is heard, as for the audio looper. It is Full by default.

Changing the transposition or the output channel, stopping, undoing, erasing a pass or clearing ends the notes the loop was playing.

Overdubbing an empty loop records it, as with the audio looper.

## Tempo changes

With **Follow tempo**, on by default, the loop plays at the tempo of the score: a loop recorded over two bars lasts two bars whatever the tempo becomes. Off, it keeps the speed it was recorded at. Either way the quantize grid stays on the loop's own beats, and its takes have the tempo it was recorded at.

**Past the end** works as for the audio looper: an overdub can make the loop longer, the passes under it repeating.

## Takes and the timeline

When a recording or an overdub ends, what is heard of the loop is written to a Standard MIDI File, at 120 BPM so that a quarter note is half a second of score's time, and ending exactly at the end of the loop. **Send**, **Send to timeline**, or a drag from the view places it in the timeline as a MIDI clip that holds the notes, where the take was recorded. The file can also be opened in any other MIDI editor. **Takes** writes what is heard of the whole loop (**Mix**), each pass in a file of its own (**Layers**), or both; the files go in one box, a looping clip each, the mix first.

## Capture

**Capture** makes a loop out of the last **Capture bars** bars played, recorded or not, and plays it at once. The MIDI looper always keeps the last few thousand events it received, so there is nothing to set up.

## Capacity

A loop holds up to 4096 notes and 8192 controller values. When it is full, the view says so and further events are not recorded.
