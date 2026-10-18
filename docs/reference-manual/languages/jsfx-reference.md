---
layout: default
title: JSFX and EEL2
description: "JSFX and EEL2 language references, with score's YSFX hosting context."
parent: Languages
grand_parent: Reference
permalink: /reference/languages/jsfx.html
---

# JSFX and EEL2

JSFX effects are text programs for processing or generating audio and MIDI, optionally with a custom graphical interface. Their code is written in **EEL2**, not JavaScript. score hosts them through [YSFX](https://github.com/jpcima/ysfx), which compiles and runs the scripts.

Use the [official JSFX programming reference](https://www.reaper.fm/sdk/js/js.php) for the file format and API, and the [EEL2 reference](https://www.cockos.com/EEL2/) for the underlying language. The links below lead to those existing references rather than duplicating their function tables here.

## Language and API references

| Topic | Reference |
|---|---|
| Variables, expressions, operators, branching, loops and mathematics | [EEL2 language reference](https://www.cockos.com/EEL2/) and [JSFX basic code reference](https://www.reaper.fm/sdk/js/basiccode.php#js_basic) |
| File headers, sliders, audio pins, imports and code sections | [JSFX file structure](https://www.reaper.fm/sdk/js/js.php#js_file) |
| User-defined functions, local variables and namespaces | [Functions and namespace pseudo-objects](https://www.reaper.fm/sdk/js/userfunc.php#js_userfunc) |
| Audio samples, sample rate, block size, sliders and transport variables | [Special variables](https://www.reaper.fm/sdk/js/vars.php#js_specialvars) |
| Receiving and sending MIDI, including event offsets | [MIDI functions](https://www.reaper.fm/sdk/js/midi.php#js_midi) |
| Data files and saving/restoring script state | [File I/O and serialization](https://www.reaper.fm/sdk/js/file.php#js_file) |
| Memory operations, FFT and MDCT | [Advanced functions](https://www.reaper.fm/sdk/js/advfunc.php#js_advanced) |
| Strings and string operations | [String reference](https://www.reaper.fm/sdk/js/strings.php#js_strings) |
| Drawing, images, mouse and keyboard interaction | [Graphics reference](https://www.reaper.fm/sdk/js/gfx.php#js_gfx) |
| Slider notifications and other host calls | [Host interaction functions](https://www.reaper.fm/sdk/js/advfunc.php#js_host) |

For orientation, the [code sections](https://www.reaper.fm/sdk/js/js.php#js_file) separate initialization (`@init`), parameter updates (`@slider`), block processing (`@block`), sample processing (`@sample`), persistent state (`@serialize`) and drawing (`@gfx`). Consult their individual descriptions before deciding where code belongs; drawing and audio processing are not the same callback.

EEL2's C-like appearance can be misleading: variable names are case-insensitive, parentheses group statements, and conditional expressions use `?` and `?:`. Its memory indexing and operator precedence also differ from JavaScript and C. Use the [basic code and operator reference](https://www.reaper.fm/sdk/js/basiccode.php#js_ops), not the JavaScript reference, when adapting a script.

## Using JSFX in score

- **Loading, routing and opening the UI:** follow [Audio plug-in support]({{ site.baseurl }}/processes/audio-plugins.html).
- **Installing scripts and their dependencies:** see [Adding JSFX plug-ins]({{ site.baseurl }}/processes/audio-plugins.html#jsfx). This covers the `.jsfx` extension, user-library discovery, the `Effects` / `Data` folder layout and existing effect collections.
- **Editing and saving:** the same [JSFX hosting section]({{ site.baseurl }}/processes/audio-plugins.html#jsfx) explains score's script editor, saved script text and controls, presets, and keeping companion data/import files with the package. Saving the script in a document does not remove its external dependencies.
- **Playback position and tempo:** see [Transport and reverse playback]({{ site.baseurl }}/processes/audio-plugins.html#transport-and-reverse-playback). score supplies JSFX with time, tempo and signature information; reversing the timeline does not reverse an effect's internal DSP history.

## Host compatibility

The Cockos manual describes JSFX **in REAPER**. It is the language/API reference, not a guarantee that every REAPER-specific feature or recently added extension is available in score. Likewise, EEL2 is used in several applications: sharing the language does not make ReaScript or other host-specific APIs available to a JSFX effect.

Compatibility depends on the YSFX version included in the score build and on score's host integration. Use the [YSFX project and usage notes](https://github.com/jpcima/ysfx) for the runtime, the [score hosting documentation]({{ site.baseurl }}/processes/audio-plugins.html#jsfx) for integration behavior, and the [score YSFX integration source](https://github.com/ossia/score/tree/master/src/plugins/score-plugin-ysfx) when checking a particular host feature. YSFX's standalone plug-in instructions are not score's installation instructions.

Before relying on an imported effect, check its audio/MIDI routing, controls, custom graphics, required files and save/reload behavior in the target score build. A script compiling successfully does not establish that all of its host-dependent behavior works.
