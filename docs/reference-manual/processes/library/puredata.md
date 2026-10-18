---
layout: default

title: Pure Data integration
description: "Using Pure Data in ossia score"

parent: Processes
grand_parent: Reference

permalink: /processes/puredata.html
---

# Pure Data support

ossia score supports running [Pure Data](http://msp.ucsd.edu/software.html) patches as processes.
Simply drop a patch in the score to add it.

This is done thanks to [libpd](https://github.com/libpd/libpd).

The [Pure Data language reference]({{ site.baseurl }}/reference/languages/puredata.html) links the patch-language and object manuals and documents score's audio, MIDI, message and control-annotation interface.

## Example

The following Pure Data patch:

![Pd patch]({{ site.img }}/pd/pd-example-patch.png)

Will look like this when loaded in score:

![Pd patch in score]({{ site.img }}/pd/pd-example-score.png)

[This particular example can be downloaded in the user library](https://raw.githubusercontent.com/ossia/score-user-library/master/Presets/PureData/example-synthesizer.pd).

Feel free to contribute your own useful patches [here](https://github.com/ossia/score-user-library/tree/master/Presets/PureData) !

## Limitations

For now do not use the "Parallel" execution mode when running Pd patches.

## Usage

Patch objects determine the audio, MIDI and value ports exposed in score. Set the required audio channel counts in the inspector, then connect the resulting process ports to the rest of the score.

See [Audio, MIDI and message ports]({{ site.baseurl }}/reference/languages/puredata.html#audio-midi-and-message-ports) for the recognized Pd objects, and [Receive annotations and controls]({{ site.baseurl }}/reference/languages/puredata.html#receive-annotations-and-controls) for the optional control metadata previously documented here. Annotation support is still work in progress.

## Editing the patch

If a Pure Data binary is detected on the host computer (by looking into their default installations folders and in the PATH), then it will be possible to open the patch directly from score.

Do *not* close the main Pd UI window by quitting it like other OS windows.
Instead, the window should be closed by pressing the "window" button in the score node.