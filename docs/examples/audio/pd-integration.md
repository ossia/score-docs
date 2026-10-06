---
layout: default

title: PureData Example
description: "An example showing how to use PureData patches within ossia score"

parent: Audio
grand_parent: Examples

permalink: /examples/audio/pd-integration.html
score: /examples/audio/puredata.score
---

# PureData Integration

![PureData Integration Example]({{ site.img }}/examples/audio/puredata.png "PureData patch running in ossia score")

This example demonstrates how to integrate PureData (Pd) patches into ossia score projects.

## Overview

PureData is a visual programming language for audio and multimedia. ossia score can load and run Pd patches, allowing you to combine Pd's synthesis and processing capabilities with score's timeline and control features.

Here, the `noisebank` patch creates a changing noise texture. Automations shape its controls over time, showing how an existing sound generator can become part of a larger composition. This example controls the patch's parameters rather than sending it MIDI.

## Requirements

Use a score build with the Pure Data process available. The document references `<LIBRARY>:packages/default/Presets/PureData/noisebank.pd`; this separate patch must be present in the user library. The `.score` download does not bundle it. Installing the Pure Data application is useful for opening its external editor, but the embedded process also needs score's own Pd support.

## Try it

1. Configure audio output and start playback at a low level. After the initial two-second interval, `noisebank` starts.
2. Compare the automation curves for white, dark, fizzle and crk with the changing noise texture. Edit one curve at a time to hear what each control contributes.
3. Change the lowpass automation to reveal or soften the higher-frequency detail. Compare a gradual change with a sudden jump.
4. Use the interval's end trigger to stop the patch. Its nominal 17-second endpoint is interactive, not an automatic stop.
5. If Pure Data is installed, use **Open external window** to inspect or edit `noisebank.pd`. This is also a starting point for bringing your own Pd sound generators into a timeline.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Pure Data integration]] - Full PureData process reference
- [[Audio routing]] - Audio signal flow in ossia score

## External resources

- [PureData website](https://puredata.info/)
- [Pd documentation](https://puredata.info/docs)
