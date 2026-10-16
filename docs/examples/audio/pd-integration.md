---
layout: default

title: PureData Example
description: "Compose a shifting noise texture by automating a Pure Data patch from score's timeline."

parent: Audio
grand_parent: Examples

permalink: /examples/audio/pd-integration.html
score: /examples/audio/puredata.zip
---

# PureData Integration

![Automation curves shaping a Pure Data noise generator and its lowpass filter]({{ site.img }}/examples/audio/puredata.png "PureData patch running in ossia score")

Build a passage from noise rather than notes: rough, fine and darker textures can rise and recede as separate layers. Here, timeline curves shape a Pure Data sound generator, turning an existing patch into material that can be arranged alongside the rest of a performance.

## From patch to passage

The `noisebank` patch generates the sound. Automation changes four of its texture controls, while a separate lowpass curve reveals or softens the higher-frequency detail. The division is useful when adapting your own Pd work: keep sound generation in Pd and compose its larger gestures in score. This example controls parameters, not MIDI notes.

## Setup

Open the ZIP directly in a score build with Pure Data support; the Pd patch is included. The Pure Data application is only needed if you want to open its external editor. Configure audio output and start at a low level.

## Try it

1. Start playback. After the initial two-second interval, listen to the noise texture while following the curves for white, dark, fizzle and crk.
2. Edit one curve at a time. Compare a slow increase with short bursts to hear how the same noise layer can behave as a background or an accent.
3. Reshape the lowpass automation without changing the noise controls. Listen to the difference between changing the texture itself and filtering the combined sound.
4. Use the interval's end trigger to stop the patch. Its drawn 17-second endpoint is interactive, so you can hold the passage rather than accepting a fixed ending.
5. With Pure Data installed, choose **Open external window** to inspect or edit `noisebank.pd`. For an adaptation, expose controls in your own Pd generator and shape them with the same timeline approach.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Pure Data integration]] - Full PureData process reference
- [[Audio routing]] - Audio signal flow in ossia score

## External resources

- [PureData website](https://puredata.info/)
- [Pd documentation](https://puredata.info/docs)
