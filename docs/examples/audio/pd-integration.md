---
layout: default

title: PureData Example
description: "An example showing how to use PureData patches within ossia score"

parent: Audio
grand_parent: Examples

permalink: /examples/audio/pd-integration.html
---

# PureData Integration

This example demonstrates how to integrate PureData (Pd) patches into ossia score projects.

## Overview

PureData is a visual programming language for audio and multimedia. ossia score can load and run Pd patches, allowing you to combine Pd's synthesis and processing capabilities with ossia's timeline and control features.

## Integration features

- Load existing .pd patch files
- Audio and MIDI input/output between ossia and Pd
- Real-time parameter control

## Use cases

PureData integration is useful for:

- **Complex synthesis**: Using Pd's extensive audio objects
- **Custom DSP**: Algorithms built in Pd's visual environment
- **Existing patches**: Reusing work from Pd projects
- **Live coding**: Modifying patches during playback

## Setting up PureData

1. Install PureData on your system
2. Create or load a .pd patch in ossia score
3. The patch's receive objects become controllable parameters
4. Audio flows through the patch

## Try it

Open this example to see how Pd patches integrate with the ossia timeline.
The patches are loaded from the user library.
If you have PureData installed, you can also edit the patches directly from within ossia.

[Download this example]({{ site.scores }}/examples/audio/puredata.score)

## Learn more

- [[Pure Data integration]] - Full PureData process reference
- [[Audio routing]] - Audio signal flow in ossia score

## External resources

- [PureData website](https://puredata.info/)
- [Pd documentation](https://puredata.info/docs)
