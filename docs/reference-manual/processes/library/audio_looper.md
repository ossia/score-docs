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
| **Overdub** | Records a new layer on top of the loop while it plays. On an empty loop, records the loop first: until the mode changes, or for Bars bars after which overdubbing starts. |
| **Stop** | Outputs no loop. The loop is kept. |
| **Comp** | Overdubs as Overdub does, but taking it up always starts a new layer, even from Overdub. Leaving it ends the layer, as leaving Overdub does. See [Comping](#comping). |

Loop always shows what the looper is asked to do: when an action of the Switches tab, the post-action or a full loop changes the mode, Loop changes with it.

Every control is a port with an address, so the looper can be driven by OSC, MIDI or a footswitch mapping as well as by the mouse.

## Timing

**Quantif** makes a mode change wait for the next point of a grid, so that a loop starts and ends in time. Whole is a bar; None changes at once. See [quantization]({{ site.baseurl }}/in-depth/musical.html#quantization).

**Bars** and **Post-action** make a recording end on its own: after Bars bars, recording gives way to the post-action, Play or Overdub. With Bars at 0, a recording lasts as long as wanted, until the mode is changed.

**Late stop (ms)** handles a recording that is asked to stop a little after a grid point, for example a footswitch pressed just after the downbeat: the recording ends on that grid point instead of a whole grid step later, and playback carries on in time. When it gives way to an overdub, what was played since the grid point is the start of the overdub. The default is 120 ms; 0 turns it off.

**Restart** chooses where playback starts after a mode change: from the beginning of the loop (Always), or, except after a recording, from where it was (Recording). **In phase** keeps the loop on the timeline, see [Restart In phase](#restart-in-phase).

## Footswitches

Loop is a value: setting it to the mode it already has does nothing. A footswitch mapped to Loop can say "overdub" but not "overdub again in a new layer", "go back to the start" or "end this recording into the post-action". The **Switches** tab has actions for that: buttons that act each time they are pressed, made to be mapped to footswitches, MIDI notes or OSC messages. What they change waits for the next point of the grid, as a change of Loop does, and Late stop applies to them; the controls they change (Loop, Layer, Reverse, Speed) show what they changed them to.

| Action | What it does |
|---|---|
| **Rec / Play / Dub** | One button for everything: records an empty loop; while recording, ends the recording into what **After record** says; overdubs a playing loop; while overdubbing or comping, does what **After overdub** says; plays a stopped loop. |
| **Play / Stop** | Plays a stopped loop; stops it in any other mode. Does nothing on an empty loop. |
| **Record** | Records a new loop, in place of the one there is, from any mode. While recording, ends the recording into what After record says. |
| **Overdub** | Overdubs, from any mode. Pressed while overdubbing, does nothing: the layer goes on. |
| **Comp next** | Ends the layer being overdubbed and starts a new one, without stopping. From Play or Stop, starts comping; while recording, ends the recording and starts the first layer over it. |
| **Play**, **Stop** | Play or stop, from any mode. |
| **Restart loop** | Goes back to the start of the loop and stays in the same mode. An overdub goes on from the start in the same layer; a recording starts again. |
| **Undo**, **Redo**, **Clear** | As described in [Layers](#layers). |
| **Erase last** | Erases the newest layer. While overdubbing, that is the layer being overdubbed: as with Undo, it is dropped and overdubbing goes on in a new one. |
| **Mute last** | Mutes the newest layer, or unmutes it. |
| **Previous layer**, **Next layer** | Change **Layer**, the selected layer, at once, from the oldest to the newest. The view outlines the selected lane. |
| **Mute layer**, **Erase layer** | Mute or erase the selected layer, at once. |
| **Solo layer** | Mutes every layer but the selected one. Pressed again, the layers get back the mutes they had, unless a mute or an erase changed them in between. |
| **Toggle reverse** | Turns **Reverse** on or off. |
| **Half speed**, **Double speed** | Set **Speed** to x1/2 or x2, or back to x1 when it already is. |
| **Capture** | See [Capture](#capture). |

Three settings choose what the actions do:

| Setting | Choices |
|---|---|
| **After record** | What Rec / Play / Dub and Record go to when they end a recording. **Play** (default) hears the loop at once, the usual choice. **Overdub** goes on overdubbing from the very frame the recording ends on: nothing played across the end of the loop is cut, for pads and sustained textures. **Comp** does the same in a layer of its own each time. A recording that ends on its own after Bars goes to **Post-action** instead. |
| **After overdub** | What Rec / Play / Dub does while overdubbing. **Play** (default) goes back to playing, as single-switch loopers do. **New layer** goes on overdubbing in a new layer, as Comp next does, for building a loop layer by layer with one switch. |
| **Stop at** | When Stop, Play / Stop and Loop set to Stop stop the loop. **Grid** (default) waits for the next point of the grid, as any change of mode. **Loop end** lets the loop play to its end, for ending a song on a whole loop. **Now** stops at once, ignoring the grid, for a stop that must not wait. |

## Layers

Each overdub pass is a layer of its own. The view shows one lane per layer.

- **Undo** removes the last pass. Pressed during an overdub, it drops the pass in progress and overdubbing carries on in a new one. Undoing the first recording empties the loop.
- **Redo** brings back the last pass undone. A new overdub after an undo replaces what redo would have brought back.
- **Clear** empties the loop and forgets every pass.
- **Feedback** is how much of the loop is kept each time an overdub goes round it. At 1 nothing fades; below 1, older passes fade a little more at each round. Undoing a pass gives the passes under it back the level it took from them.

**Past the end** chooses what an overdub does when it reaches the end of the loop: **Wrap** goes round the loop again; **Extend** makes the loop longer by its length, each time the end is reached, and the passes under it play again over the new part. The extended loop ends when overdubbing stops: on a one-bar loop, overdubbing for four bars makes a four-bar loop, and a shorter overdub after that leaves it as it is. Stopping just after the loop grew, within Late stop, does not add the last length. Undo gives the loop its length back.

**Max layers**, 2 to 32, is the number of passes kept apart. When it is reached, the two oldest passes are merged into one, and that undo step is lost.

### Erasing a pass

Any pass can be taken out of the loop while it plays, not only the last one:

- in the view, with the **x** at the right of its lane. The view shows up to eight lanes; with more passes than that, the oldest share the first lane, which has no **x**.
- with **Layer** and **Erase layer**, in the Switches tab: Layer says which pass, counting from the oldest one, and Erase layer erases it. **Mute layer** mutes it instead, see [Comping](#comping). Layer 1 is the top lane of the view when every pass has a lane of its own, and the file ending in `-layer1` of a take written as layers. Both are ports, so a footswitch or an OSC message can erase a pass.

The passes over the erased one stay where they are and the loop keeps its length, even when the erased pass had extended it. The passes under it get back the level its feedback took from them, as when it is undone. Undo and Redo go on with the passes left, and what Redo would bring back is kept. Erasing is not itself undone by Undo.

Erasing the pass being overdubbed is the same as Undo: the pass is dropped and overdubbing carries on in a new one. Erasing the only pass empties the loop, as Clear does.

## Takes and the timeline

When a recording or an overdub ends, the loop is written to a WAV file: 32-bit float, with its tempo and length in bars stored in the file, and marked as a loop. **Send** in the looper's view places the last take in the timeline as a looping sound file, in a new box starting where the take was recorded, below the looper's box. This is one undoable action.

The take can also be dragged from the looper's view into the timeline, or anywhere a sound file can be dropped.

While a recording or an overdub goes on, the last take does not have it yet. Send, or a press in the view that starts a drag, then asks for a take of the loop as it is heard at that moment, the pass in progress included as far as it went, without stopping it; the Send button says **Saving** until the take is written. Send places it as soon as it is there. A drag starts with the next move of the mouse once it is there, if the button is still held; let go before, the take is the one the next drag or Send gives.

When the score stops while a recording or an overdub goes on, the loop as it is heard is written as a take of its own, its mix only, even if the looper is removed right after.

**Takes** chooses what a take is written as: **Mix**, the loop as it is heard; **Layers**, each pass in a file of its own, as it is heard in the loop; or **Both**. Sending a take places all its files in one box named after the take, a slot each, the mix first; dragging it drops them all.

Takes of a saved score go into a **Takes** folder next to the score. Takes of a score that has not been saved yet go into score's data folder, where they stay until removed. **File > Project files > Consolidate project...** copies the takes a score uses next to it; **File > Project files > Remove unused files...** sets aside the takes in the score's folder that it no longer uses.

## Loading a file

Dropping a sound file on the looper, or choosing it in **Loop file**, replaces the loop with it, up to Max length, and plays it. A file at another sample rate is converted. A mono file goes to every channel.

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

## Tempo changes

**Follow tempo** chooses how a loop follows the tempo of the score, with the same methods as sound files:

| Choice | Behavior |
|---|---|
| **Off** (default) | The loop keeps the speed it was recorded at, and no longer falls on the bars after a tempo change. |
| **Repitch**, **Repitch fast** | The loop is resampled: it keeps to the bars, and its pitch goes up and down with the tempo. |
| **Timestretch**, **Timestretch percussive** | The loop is time-stretched: it keeps to the bars and to its pitch. |

Following applies to a loop that is playing. A loop being recorded or overdubbed plays at its own speed, and a tempo change is heard from the next round of the loop. Mode changes and the post-action always follow the tempo of the score. A take is written with the tempo the loop was recorded at, so a clip made from it follows the tempo of the score like any sound file.

## Reverse and speed

**Reverse** and **Speed**, in the Play tab, play the loop as a tape would be.

- **Reverse** plays the loop backwards, from where the playhead is. Turned off, the loop plays forwards again from there. Nothing is changed in the loop: reversing is only how it is read.
- **Speed** plays the loop at x1/4, x1/2, x1, x2 or x4. The pitch follows the speed: at x1/2 the loop is an octave down and takes twice as long, at x2 an octave up and half as long.

An overdub writes where the playhead goes, as on tape. What is played over the reversed loop sounds reversed once the loop plays forwards again; what is played at x1/2 sounds an octave up, and twice as fast, at x1; at x2, an octave down.

Speed and Reverse change how the loop is read, not the score's time: Quantif, Bars and the post-action, Late stop and sync groups go by the score as before, and a loop keeps its length. A recording is always made forwards at x1: it is what makes the loop. With **Follow tempo**, Speed applies on top of the tempo: at x2, a loop recorded over two bars plays in one bar whatever the tempo, its pitch up an octave even when time-stretched.

**Past the end** set to Extend only extends an overdub going forwards: backwards, the playhead reaches the start of the loop and goes round.

The view's playhead has an arrow pointing the way the loop plays, and the header says when it plays backwards or at another speed than x1. **Phase** goes down from 1 to 0 while the loop plays backwards.

## Comping

**Passes**, in the Comp tab, is for keeping the best of several rounds of an overdub:

| Choice | Behavior |
|---|---|
| **Whole** (default) | An overdub is one pass, from when it starts to when it stops. |
| **Per cycle** | An overdub that goes round the loop several times makes a pass of each round, each starting at the start of the loop. |

A pass per cycle is a pass like any other: it has its own lane, and can be undone or erased on its own. Rounds follow each other without a fade, so all of them together sound as one long overdub would, Feedback included. An overdub that goes round after a recording, with the post-action Overdub or when Overdub was asked on an empty loop, makes a pass per round as well.

**Comp**, the mode, and **Comp next**, in the Switches tab, are for keeping the best of several takes played one after the other: each press of Comp next ends the layer being overdubbed and starts a new one on the next grid point, without stopping, so three presses leave three layers. Entering Comp starts a new layer whatever the mode was, Overdub included. Undo while comping drops the layer in progress, and comping goes on in a new one.

To keep the best round, mute the others: the **m** left of the **x** of a lane mutes its pass, and pressing it again unmutes it. **Mute layer**, in the Switches tab, does the same for the pass **Layer** says, from a port; **Solo layer** mutes all the others at once. A muted pass is kept but not heard, as if it were erased: it takes nothing from the passes under it with its feedback, and it is drawn dimmed. Muted passes are left out of the mix of a take; a take written as layers still has a file for every pass, the muted ones included, as they would be heard, so that the rounds can be spliced in the timeline.

When the two oldest passes are merged to make room, past **Max layers**, a muted one is left out of the merged pass, and lost.

## Restart In phase

With **Restart** set to **In phase**, the loop stays in phase with the timeline. Playing and overdubbing carry on from where they were, as with Recording; and whenever the loop is heard again after being stopped, it starts where it would be had it kept playing since it was recorded:

- after Stop, then Play or Overdub;
- when the score is played again, from wherever it starts;
- when the score jumps to another date while the loop plays.

The position comes from where the loop was recorded on the timeline. Without Follow tempo, it is counted in the score's time: a loop of a second stopped for half a second comes back half a loop on. With Follow tempo, it is counted in quarter notes, so the loop comes back on the bars it was recorded on even after a tempo change. Speed and Reverse are taken into account: the loop comes back where it would be at its speed, going its way.

## Outputs

**Phase** goes from 0 to 1 as the loop plays, to drive anything that should follow the loop, such as video.

## Older scores

Scores made before the layers keep their looper and its settings. Their Loop, Quantif, Passthrough, Post-action, Bars and Restart behave as before.
