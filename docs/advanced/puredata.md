---
layout: default
title: "PureData integration"

parent: Advanced
nav_order: 1

permalink: /docs/advanced/puredata.html
category: "site-score"

description: "Embed Pure Data patches in score"

tag: "Scripting"
visible: true
---

# PureData support

ossia score supports running [Pure Data](http://msp.ucsd.edu/software.html) patches as processes.
Simply drop a patch in the score to add it.

This is done thanks to [libpd](https://github.com/libpd/libpd).

## Example

The following PureData patch:

![Pd patch](/score-docs/assets/images/pd/pd-example-patch.png)

Will look like this when loaded in score:

![Pd patch in score](/score-docs/assets/images/pd/pd-example-score.png)

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

While editing the patch in real-time does not yet work, editing it when the score is stopped will reload it when execution is restarted.

If a Purr Data, Pd-l2ork, or Pure Data binary is detected on the host computer (by looking into their default installations folders and in the PATH),
then it will be possible to open the patch directly from score.
