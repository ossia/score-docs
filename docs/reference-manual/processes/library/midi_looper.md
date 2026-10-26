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

The recording keeps its own timing: quantize, transpose and channel changes only apply on playback, and can be changed at any time without losing anything. A take is what the loop plays with the quantize of the moment, but not transposed and on the recorded channels, see [Takes and the timeline](#takes-and-the-timeline).

## Passes and overdubs

Each recording or overdub is a pass, kept as a layer of its own. **Undo** hides the last pass, **Redo** shows it again, **Clear** forgets everything; Undo or Clear during a recording starts it again at once, its bars counted from there. **Start from** is in the Play tab, with Follow tempo.

**Overdub mode**, in the Overdub tab, chooses what a pass does to the notes of the passes under it:

| Choice | Behavior |
|---|---|
| **Merge** (default) | Every pass is heard. |
| **Replace** | A pitch played in a pass silences that pitch in earlier passes, over the part of the loop the pass went through. The rest of the loop is untouched. |

Controllers always replace their own earlier values over the part of the loop a pass went through: a pass that moves CC 74 replaces the earlier CC 74 curve there, and leaves CC 1 and pitch bend alone. Two curves of one controller never fight.

## Record, Overdub and the Switches tab

**Loop**, the **Switches** tab and the settings **Quantif**, **After record**, **After overdub**, **Start from** and **Stop at** work as for the [audio looper]({{ site.baseurl }}/processes/audio-looper.html#record-overdub-and-layers): Loop is the state of the looper, Play, Stop, Record and Overdub set it, and Rec / Play / Dub, Play / Stop, New layer, Retrigger and the layer actions do what no value of Loop can. See there for what each one does and when it is taken up.

| | What it is for | What it does to the loop | How layers are cut |
|---|---|---|---|
| **Record** | Making a phrase, or making it again. | Replaces every pass; the loop is as long as the recording, or **Bars** bars. | The recording is the first layer. |
| **Overdub** | Playing over the phrase. | Adds what is played, replacing earlier controllers, and notes with Replace, where it goes; with **Past the end** on Extend, makes the loop longer. | One layer from when it starts to when it stops; with **Passes** on Per cycle, one each time round; **New layer** cuts one where it is pressed. |
| **Play**, **Stop** | Listening, or not. | Nothing. | None. |

With After record set to Overdub, or with Overdub on an empty loop, the overdub starts on the very frame the recording ends on. A note held across the end of the recording is one note of the recording, which wraps round the end of the loop to where it was let go; a note played on the first frame of the overdub is the first note of the new layer.

**Max layers**, 2 to 32, default 8, and **At max layers**, in the Overdub tab, work as for the audio looper: past Max layers, a pass is merged into the newest layer when it ends (the default, which undo can take out again until the next pass), the two oldest layers are merged, or the pass replaces the oldest muted layer, else the newest (which undo puts back, and redo replaces again, until the next pass). Merging moves the notes and controllers of a layer into the other; what either of them replaced stays replaced, muted or erased as the merged layer.

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

**Quantif** is when a mode change is taken up: a time, a note value, a number of bars, or the loop itself, as for the [audio looper]({{ site.baseurl }}/processes/audio-looper.html#timing). With **Loop**, a change waits for the loop to come round to its start, wherever that falls in the bar; before there is a loop, it waits for **Bars** bars, or one bar when Bars is 0. A score or a preset made when Quantif was a list of note values gets the grid it waited for: Whole is **1 bar**, None is None, and the others are the same note values. The rest of this section is about the notes, not the mode changes.

**Grid** (default a quarter note, **4th**) and **Quantize** (default 0) pull the notes towards a grid when they are played back. At a Quantize of 0 the notes play as recorded; at 1 they play on the grid. **Quantize ends** pulls the ends of the notes too. A note sounding when one of them changes ends where it was going to: the change applies from its next start, and a note moved to where the playhead has yet to go plays there once it has ended.

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

When a recording or an overdub ends, what is heard of the loop is written to a Standard MIDI File, at 120 BPM so that a quarter note is half a second of score's time, and ending exactly at the end of the loop. **Send** in the looper's view, or a drag from it, places it in the timeline as a MIDI clip that holds the notes, where the take was recorded. The file can also be opened in any other MIDI editor. **Export** chooses what a take writes: what is heard of the whole loop (**Mix**, the default), each pass in a file of its own (**Layers**), or both; the files go in one box, a looping clip each, the mix first.

A take has the notes where the loop plays them: **Quantize**, **Grid** and **Quantize ends** are applied to it, and so is **Held notes**. **Transpose** and **Out channel** are not: the notes are at the pitch and on the channel they were played, so that the clip can be transposed or routed again in the timeline.

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

## Presets

As for the [audio looper]({{ site.baseurl }}/processes/audio-looper.html#presets), each preset sets every setting, quantized to the bar unless said otherwise, and what is played is always heard.

| Preset | What it is for |
|---|---|
| **Song form** | Record, Play, Overdub and Play again. Quantif is Loop: the first recording ends on a bar, then every change waits for the loop to come round, and a stop lets it play to its end. |
| **One footswitch, song form** | The same from Rec / Play / Dub alone, with a Late stop of 250 ms. |
| **One footswitch, layering** | Rec / Play / Dub records, goes straight on overdubbing, and each press after that starts a new layer. |
| **Comping, a layer per press** | Each press of Rec / Play / Dub while overdubbing starts a new take in a layer of its own; once there are 16, a new take replaces a muted one. |
| **Comping, a layer per round** | One overdub, a layer each time round the loop; takes are written as a mix and as layers. |
| **Four bar phrase** | A recording of four bars, then plays it. |
| **Four bars, then overdub** | A recording of four bars, then goes on overdubbing: a chord held across the end of the loop is not cut. |
| **Free phrase** | No grid, no Bars, no Late stop: the loop is as long as it was played for. |
| **Overdub drums** | Two bars, then overdubbing; notes end with the loop. |
| **Drum pattern on channel 10** | Records channel 10 only, two bars then overdubbing; a hit replaces the hits of that pitch under it, notes end with the loop, and play back on the sixteenth. |
| **Replace as you play** | Four bars, then overdubbing, a pitch played replacing that pitch in the passes under it. |
| **Sixteenths, 70 percent** | Notes pulled 70 percent of the way to the sixteenth on playback; mode changes on the quarter note. |
| **Octave up** | The loop plays an octave above what was played. |
| **Half speed** | The loop plays twice as slow; what is overdubbed plays twice as fast at x1. |
| **Grows as you overdub** | A bar long recording, and Past the end on Extend: overdubbing over several bars makes the loop that long. |
| **In phase with the timeline** | Start from In phase: a loop played again after a stop, or when the score starts or jumps, is where it would be had it kept playing. |
| **Capture what I played** | Capture makes a loop of the last four bars played. |
| **Takes for editing** | **Export** on Both: takes are written as a mix and as a MIDI file for each layer. |
| **Second loop of group A** | Sync group A, for a loop recorded after another one of the group. |

## Capacity

A loop holds up to 4096 notes and 8192 controller values. When it is full, the view says so and further events are not recorded.
