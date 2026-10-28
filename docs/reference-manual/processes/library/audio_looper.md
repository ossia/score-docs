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

The [MIDI looper]({{ site.baseurl }}/processes/midi-looper.html) works the same way with notes and controllers, and the [value looper]({{ site.baseurl }}/processes/value-looper.html) with any stream of values.

## Modes

**Mode** chooses what the looper does:

| Mode | Behavior |
|---|---|
| **Play** | Plays the loop. |
| **Record** | Records an empty loop. On a loop that has something in it, overdubs it, as on a looper pedal: to record a new loop, **Clear** it first. |
| **Overdub** | Records a new layer on top of the loop while it plays. On an empty loop, it is a recording, as Record makes, which then gives way to overdubbing. |
| **Stop** | Outputs no loop. The loop is kept. |

Mode is the state of the looper: it always shows what the looper is doing, or what it is about to do on the next grid point, whatever changed it: an action of the Switches tab, a recording ending after its bars, a full loop, Capture, a file loaded.

Every control is a port with an address, so the looper can be driven by OSC, MIDI or a footswitch mapping as well as by the mouse. A cable or an automation that sends the same mode on every tick asks for it once, when it changes: when the looper changes Mode itself, at the end of a recording for instance, the cable does not ask again and the mode does not flip back.

## Record, Overdub and layers

| | What it is for | What it does to the loop | How layers are cut |
|---|---|---|---|
| **Record** | Making a loop. | Makes the loop: it is as long as the recording, or **Record bars** bars. On a loop that has something in it, Record overdubs: Clear first to make the loop again. | The recording is the first layer. |
| **Overdub** | Playing over the loop. | Adds what is played on top of the loop, each round fading the layers under it by **Feedback**; with **Past the end** on Extend, makes it longer. | One layer from when it starts to when it stops; with **Passes** on Per cycle, one each time round; **New layer** cuts one where it is pressed. |
| **Play**, **Stop** | Listening, or not. | Nothing. | None. |

A recording ends in one of three ways, and **After record** says what it gives way to whichever it is: its **Record bars** running out, the loop reaching **Max length**, or **Rec / Play / Dub**. Setting Mode to another mode during a recording ends it into that mode.

## Timing

**Quantize** makes a mode change wait for the next point of a grid, so that a loop starts and ends in time. Every action waits for it as well, except Undo, Redo and Clear, which act at once, and selecting a layer. Dragging the knob goes through the values of a unit; clicking its readout chooses the unit:

| Unit | Values | The grid |
|---|---|---|
| **Free time** | None, or up to 8 seconds | Every that many seconds, counted from the loop's start once there is a loop. **None** changes at once. |
| **Note value** | 1/64 to 4/1, straight, dotted or triplet | A note value, whatever the signature: **1/4** is a quarter note (the default), **1/1** a whole note, four quarters, which is not a bar in 3/4. Shorter than a bar, the grid starts again on every bar line. See [quantization]({{ site.baseurl }}/in-depth/musical.html#quantization). |
| **Bars** | 1 to 16 bars | Whole bars of the current signature: **3 bars** is a phrase of three bars. |
| **Loop** | 1/4 loop to 8x loop | The loop itself: **Loop** waits for the loop to come round to its start, **2x loop** for every other time, **1/2 loop** for its start and its middle. |

**Loop** follows the loop as it plays: its length whatever it is, on the bar grid or not, its speed and its direction. An overdub that makes the loop longer waits for the end of the loop as long as it is so far. A stopped loop goes by where it would be had it kept playing since it was recorded. Before there is a loop, while it is empty or being recorded, Loop waits for the length the recording will have: **Record bars** bars, or one bar when Record bars is 0 (2x loop is twice that).

**Record bars** makes a recording end on its own after that many bars, into what **After record** says. With Record bars at 0, a recording lasts as long as wanted, until the mode is changed.

**Late stop (ms)** handles a recording that is asked to stop a little after a grid point, for example a footswitch pressed just after the downbeat: the recording ends on that grid point instead of a whole grid step later, and playback carries on in time. When it gives way to an overdub, what was played since the grid point is the start of the overdub. The default is 120 ms; 0 turns it off.

**Start from** chooses where the loop is read from when the mode changes:

| Choice | Behavior |
|---|---|
| **Loop start** | Every change of mode reads the loop from its beginning again. |
| **Where it was** (default) | Playing, overdubbing and stopping carry on from where the playhead is: Play, Overdub and Play again stay in time. |
| **In phase** | As Where it was, and a loop heard again keeps to the timeline, see [Start from In phase](#start-from-in-phase). |

A recording always starts at the loop's start.

## Footswitches

The **Switches**, **Layers** and **Speed** tabs have buttons made to be mapped to footswitches, MIDI notes or OSC messages: Switches holds the one-button actions and the transport, Layers holds Undo, Redo, Clear, Layer and what acts on the selected layer, and Speed holds Speed, Reverse and Follow tempo with Toggle reverse, Half speed and Double speed. **Capture** is in the Length tab, next to Capture bars. Play, Stop, Record and Overdub set Mode, exactly as setting it by hand does. The others say what Mode cannot: "the next thing", "a new layer", "from the start", "this layer". What they change waits for the next point of the grid, as a change of Mode does, and Late stop applies to them; the controls they change (Mode, Layer, Reverse, Speed) show what they changed them to.

| Action | What it does |
|---|---|
| **Rec / Play / Dub** | One button for everything: records an empty loop; while recording, ends the recording into what **After record** says; overdubs a playing loop; while overdubbing, does what **After overdub** says; plays a stopped loop. |
| **Play / Stop** | Plays a stopped loop; stops it in any other mode. Does nothing on an empty loop. |
| **Play**, **Stop**, **Record**, **Overdub** | Set Mode to that mode. Record on a loop that has something in it overdubs it, and Mode shows Overdub. Record while recording, or Overdub while overdubbing, does nothing. |
| **New layer** | While overdubbing, ends the layer and goes on overdubbing in a new one on the grid, without the playhead moving. Does nothing otherwise. |
| **Retrigger** | Goes back to the start of the loop on the grid, in the same mode: an overdub goes on from the start in the same layer. While recording, starts the recording again, its bars and its tempo counted from there. |
| **Undo**, **Redo**, **Clear** | At once, see [Layers](#layers). |
| **Previous layer**, **Next layer** | Change **Layer**, the selected layer, at once, from the oldest to the newest. The view outlines it. |
| **Mute layer**, **Erase layer** | Mute, unmute or erase the selected layer, on the grid. |
| **Solo layer** | Mutes every layer but the selected one, on the grid. Pressed again on that layer, the layers get back the mutes they had, unless a mute or an erase changed them in between. Pressed on another layer, solos that one. |
| **Toggle reverse** | Turns **Reverse** on or off, on the grid. |
| **Half speed**, **Double speed** | Set **Speed** to x1/2 or x2, or back to x1 when it already is, on the grid. |
| **Capture** | See [Capture](#capture). |

**Layer** moves to each new layer as it is added, so Mute layer, Erase layer and Solo layer act on the newest layer unless Previous layer stepped back. When layers are merged, erased or brought back, Layer keeps naming the layer it named: the merged one when it named one of the two merged.

Rec / Play / Dub and Play / Stop act on the mode the looper will be in once what waits for the grid is taken up. Pressed twice before the grid point, each press is taken up on a grid point of its own: on an empty loop, two presses of Rec / Play / Dub record one grid step and play it. Setting Mode, or pressing Play, Stop, Record or Overdub, replaces whatever was waiting.

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
| **Replace a muted layer** | The pass takes the place of the oldest muted layer, or of the newest layer when none is muted. Undo right after takes the pass out and puts the replaced layer back where it was, muted as it was; Redo replaces it again. Once another pass starts, the replacement is final. |

A muted layer that is merged is left out of the merged one, and lost.

### Erasing a pass

Any pass can be taken out of the loop while it plays, not only the last one:

- in the view, with the **x** at the right of its lane, on the next grid point. The view shows a lane per pass, up to 32, sharing its height between them; with more passes than that, the oldest share the first lane, which has no **x**.
- with **Layer** and **Erase layer**, in the Layers tab: Layer says which pass, counting from the oldest one, and Erase layer erases it on the grid. Layer 1 is the top lane of the view when every pass has a lane of its own, and the file ending in `-layer1` of a take written as layers. Both are ports, so a footswitch or an OSC message can erase a pass.

The passes over the erased one stay where they are and the loop keeps its length, even when the erased pass had extended it. The passes under it get back the level its feedback took from them, as when it is undone. Undo and Redo go on with the passes left, and what Redo would bring back is kept. Erasing is not itself undone by Undo.

Erasing the pass being overdubbed is the same as Undo: the pass is dropped and overdubbing carries on in a new one. Erasing the only pass empties the loop, as Clear does.

## Takes and the timeline

When a recording or an overdub ends, the loop is written to a WAV file: 32-bit float, with its tempo and length in bars stored in the file, and marked as a loop. A click on **Send**, the button at the top right of the looper's view, places the last take in the timeline as a looping sound file, in a new box starting where the take was recorded, below the looper's box. This is one undoable action.

The take can also be dragged into the timeline, or anywhere a sound file can be dropped: dragging from the Send button, which has a grip for it, drags the whole take, all its files. Dragging a lane drags that layer alone, its own file, which lands as a box of its own. A muted layer is dragged as well: it was chosen. When the last take has no file of that layer, because Export is Mix or the layers changed since, the file is written when the drag starts: the lane says **Preparing** meanwhile, and the drag goes on as soon as it is there.

Sent or dragged, a take or a layer plays the way the loop did when it was written: its stretch mode follows the **Follow tempo** the looper was playing with. **Timestretch** gives the take the melodic time-stretch mode, **Timestretch percussive** the rhythmic one, **Repitch** and **Repitch fast** the matching repitch modes. With **Off**, the take is not stretched: it plays at the speed it was recorded at, and its box and its loop are as long as the recording itself, at the tempo where it is placed. A change of Follow tempo applies to the loop from the next start, and so to the takes made after that. The stretch mode can be changed afterwards in the sound file's inspector. A take dropped from a file browser has no such information, and gets a stretch mode chosen from its name, as any sound file.

While a recording or an overdub goes on, the last take does not have it yet. A press on Send then asks for a take of the loop as it is heard at that moment, the pass in progress included as far as it went, without stopping it; the button says **Saving** until the take is written. A click places it as soon as it is there. A drag from the button starts with the next move of the mouse once it is there, if the button is still held; let go before, the take is the one the next drag or Send gives. A lane dragged meanwhile gives its layer as far as it went. When the score is paused or stopped, nothing is being taken in any more, and Send and the drags give the last take there is.

When the score stops while a recording or an overdub goes on, the overdub's layer is closed as any, and the loop as it is heard is written as a take of its own, its mix only, even if the looper is removed right after. Mode then shows Play: when the score plays again, the loop plays, and nothing is recorded over it until Record or Overdub is asked for again.

**Export** chooses what a take writes: **Mix** (default), the loop as it is heard; **Layers**, each pass in a file of its own, as it is heard in the loop; or **Both**. Sending a take places all its files in one box named after the take, a slot each, the mix first; dragging it from the Send button drops them all.

Takes of a saved score go into a **Takes** folder next to the score. Takes of a score that has not been saved yet go into score's data folder, where they stay until removed. **File > Project files > Consolidate project...** copies the takes a score uses next to it. **File > Project files > Remove unused files...** finds the takes the score no longer uses only with **Look through the whole project folder** checked: by default it looks only in the folders score sorts media into (Audio, Video, ...), and the Takes folder is not one of them. It then moves them to an Unused folder of the project, or deletes them.

## Loading a file

Dropping a sound file on the looper replaces the loop with it, up to Max length, and plays it: Mode shows Play. **Loop file** is the port this sets: it is not in the looper's own view, but it is in the inspector, and a file path sent to it, by a cable or an address, loads the file the same way. A file at another sample rate is converted. A mono file goes to every channel.

## Capture

**Record** starts taking in when it is pressed, or on the next grid point. **Capture** works backwards: it takes what was already played, recorded or not, from the input the looper keeps. You play first, and decide afterwards that it was worth keeping.

- **With no loop**, Capture makes one: the last **Capture bars** bars of the input become the loop, and it plays at once. Mode shows Play, so Stop stops it.
- **Over a loop**, Capture adds what was played over the last round of the loop as a new layer on top, as if that round had been an overdub pass. Each part of it lands where it was played in the loop, and the loop keeps its length: Capture bars does not apply, one round is taken. A stopped loop is taken as going round where it would be had it kept playing, as In phase has it, and it plays from there. The layer is like any other: Max layers and At max layers make room for it as for an overdub pass, the layers that are muted stay muted, it is faded at its ends, moved by the latency, and the layers under it fade by the Feedback once, as for one round of overdub. A take is written as for any pass that closes.

Capture is undone like a pass: **Undo** takes the captured layer out, **Redo** brings it back. On an empty loop, Undo empties the loop as it does after a first recording, and Redo brings it back.

Pressed shortly after a point of the grid, within **Late stop**, Capture ends on that point, as a late stop would. Capture does nothing while a recording or an overdub is going on.

Capture and Capture bars are in the Length tab. Capture needs **Keep last (s)**, in the Memory tab, the number of seconds of input the looper keeps at all times. It is 0 by default, which keeps nothing and uses no memory: Capture then does nothing. It also takes no more than Keep last holds, so a loop longer than Keep last is captured in part.

## Monitoring

**Passthrough** chooses when the input is heard:

| Choice | Behavior |
|---|---|
| **None** | The input is never heard. |
| **Record** (default) | The input is heard while recording and overdubbing only. |
| **Full** | The input is always heard, mixed over the loop. |

## Memory and latency

- **Max length (s)**, default 60, is the longest loop. A recording that reaches it ends into what After record says; the view shows the loop as full.
- **Channels**, default 2, is the number of channels recorded.
- **Latency (ms)** moves what is recorded earlier in the loop, to make up for the time the input takes to reach the looper.
- **Engine latency** adds the input and output latency the audio driver reports, for a performer playing from the sound card along with the loop. JACK and PortAudio report it; with other drivers, set Latency by hand. Leave it off for input made inside score, which has no such delay.

The memory for these is reserved when playback starts, so changes to Max length, Max layers, Channels and Keep last apply from the next start.

## Tempo changes

**Follow tempo**, in the Speed tab, chooses how a loop follows the tempo of the score, with the same methods as sound files:

| Choice | Behavior |
|---|---|
| **Off** (default) | The loop keeps the speed it was recorded at, and no longer falls on the bars after a tempo change. |
| **Repitch**, **Repitch fast** | The loop is resampled: it keeps to the bars, and its pitch goes up and down with the tempo. |
| **Timestretch**, **Timestretch percussive** | The loop is time-stretched: it keeps to the bars and to its pitch. |

A change of Follow tempo applies from the next start of playback, as the time-stretching is set up then. Following applies to a loop that is playing. A loop being recorded or overdubbed plays at its own speed, and a tempo change is heard from the next round of the loop. Mode changes and the end of a recording after its bars always follow the tempo of the score. A take is written with the tempo the loop was recorded at, so a clip made from it follows the tempo of the score like any sound file.

## Reverse and speed

**Reverse** and **Speed**, in the Speed tab, play the loop as a tape would be.

- **Reverse** plays the loop backwards, from where the playhead is. Turned off, the loop plays forwards again from there. Nothing is changed in the loop: reversing is only how it is read.
- **Speed** plays the loop at x1/4, x1/2, x1, x2 or x4. The pitch follows the speed: at x1/2 the loop is an octave down and takes twice as long, at x2 an octave up and half as long.

An overdub writes where the playhead goes, as on tape. What is played over the reversed loop sounds reversed once the loop plays forwards again; what is played at x1/2 sounds an octave up, and twice as fast, at x1; at x2, an octave down.

Speed and Reverse change how the loop is read, not the score's time: Quantize, Record bars and Late stop go by the score as before, and a loop keeps its length. A recording is always made forwards at x1: it is what makes the loop. With **Follow tempo**, Speed applies on top of the tempo: at x2, a loop recorded over two bars plays in one bar whatever the tempo, its pitch up an octave even when time-stretched.

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

## Presets

The library has presets for the usual ways of looping. Each one sets every setting of the looper but **Channels**, which is the input's, so loading one after another leaves nothing of the one before. They are quantized to the bar unless said otherwise.

| Preset | What it is for |
|---|---|
| **Song form** | Record, Play, Overdub and Play again, for verses and choruses. Quantize is Loop: the first recording ends on a bar, then every change waits for the loop to come round, and a stop lets it play to its end. |
| **One footswitch, song form** | The same from Rec / Play / Dub alone, a stop also letting the loop play to its end, with a Late stop of 250 ms for a foot that is a little late on the downbeat. |
| **One footswitch, layering** | Rec / Play / Dub records, goes straight on overdubbing, and each press after that starts a new layer. Play / Stop stops. |
| **Comping, a layer per press** | Each press of Rec / Play / Dub while overdubbing starts a new take in a layer of its own; mute the ones to drop, and once there are 16, a new take replaces a muted one; takes are written as a mix and as layers. |
| **Comping, a layer per round** | One overdub, a layer each time round the loop, for trying a part again and again; takes are written as a mix and as layers, to splice the rounds in the timeline. |
| **Four bars, then play** | A recording of four bars, then plays it. |
| **Four bars, then overdub** | A recording of four bars, then goes on overdubbing. |
| **Free loop** | No grid, no Record bars, no Late stop: the loop is as long as it was played for. |
| **Ambient decay** | Four bars, then overdubbing with no gap and Feedback at 0.7, so that older layers fade away; the input is always heard. |
| **Half speed** | The loop plays an octave down and twice as long; what is overdubbed sounds an octave up once played at x1. |
| **Played backwards** | The loop plays backwards, and overdubs over it sound reversed once it plays forwards. |
| **Grows as you overdub** | A bar long recording, and Past the end on Extend: overdubbing over several bars makes the loop that long. |
| **In phase with the timeline** | Start from In phase: a loop played again after a stop, or when the score starts or jumps, is where it would be had it kept playing. |
| **Capture what I played** | Keeps the last minute of input, which Capture needs: press it to make a loop of the last four bars played, or, over a loop, to add its last round as a layer. |
| **Takes for editing** | **Export** on Both: takes are written as a mix and as a file for each layer. |

## Outputs

**Phase** goes from 0 to 1 as the loop plays, to drive anything that should follow the loop, such as video.

## Older scores

Scores and presets made with older versions of the looper load with the settings they had. Controls renamed since keep their values:

- **Loop** is now **Mode**, **Quantif** is now **Quantize**, and **Bars** is now **Record bars**.
- **Post-action** is now **After record**, with the same choices, and **Restart** is now **Start from**: Always is Loop start, Recording is Where it was. A score older than Restart gets Start from's default, Where it was, where the looper of the time read the loop from its start on every change of mode: set Loop start for that.
- **Takes** is now **Export**.
- **Quantif** was a list of note values, read as fractions of a bar: a score or a preset made with it gets the grid it waited for. **None** is None, **Whole** is **1 bar**, and the other values are the same note values: **4th** is **1/4**, **Dotted 8th** is **1/8.** In a signature other than 4/4, these note values are now note values, a quarter being a quarter, where they used to divide the bar.
- **Sync** is gone: a looper saved in a sync group plays on its own, and keeps its other settings and its cables.

These change what an older looper does:

- **Record on a loop** that has something in it overdubs it. It used to record a new loop in its place: clear the loop first for that.
- **Stopping the process or the score** stops the looper: what was being recorded or overdubbed is closed as a pass and written as a take, the playhead goes back to the loop's start, and a recording or an overdub gives way to Play, which Mode shows; any other mode is taken up again when the score plays again. The looper used to stay in the mode it was in, the playhead where it was.
- **Overdub on an empty loop** records it, then goes on overdubbing; it used to only pass the input through.

The settings added since come up at their defaults, and these change what such a looper does:

- **Layers**: each overdub is a layer of its own, with undo. Past 8 layers (**Max layers**), a pass is merged into the newest layer when it ends.
- **Channels** is 2: a looper used to record as many channels as its input had. Set it for an input of more channels.
- **Max length (s)** is 60: a recording that reaches it ends into what After record says. The looper used to grow its buffer for as long as it recorded.
- **Take files**: every recording and every overdub writes a WAV file, in a Takes folder next to the score, see [Takes and the timeline](#takes-and-the-timeline).
- **Late stop (ms)** is 120: a recording asked to stop within 120 ms after a grid point ends on that point. Set it to 0 to end on the next point, as before.
