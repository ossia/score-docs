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
| **Overdub** | Records a new layer on top of the loop while it plays. On an empty loop, it is a recording, as Record makes, which then gives way to overdubbing. |
| **Stop** | Outputs no loop. The loop is kept. |

Loop is the state of the looper: it always shows what the looper is doing, or what it is about to do on the next grid point, whatever changed it: an action of the Switches tab, a recording ending after its bars, a full loop, Capture, a file loaded.

Every control is a port with an address, so the looper can be driven by OSC, MIDI or a footswitch mapping as well as by the mouse. A cable or an automation that sends the same mode on every tick asks for it once, when it changes: when the looper changes Loop itself, at the end of a recording for instance, the cable does not ask again and the mode does not flip back.

## Record, Overdub and layers

| | What it is for | What it does to the loop | How layers are cut |
|---|---|---|---|
| **Record** | Making a loop, or making it again. | Replaces the loop and every layer; the loop is as long as the recording, or **Bars** bars. | The recording is the first layer. |
| **Overdub** | Playing over the loop. | Adds what is played on top of the loop, each round fading the layers under it by **Feedback**; with **Past the end** on Extend, makes it longer. | One layer from when it starts to when it stops; with **Passes** on Per cycle, one each time round; **New layer** cuts one where it is pressed. |
| **Play**, **Stop** | Listening, or not. | Nothing. | None. |

A recording ends in one of three ways, and **After record** says what it gives way to whichever it is: its **Bars** running out, the loop reaching **Max length**, or **Rec / Play / Dub**. Setting Loop to another mode during a recording ends it into that mode.

## Timing

**Quantif** makes a mode change wait for the next point of a grid, so that a loop starts and ends in time. Whole is a bar; None changes at once. See [quantization]({{ site.baseurl }}/in-depth/musical.html#quantization). Every action waits for it as well, except Undo, Redo and Clear, which act at once, and selecting a layer.

**Bars** makes a recording end on its own after that many bars, into what **After record** says. With Bars at 0, a recording lasts as long as wanted, until the mode is changed.

**Late stop (ms)** handles a recording that is asked to stop a little after a grid point, for example a footswitch pressed just after the downbeat: the recording ends on that grid point instead of a whole grid step later, and playback carries on in time. When it gives way to an overdub, what was played since the grid point is the start of the overdub. The default is 120 ms; 0 turns it off.

**Start from** chooses where the loop is read from when the mode changes:

| Choice | Behavior |
|---|---|
| **Loop start** | Every change of mode reads the loop from its beginning again. |
| **Where it was** (default) | Playing, overdubbing and stopping carry on from where the playhead is: Play, Overdub and Play again stay in time. |
| **In phase** | As Where it was, and a loop heard again keeps to the timeline, see [Start from In phase](#start-from-in-phase). |

A recording always starts at the loop's start.

## Footswitches

The **Switches** tab has buttons made to be mapped to footswitches, MIDI notes or OSC messages. Play, Stop, Record and Overdub set Loop, exactly as setting it by hand does. The others say what Loop cannot: "the next thing", "a new layer", "from the start", "this layer". What they change waits for the next point of the grid, as a change of Loop does, and Late stop applies to them; the controls they change (Loop, Layer, Reverse, Speed) show what they changed them to.

| Action | What it does |
|---|---|
| **Rec / Play / Dub** | One button for everything: records an empty loop; while recording, ends the recording into what **After record** says; overdubs a playing loop; while overdubbing, does what **After overdub** says; plays a stopped loop. |
| **Play / Stop** | Plays a stopped loop; stops it in any other mode. Does nothing on an empty loop. |
| **Play**, **Stop**, **Record**, **Overdub** | Set Loop to that mode. Record while recording, or Overdub while overdubbing, does nothing. |
| **New layer** | While overdubbing, ends the layer and goes on overdubbing in a new one on the grid, without the playhead moving. Does nothing otherwise. |
| **Retrigger** | Goes back to the start of the loop on the grid, in the same mode: an overdub goes on from the start in the same layer. While recording, starts the recording again, its bars and its tempo counted from there. |
| **Undo**, **Redo**, **Clear** | At once, see [Layers](#layers). |
| **Previous layer**, **Next layer** | Change **Layer**, the selected layer, at once, from the oldest to the newest. The view outlines it. |
| **Mute layer**, **Erase layer** | Mute, unmute or erase the selected layer, on the grid. |
| **Solo layer** | Mutes every layer but the selected one, on the grid. Pressed again on that layer, the layers get back the mutes they had, unless a mute or an erase changed them in between. Pressed on another layer, solos that one. |
| **Toggle reverse** | Turns **Reverse** on or off, on the grid. |
| **Half speed**, **Double speed** | Set **Speed** to x1/2 or x2, or back to x1 when it already is, on the grid. |
| **Capture** | See [Capture](#capture). |

**Layer** moves to each new layer as it is added, so Mute layer, Erase layer and Solo layer act on the newest layer unless Previous layer stepped back.

Rec / Play / Dub and Play / Stop act on the mode the looper will be in once what waits for the grid is taken up. Pressed twice before the grid point, each press is taken up on a grid point of its own: on an empty loop, two presses of Rec / Play / Dub record one grid step and play it. Setting Loop, or pressing Play, Stop, Record or Overdub, replaces whatever was waiting.

Three settings choose what the one-button actions do:

| Setting | Choices |
|---|---|
| **After record** | What a recording gives way to when it ends, by its bars, a full loop or Rec / Play / Dub. **Play** (default) hears the loop at once, the usual choice. **Overdub** goes on overdubbing from the very frame the recording ends on: nothing played across the end of the loop is cut, for pads and sustained textures. A recording made by Overdub on an empty loop always gives way to overdubbing. |
| **After overdub** | What Rec / Play / Dub does while overdubbing. **Play** (default) goes back to playing, as single-switch loopers do. **New layer** goes on overdubbing in a new layer, as New layer does, for building a loop layer by layer with one switch. |
| **Stop at** | When a stop is taken up. **Grid** (default) waits for the next point of the grid, as any change of mode. **Loop end** lets the loop play to its end, for ending a song on a whole loop. **Now** stops at once, ignoring the grid, for a stop that must not wait. |

## Layers

Each overdub pass is a layer of its own. The view shows one lane per layer.

- **Undo** removes the last pass. Pressed during an overdub, it drops the pass in progress and overdubbing carries on in a new one. Pressed during a recording, or **Clear**, starts the recording again at once, its bars and tempo counted from there. Undoing the first recording empties the loop.
- **Redo** brings back the last pass undone. A new overdub after an undo replaces what redo would have brought back.
- **Clear** empties the loop and forgets every pass.
- **Feedback** is how much of the loop is kept each time an overdub goes round it. At 1 nothing fades; below 1, older passes fade a little more at each round. Undoing a pass gives the passes under it back the level it took from them.

**Past the end** chooses what an overdub does when it reaches the end of the loop: **Wrap** goes round the loop again; **Extend** makes the loop longer by its length, each time the end is reached, and the passes under it play again over the new part. The extended loop ends when overdubbing stops: on a one-bar loop, overdubbing for four bars makes a four-bar loop, and a shorter overdub after that leaves it as it is. Stopping just after the loop grew, within Late stop, does not add the last length. Undo gives the loop its length back.

**Max layers**, 2 to 32, is the number of layers kept apart. **At max layers** says what a pass does once there are that many:

| Choice | Behavior |
|---|---|
| **Merge into newest** (default) | The pass is merged into the newest layer when it ends: the oldest layers stay as they are. Undo right after takes the pass out of the newest layer again; once another pass starts, the merge is final. |
| **Merge oldest** | The two oldest layers are merged into one, and that undo step is lost. |
| **Replace a muted layer** | The pass takes the place of the oldest muted layer, or of the newest layer when none is muted. The layer it replaces is gone: undo removes the pass, not the replacement. |

A muted layer that is merged is left out of the merged one, and lost.

### Erasing a pass

Any pass can be taken out of the loop while it plays, not only the last one:

- in the view, with the **x** at the right of its lane, on the next grid point. The view shows up to eight lanes; with more passes than that, the oldest share the first lane, which has no **x**.
- with **Layer** and **Erase layer**, in the Switches tab: Layer says which pass, counting from the oldest one, and Erase layer erases it on the grid. Layer 1 is the top lane of the view when every pass has a lane of its own, and the file ending in `-layer1` of a take written as layers. Both are ports, so a footswitch or an OSC message can erase a pass.

The passes over the erased one stay where they are and the loop keeps its length, even when the erased pass had extended it. The passes under it get back the level its feedback took from them, as when it is undone. Undo and Redo go on with the passes left, and what Redo would bring back is kept. Erasing is not itself undone by Undo.

Erasing the pass being overdubbed is the same as Undo: the pass is dropped and overdubbing carries on in a new one. Erasing the only pass empties the loop, as Clear does.

## Takes and the timeline

When a recording or an overdub ends, the loop is written to a WAV file: 32-bit float, with its tempo and length in bars stored in the file, and marked as a loop. **Send** in the looper's view places the last take in the timeline as a looping sound file, in a new box starting where the take was recorded, below the looper's box. This is one undoable action.

The take can also be dragged from the looper's view into the timeline, or anywhere a sound file can be dropped.

While a recording or an overdub goes on, the last take does not have it yet. Send, or a press in the view that starts a drag, then asks for a take of the loop as it is heard at that moment, the pass in progress included as far as it went, without stopping it; the Send button says **Saving** until the take is written. Send places it as soon as it is there. A drag starts with the next move of the mouse once it is there, if the button is still held; let go before, the take is the one the next drag or Send gives.

When the score stops while a recording or an overdub goes on, the overdub's layer is closed as any, and the loop as it is heard is written as a take of its own, its mix only, even if the looper is removed right after.

**Takes** chooses what a take is written as: **Mix**, the loop as it is heard; **Layers**, each pass in a file of its own, as it is heard in the loop; or **Both**. Sending a take places all its files in one box named after the take, a slot each, the mix first; dragging it drops them all.

Takes of a saved score go into a **Takes** folder next to the score. Takes of a score that has not been saved yet go into score's data folder, where they stay until removed. **File > Project files > Consolidate project...** copies the takes a score uses next to it; **File > Project files > Remove unused files...** sets aside the takes in the score's folder that it no longer uses.

## Loading a file

Dropping a sound file on the looper, or choosing it in **Loop file**, replaces the loop with it, up to Max length, and plays it: Loop shows Play. A file at another sample rate is converted. A mono file goes to every channel.

## Capture

**Capture** makes a loop out of what was just played, even when the looper was not recording. It takes the last **Capture bars** bars of the input and plays them at once, ending on the last grid point when that was just passed, like a late stop. Loop shows Play, so Stop stops it.

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

- **Max length (s)**, default 60, is the longest loop. A recording that reaches it ends into what After record says; the view shows the loop as full.
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

Following applies to a loop that is playing. A loop being recorded or overdubbed plays at its own speed, and a tempo change is heard from the next round of the loop. Mode changes and the end of a recording after its bars always follow the tempo of the score. A take is written with the tempo the loop was recorded at, so a clip made from it follows the tempo of the score like any sound file.

## Reverse and speed

**Reverse** and **Speed**, in the Play tab, play the loop as a tape would be.

- **Reverse** plays the loop backwards, from where the playhead is. Turned off, the loop plays forwards again from there. Nothing is changed in the loop: reversing is only how it is read.
- **Speed** plays the loop at x1/4, x1/2, x1, x2 or x4. The pitch follows the speed: at x1/2 the loop is an octave down and takes twice as long, at x2 an octave up and half as long.

An overdub writes where the playhead goes, as on tape. What is played over the reversed loop sounds reversed once the loop plays forwards again; what is played at x1/2 sounds an octave up, and twice as fast, at x1; at x2, an octave down.

Speed and Reverse change how the loop is read, not the score's time: Quantif, Bars, Late stop and sync groups go by the score as before, and a loop keeps its length. A recording is always made forwards at x1: it is what makes the loop. With **Follow tempo**, Speed applies on top of the tempo: at x2, a loop recorded over two bars plays in one bar whatever the tempo, its pitch up an octave even when time-stretched.

**Past the end** set to Extend only extends an overdub going forwards: backwards, the playhead reaches the start of the loop and goes round.

The view's playhead has an arrow pointing the way the loop plays, and the header says when it plays backwards or at another speed than x1. **Phase** goes down from 1 to 0 while the loop plays backwards.

## Comping

There is no comp mode: comping is overdubbing with layers cut where wanted, then keeping the best.

1. Overdub, and cut the takes into layers: **New layer** on each new attempt, or **Passes** on **Per cycle**, in the Play tab, for a layer each time round the loop, or **After overdub** on **New layer** for Rec / Play / Dub to do it from one switch. The playhead goes on all along.
2. Listen to each: **Previous layer** and **Next layer** select one, **Solo layer** hears it alone, Solo layer again hears them all again.
3. Keep the best: **Mute layer** mutes a layer, **Erase layer** removes it. The **m** and **x** of a lane do the same in the view.

| Passes | Behavior |
|---|---|
| **Whole** (default) | An overdub is one layer, from when it starts to when it stops, unless New layer cuts it. |
| **Per cycle** | An overdub that goes round the loop several times makes a layer of each round, cut on the start of the loop. With Past the end on Extend, a layer is cut each time the loop grows by its length. |

A layer cut by New layer or Per cycle is closed like any: faded at its ends, and written in a take. It has its own lane, and can be undone or erased on its own. A muted layer is kept but not heard, as if it were erased: it takes nothing from the layers under it with its feedback, and it is drawn dimmed. Muted layers are left out of the mix of a take; a take written as layers still has a file for every layer, the muted ones included, as they would be heard, so that the rounds can be spliced in the timeline.

## Start from In phase

With **Start from** set to **In phase**, the loop stays in phase with the timeline. Playing and overdubbing carry on from where they were, as with Where it was; and whenever the loop is heard again after being stopped, it starts where it would be had it kept playing since it was recorded:

- after Stop, then Play or Overdub;
- when the score is played again, from wherever it starts;
- when the score jumps to another date while the loop plays.

The position comes from where the loop was recorded on the timeline. Without Follow tempo, it is counted in the score's time: a loop of a second stopped for half a second comes back half a loop on. With Follow tempo, it is counted in quarter notes, so the loop comes back on the bars it was recorded on even after a tempo change. Speed and Reverse are taken into account: the loop comes back where it would be at its speed, going its way.

## Outputs

**Phase** goes from 0 to 1 as the loop plays, to drive anything that should follow the loop, such as video.

## Older scores

Scores made before the layers keep their looper and its settings. Their Loop, Quantif, Passthrough and Bars behave as before; Post-action is now **After record**, with the same choices, and Restart is now **Start from**: Always is Loop start, Recording is Where it was, In phase is In phase.
