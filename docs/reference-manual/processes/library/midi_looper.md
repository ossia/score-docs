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

Each recording or overdub is a pass, kept as a layer of its own. **Undo** hides the last pass, **Redo** shows it again, **Clear** forgets everything; Undo or Clear during a recording starts it again at once, its bars counted from there. **Start from** is in the Play tab, with Follow tempo.

**Overdub mode**, in the Overdub tab, chooses what a pass does to the notes of the passes under it:

| Choice | Behavior |
|---|---|
| **Merge** (default) | Every pass is heard. |
| **Replace** | A pitch played in a pass silences that pitch in earlier passes, over the part of the loop the pass went through. The rest of the loop is untouched. |

Controllers always replace their own earlier values over the part of the loop a pass went through: a pass that moves CC 74 replaces the earlier CC 74 curve there, and leaves CC 1 and pitch bend alone. Two curves of one controller never fight.

## Record, Overdub and the Switches tab

**Loop**, the **Switches** tab and the settings **After record**, **After overdub**, **Start from** and **Stop at** work as for the [audio looper]({{ site.baseurl }}/processes/audio-looper.html#record-overdub-and-layers): Loop is the state of the looper, Play, Stop, Record and Overdub set it, and Rec / Play / Dub, Play / Stop, New layer, Retrigger and the layer actions do what no value of Loop can. See there for what each one does and when it is taken up.

| | What it is for | What it does to the loop | How layers are cut |
|---|---|---|---|
| **Record** | Making a phrase, or making it again. | Replaces every pass; the loop is as long as the recording, or **Bars** bars. | The recording is the first layer. |
| **Overdub** | Playing over the phrase. | Adds what is played, replacing earlier controllers, and notes with Replace, where it goes; with **Past the end** on Extend, makes the loop longer. | One layer from when it starts to when it stops; with **Passes** on Per cycle, one each time round; **New layer** cuts one where it is pressed. |
| **Play**, **Stop** | Listening, or not. | Nothing. | None. |

With After record set to Overdub, or with Overdub on an empty loop, the overdub starts on the very frame the recording ends on. A note held across the end of the recording is one note of the recording, which wraps round the end of the loop to where it was let go; a note played on the first frame of the overdub is the first note of the new layer.

**Max layers**, 2 to 32, default 8, and **At max layers**, in the Overdub tab, work as for the audio looper: past Max layers, a pass is merged into the newest layer when it ends (the default, which undo can take out again until the next pass), the two oldest layers are merged, or the pass replaces the oldest muted layer, else the newest. Merging moves the notes and controllers of a layer into the other; what either of them replaced stays replaced, muted or erased as the merged layer.

## The view

The view shows one lane per pass, as the audio looper does: up to eight lanes, the oldest passes sharing the first lane when there are more. Each lane is a small piano roll of its own pass, over the pitches that pass played. Notes a later pass replaced are drawn dimmed.

## Erasing a pass

As with the [audio looper]({{ site.baseurl }}/processes/audio-looper.html#erasing-a-pass), any pass can be erased while the loop plays, with the **x** of its lane or with **Layer** and **Erase layer**, on the grid. Layer is on the newest layer unless it was stepped back. Its notes and controllers go; the passes over it stay where they are, and the loop keeps its length. Erasing the pass being overdubbed is the same as Undo, and erasing the only pass empties the loop. The notes the loop was playing end, as with Undo.

What only the erased pass replaced is heard again. What a later pass replaced as well stays replaced: if the second pass and the third both played a C over the C of the first one, erasing or muting the second leaves the first one's C silent, because the third still replaces it.

## Notes at the edges of the loop

**Held notes** chooses what a note held across the end of the loop does: **Wrap** (default) carries it on from the start of the loop, **Truncate** ends it with the loop.

**Grace (ms)**, default 60, is for a note played slightly before a recording or an overdub starts: it is recorded on the first beat instead of being lost. The other way round, a recording asked to stop a little after a grid point, within **Late stop (ms)**, ends on that point; when it gives way to an overdub, the notes played since the point are the overdub's, where they were played.

A note held on the input is never sent twice when the loop plays the same note.

## Quantize

**Grid** and **Quantize** pull the notes towards a grid when they are played back. At a Quantize of 0 the notes play as recorded; at 1 they play on the grid. **Quantize ends** pulls the ends of the notes too. A note sounding when one of them changes ends where it was going to: the change applies from its next start, and a note moved to where the playhead has yet to go plays there once it has ended.

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

When a recording or an overdub ends, what is heard of the loop is written to a Standard MIDI File, at 120 BPM so that a quarter note is half a second of score's time, and ending exactly at the end of the loop. **Send** in the looper's view, or a drag from it, places it in the timeline as a MIDI clip that holds the notes, where the take was recorded. The file can also be opened in any other MIDI editor. **Takes** writes what is heard of the whole loop (**Mix**), each pass in a file of its own (**Layers**), or both; the files go in one box, a looping clip each, the mix first.

While a recording or an overdub goes on, Send or a drag asks for a take of the loop as it is heard at that moment, the pass in progress included, a key still held lasting up to the playhead; the Send button says **Saving** until it is written, as for the audio looper. When the score stops while a pass is taken in, the pass is closed as any, and the loop as it is heard is written as a take of its own, its mix only.

## Reverse and speed

**Reverse** and **Speed**, in the Play tab, work as for the [audio looper]({{ site.baseurl }}/processes/audio-looper.html#reverse-and-speed).

- Played backwards, a note plays where it ended: a note over the first quarter of a one-bar loop plays over its last quarter. A note held across the end of the loop wraps or is truncated as it was forwards: truncated, what was heard of it at the end of the loop is heard at its start. A controller, pitch bend or pressure goes back the way it came: going back over a point where it changed, it takes the value it had before, so a sustain pedal held over a part of the loop is held over that part backwards.
- **Speed** plays the loop at x1/4 to x4: at x2, a phrase takes half as long. With **Follow tempo**, Speed applies on top of the tempo.

An overdub records where the playhead goes. A phrase played over the reversed loop plays reversed when the loop goes forwards again, its notes starting where they were let go; a phrase played at x1/2 plays twice as fast at x1. A recording is always made forwards at x1.

The notes the loop was playing end when it turns round.

## Comping

As for the [audio looper]({{ site.baseurl }}/processes/audio-looper.html#comping), there is no comp mode: overdub, cut the takes into layers with **New layer**, with **Passes** on **Per cycle** (in the Overdub tab) or with **After overdub** on **New layer**, then step through them with **Previous layer** and **Next layer**, hear one with **Solo layer**, and keep the best with **Mute layer** and **Erase layer**, or the **m** and **x** of the lanes. A note held across the start of the loop belongs to the round it started in. Each layer cut is closed like any, and written in a take.

A muted layer's notes and controllers are not heard, and it replaces nothing, so with Replace the notes it replaced are heard again while it is muted, unless another layer replaces them as well. Muted layers are left out of the mix of a take, and still have their own file in a take written as layers. The notes the loop was playing end when a layer is muted or unmuted.

## Start from In phase

**Start from** set to **In phase** keeps the loop in phase with the timeline, as for the [audio looper]({{ site.baseurl }}/processes/audio-looper.html#start-from-in-phase). With Follow tempo, on by default, the position is counted in quarter notes, so the loop comes back on its bars after a tempo change.

## Capture

**Capture** makes a loop out of the last **Capture bars** bars played, recorded or not, and plays it at once; Loop shows Play. The MIDI looper always keeps the last few thousand events it received, so there is nothing to set up.

## Capacity

A loop holds up to 4096 notes and 8192 controller values. When it is full, the view says so and further events are not recorded.
