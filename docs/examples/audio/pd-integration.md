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

The `noisebank` Pure Data patch generates stereo noise with exposed controls named volume, white, dark, fizzle, grit, grrrit and crk. The score sequences the patch and automates its controls rather than sending MIDI to it.

## Requirements

Use a score build with the Pure Data process available. The document references `<LIBRARY>:packages/default/Presets/PureData/noisebank.pd`; this separate patch must be present in the user library. The `.score` download does not bundle it. Installing the Pure Data application is useful for opening its external editor, but the embedded process also needs score's own Pd support.

## Play and inspect

1. Configure audio output and start playback at a low level. After the initial two-second interval, `noisebank` starts.
2. Follow the four automation cables into white, dark, fizzle and crk. Compare their curve shapes with the changing texture of the noise.
3. The patch's audio passes through Lowpass → Limiter → Gain. A fifth automation changes the lowpass cutoff. Gain sends to the parent mix at `audio:/out/main`.
4. Use the interval's end trigger to stop the patch. Its nominal 17-second endpoint is interactive, not an automatic stop.
5. If Pure Data is installed, use **Open external window** to inspect or edit `noisebank.pd`. The saved process has zero audio inputs, two audio outputs and no MIDI input or output.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Pure Data integration]] - Full PureData process reference
- [[Audio routing]] - Audio signal flow in ossia score

## External resources

- [PureData website](https://puredata.info/)
- [Pd documentation](https://puredata.info/docs)
