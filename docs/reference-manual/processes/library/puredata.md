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

score will detect:

- Audio inlets/outlets: `[adc~]`, `[dac~]` and create a corresponding audio input and output port.
  - Important ! You have to set in the inspector how many audio channels are needed, as they are multiplexed into a single port.
- MIDI inlets/outlets: `[midiin]`, `[notein]`, `[controlin]`, `[midiout]`, `[noteout]`, `[controlout]` and will create a MIDI input and / or output port.
- Value inlets/outlets: `[s] / [send]`, `[r] / [receive]`.

It is possible (but still work-in-progress) to use the [libossia ossia.parameter syntax](https://ossia.io/ossia-docs/?plaintext--pd#creating-parameters) for the receives, so that score is able to create nice GUI controls.

Additionally, a `widget` attribute can be used, which will directly create the expected widget, among:

- intslider
- floatslider
- logfloatslider
- intspinbox
- toggle
- button
- lineedit
- xyslider
- hsvslider

Valid cases would be (not all of them work yet):

```
[r myInput @type float @range -1 1]

[r myInput @widget intslider @min 0 1000]

[r myInput @type impulse]

[r myInput @type bool @default true]

[r myInput @unit color.hsv]
```

## Editing the patch

If a Pure Data binary is detected on the host computer (by looking into their default installations folders and in the PATH), then it will be possible to open the patch directly from score.

There is one caveat that may be fixed in a future version of the integration: one must *not* close the main Pd UI window by quitting it like other OS windows.
Instead, the window should be closed by pressing the "window" button in the score node.