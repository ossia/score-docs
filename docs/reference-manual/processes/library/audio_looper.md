---
layout: default

title: Audio looper
description: "Record audio in layers, play it back in time, and turn the loop into a clip of the timeline"

parent: Processes
grand_parent: Reference

permalink: /processes/audio-looper.html
---
# Audio Looper

![Audio looper]({{ site.img }}/reference/processes/audio_looper.png "The audio looper playing a two bar loop")

The process named **Looper (audio)** records the audio it receives at **in** into a loop and plays it back at **out**. Each overdub is kept as a layer of its own, so it can be undone, and every take is written to a file that can be placed in the timeline as a regular sound clip.

The [MIDI looper]({{ site.baseurl }}/processes/midi-looper.html) works the same way with notes and controllers.

## Modes

**Loop** chooses what the looper does:

| Mode | Behavior |
|---|---|
| **Play** | Plays the loop. |
| **Record** | Records a new loop, replacing the current one and all its layers. |
| **Overdub** | Records a new layer on top of the loop while it plays. |
| **Stop** | Outputs no loop. The loop is kept. |

Every control is a port with an address, so the looper can be driven by OSC, MIDI or a footswitch mapping as well as by the mouse.

## Timing

**Quantif** makes a mode change wait for the next point of a grid, so that a loop starts and ends in time. Whole is a bar; None changes at once. See [quantization]({{ site.baseurl }}/in-depth/musical.html#quantization).

**Bars** and **Post-action** make a recording end on its own: after Bars bars, recording gives way to the post-action, Play or Overdub. With Bars at 0, a recording lasts until the mode is changed by hand.

**Late stop (ms)** handles a recording that is asked to stop a little after a grid point, for example a footswitch pressed just after the downbeat: the recording ends on that grid point instead of a whole grid step later, and playback carries on in time. The default is 120 ms; 0 turns it off.

**Restart** chooses where playback starts after a mode change: from the beginning of the loop (Always), or, except after a recording, from where it was (Recording).

## Layers

Each overdub pass is a layer of its own. The view shows one lane per layer.

- **Undo** removes the last pass. Pressed during an overdub, it drops the pass in progress and overdubbing carries on in a new one. Undoing the first recording empties the loop.
- **Redo** brings back the last pass undone. A new overdub after an undo replaces what redo would have brought back.
- **Clear** empties the loop and forgets every pass.
- **Feedback** is how much of the loop is kept each time an overdub goes round it. At 1 nothing fades; below 1, older passes fade a little more at each round. Undoing a pass gives the passes under it back the level it took from them.

**Max layers** is the number of passes kept apart. When it is reached, the two oldest passes are merged into one, and that undo step is lost.

## Takes and the timeline

When a recording or an overdub ends, the loop is written to a WAV file: 32-bit float, with its tempo and length in bars stored in the file, and marked as a loop. **Send** in the view, or the **Send to timeline** control, places the last take in the timeline as a looping sound file, in a new box starting where the take was recorded, below the looper's box. This is one undoable action.

The take can also be dragged from the looper's view into the timeline, or anywhere a sound file can be dropped.

Takes of a saved score go into a **Takes** folder next to the score. Takes of a score that has not been saved yet go into score's data folder, where they stay until removed. **File > Project files > Consolidate project...** copies the takes a score uses next to it; **File > Project files > Remove unused files...** sets aside the takes in the score's folder that it no longer uses.

## Capture

**Capture** makes a loop out of what was just played, even when the looper was not recording. It takes the last **Capture bars** bars of the input and plays them at once, ending on the last grid point when that was just passed, like a late stop.

Capture needs **Keep last (s)**, the number of seconds of input the looper keeps at all times. It is 0 by default, which keeps nothing and uses no memory.

## Sync groups

**Sync** puts loopers in a group, A to D. The first looper of a group to record sets the group's loop. The loops recorded after it are rounded to a whole number of that loop, or to a half, a quarter or an eighth of it, and play in phase with it. Clearing the looper that set the loop frees the group.

## Monitoring

**Passthrough** chooses when the input is heard:

| Choice | Behavior |
|---|---|
| **None** | The input is never heard. |
| **Record** | The input is heard while recording and overdubbing only. |
| **Full** | The input is always heard, mixed over the loop. |

## Memory and latency

- **Max length (s)**, default 60, is the longest loop. A recording that reaches it ends, and the post-action takes over; the view shows the loop as full.
- **Channels**, default 2, is the number of channels recorded.
- **Latency (ms)** moves what is recorded earlier in the loop, to make up for the time the input takes to reach the looper.
- **Engine latency** adds the input and output latency the audio driver reports, for a performer playing from the sound card along with the loop. JACK and PortAudio report it; with other drivers, set Latency by hand. Leave it off for input made inside score, which has no such delay.

The memory for these is reserved when playback starts, so changes to Max length, Max layers, Channels and Keep last apply from the next start.

## Outputs

**Phase** goes from 0 to 1 as the loop plays, to drive anything that should follow the loop, such as video.

## Older scores

Scores made before the layers keep their looper and its settings. Their Loop, Quantif, Passthrough, Post-action, Bars and Restart behave as before.
