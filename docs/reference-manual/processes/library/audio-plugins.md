---
layout: default

title: Audio plugins
description: "Using external audio plug-ins in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/audio-plugins.html
---

# Audio plug-in support

![Audio plugins]({{ site.img }}/reference/processes/vst.png "VST example")

Drop a plug-in from the Audio section of the [process library]({{ site.baseurl }}/panels/library.html) into an interval or the graph. Cable audio, MIDI and control ports according to the plug-in's declared inputs and outputs.

If the plug-in has a custom UI, it is possible to make it show up with the small "window" icon on the plug-in header.

For VST2 plug-ins with many controls, parameters can be exposed as needed for
automation; see the parameter workflow below. Other formats use their own port models.

## Common formats: CLAP, VST, VST3, LV2, JSFX

score hosts VST 2.4, VST3, CLAP, LV2 and JSFX through separate integrations.
Availability depends on the build and platform; the plug-in binary must match the
operating system and architecture of score. A format being supported does not
guarantee that every plug-in, custom editor or optional extension works.
AirWindows is also available as a collection of built-in effects.

## Scanning and search paths

score provides separate **VST**, **VST3**, **CLAP** and **LV2**
tabs under **Preferences → Effects**. Each has its own search paths, **Add path**
and **Rescan** buttons, plus **Working plug-ins** and **Faulty plug-ins** tables.
Right-click a search path and choose **Remove** to remove it.

1. Install the plug-in for your OS and architecture.
2. Add its containing directory in the matching format tab, not another format's
   tab. VST3 and VST2 no longer share a path list.
3. Use **Rescan**, then look for the plug-in in Working plug-ins and in the library.
4. If it is faulty, check its dependencies, architecture and installation before
   rescanning. A successful scan establishes discoverability, not complete runtime
   compatibility.

These formats are scanned in helper processes and their results are cached.
`VST_PATH`, `VST3_PATH`, `CLAP_PATH` and `LV2_PATH` can supplement configured paths.
Set `SCORE_DISABLE_AUDIOPLUGINS=1` before launching score to suppress automatic
audio plug-in scanning when diagnosing startup problems. Previously cached VST,
VST3 and CLAP entries can remain available. `SCORE_DISABLE_LV2=1` disables LV2
initialization/scanning specifically; it is not merely a way to hide its editor.

Save score process presets to reuse configured plug-ins. Do not assume that a
vendor's native preset-file format is interchangeable with score presets.

## Controlling VST2 parameters

To be able to automate and connect VST parameters to other parts of the session, it is necessary to make them visible in the nodes.
For plug-ins with less than a dozen parameters, they will always be shown by default. For plug-ins with more parameters, this is 
however opt-in.

![VST inspector UI]({{ site.img }}/reference/processes/vst-icon.png "VST control UI icon")

The first button allows to show / hide the audio plug-in UI. The second, when enabled, means that the plug-in's parameters
will be checked for changes: whenever a value changes, it will appear in the score UI and be open to automation, etc.

Here is the complete procedure:

![Controlling VST parameters]({{ site.img }}/reference/processes/vst-params.gif "VST parameters")

This parameter-exposure workflow applies to VST2. Other integrations expose
controls according to their own port models.

## VST3

Use the **VST3** preferences tab for VST3 bundles; a VST2 installation of the
same product is a separate plug-in. Route MIDI to instruments through their
declared event input. Current hosting forwards CC, pitch bend and aftertouch
through the plug-in's VST3 MIDI mapping; the receiving plug-in must provide the
corresponding mapping. Do not assume that controls or saved state are
interchangeable between a product's VST2 and VST3 versions.

## CLAP

CLAP exposes the plug-in's declared audio and note ports and automatable controls.
The host handles CLAP note events, MIDI and MIDI 2 events, and forwards supported
note/MIDI 2/SysEx output events to MIDI outlets. Non-note messages such as CC,
pitch bend and pressure are also forwarded when the plug-in uses the CLAP note
dialect. The dialects declared by the particular port still determine what it
can receive; this is not a promise that every plug-in handles MIDI 2 or SysEx.

For replicated multichannel processing, a scalar control applies to each voice.
A list or 2/3/4-component vector supplies per-voice values; if there are more
voices than values, the last value is reused. This is host-side multichannel
control, not a guarantee of per-note expression inside an instrument.

The host supports plug-in state-change notifications and restart requests.
Try a plug-in in a small document, including save/reload and its custom editor,
before depending on it in a performance.

## LV2

LV2 requires a build with the LV2 hosting dependencies. Its search paths are
independent of the other formats. Ports follow the bundle's metadata: audio and
CV ports are audio-rate connections, MIDI atom ports carry MIDI, and control
ports become parameters. **CV outputs are audio outlets**, not scalar value
outputs; cable CV inputs from an appropriate audio-rate source.

A mono effect with one audio input and one audio output can be replicated across
a multichannel bus. This is one effect instance per channel, not automatic MIDI
polyphony for every LV2 instrument. Scalar controls are shared; vector/list
controls can supply per-voice values.

Custom UI support is narrower than DSP support. score selects an editor that its
UI host can embed and whose binary exists. Editors linked against another Qt
major version are deliberately rejected to avoid in-process conflicts. A working
plug-in may therefore have no usable custom window; use its exposed controls.

## Transport and reverse playback

VST2, VST3 and LV2 receive timeline transport positions and can continue processing
when the timeline runs backwards. CLAP receives musical song position, and JSFX
receives time, tempo and signature information. This does **not** make a delay,
reverb or synthesizer run its internal history backwards. Transport-sensitive
behavior remains plug-in dependent. Current LV2 hosting delivers stop/start
changes and resets processing state for a new play.

## Adding JSFX plug-ins {#jsfx}

JSFX plug-ins can be added in the user library. Score will look for files ending with the `.jsfx` extension.

If you are on Unix or a system with bash, you can rename the JSFX plugins without extensions this way:

```bash
$ find . -type f ! -name '*.*' -exec perl-rename 's/$/.jsfx/' {} \;
```

Here are some links to free JSFX collections:
- [https://github.com/chkhld/jsfx](https://github.com/chkhld/jsfx)
- [https://github.com/JoepVanlier/JSFX](https://github.com/JoepVanlier/JSFX)
- [https://geraintluff.github.io/jsfx](https://geraintluff.github.io/jsfx)
- [https://github.com/Justin-Johnson/ReJJ](https://github.com/Justin-Johnson/ReJJ)

Some JSFX plug-ins need separate data files.
To ensure that they can find it, the following organization is recommended: 

```
jsfx_folder/Effects/foo/effect.jsfx
jsfx_folder/Data/<matching data files>
```

For instance, a complete path on a Mac with the default user library location would look like:

```
/Users/you/Documents/ossia/score/packages/jsfx/Effects/dynamics/general_dynamics.jsfx
/Users/you/Documents/ossia/score/packages/jsfx/Data/amp_models/SomeImpulse.wav
```

score hosts JSFX through YSFX and provides a script editor for
live code changes. Edited script text and controls are retained by process
serialization and presets; copy/paste and undo/redo preserve the edited process
rather than relying only on its original file path.

The custom graphics host supports resizing, menus, cursors and high-DPI drawing.
Support still depends on the YSFX version compiled into score and on what the
script uses. Presets whose names begin with bracketed tags can be grouped into
submenus. Keep required data/import files alongside the library package even when
the script text is saved in the document.

## Advanced plug-in and extensions formats

It is also possible to use less common systems for audio processing:
* [Faust DSPs]({{ site.baseurl }}/processes/faust.html "Faust")
* [Pure Data patches]({{ site.baseurl }}/processes/puredata.html "Pure Data")
* [Javascript]({{ site.baseurl }}/processes/javascript.html "Javascript")
* [Math expressions]({{ site.baseurl }}/processes/exprtk.html "ExprTK")
* [Custom C++ plug-ins]({{ site.baseurl }}/processes/cpp_jit.html "C++ JIT")

Some of these plug-in systems, like Faust are source-based: that is, *score* will compile the source code of the plug-in directly, which can take a few seconds when dropping the plug-in in the session.

Preset support for these plug-ins is a work-in-progress.
