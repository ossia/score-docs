---
layout: default

title: PureData integration
description: "An example showing how to use PureData patches within ossia score"

parent: Audio
grand_parent: Examples

permalink: /examples/audio/puredata.html
---

# PureData Integration

This example demonstrates how to integrate PureData (Pd) patches into ossia score projects.

## Overview

PureData is a visual programming language for audio and multimedia. ossia score can load and run Pd patches, allowing you to combine Pd's synthesis and processing capabilities with ossia's timeline and control features.

## Integration features

- Load existing .pd patch files
- Audio input/output between ossia and Pd
- Control messages via OSCQuery protocol
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

## OSCQuery communication

ossia score and PureData can communicate via OSCQuery:

- Pd's parameters appear in ossia's device explorer
- Changes sync bidirectionally
- Enables complex control scenarios

## Example patches

Common uses for Pd in ossia score:

- Granular synthesis engines
- Physical modeling instruments
- Complex modulation systems
- Audio analysis tools
- Generative sequencers

## Try it

If you have PureData installed, open this example to see how Pd patches integrate with the ossia timeline.

[Download this example]({{ site.scores }}/examples/audio/puredata.score)

## Learn more

- [[Pure Data integration]] - Full PureData process reference
- [[OSCQuery device]] - How OSCQuery enables Pd communication
- [[Audio routing]] - Audio signal flow in ossia score

## External resources

- [PureData website](https://puredata.info/)
- [Pd documentation](https://puredata.info/docs)
