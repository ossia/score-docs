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

Build a passage from noise instead of notes: rough, fine and darker textures rise and recede as separate layers, shaped by timeline curves that control a Pure Data sound generator.

## How the patch is controlled

The `noisebank` patch generates the sound. Automation changes four of its texture controls, while a separate lowpass curve reveals or softens the higher-frequency detail. Sound generation stays in Pd; score handles the timing and shape of each change. This example controls parameters, not MIDI notes.

## Setup

Open the ZIP directly in a score build with Pure Data support; the Pd patch is included. The Pure Data application is only needed if you want to open its external editor. Configure audio output and start at a low level.

## Try it

1. Start playback. After the initial two-second interval, listen to the noise texture while following the curves for white, dark, fizzle and crk.
2. Edit one curve at a time. A slow rise turns a noise layer into a background; short bursts turn it into accents.
3. Reshape the lowpass automation without changing the noise controls: this filters the combined sound instead of changing any one texture.
4. Use the interval's end trigger to stop the patch. Its drawn 17-second endpoint is interactive, so the passage lasts until you trigger it.
5. With Pure Data installed, choose **Open external window** to inspect or edit `noisebank.pd`. For an adaptation, expose controls in your own Pd generator and shape them with the same timeline approach.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Pure Data integration]] - Full PureData process reference
- [[Audio routing]] - Audio signal flow in ossia score

## External resources

- [PureData website](https://puredata.info/)
- [Pd documentation](https://puredata.info/docs)
