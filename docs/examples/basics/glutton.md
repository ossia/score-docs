---
layout: default

title: Temporal patching (glutton)
description: "An example showing how to patch audio and messages in time using the glutton mode"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/glutton.html
---

# Temporal Patching (Glutton Mode)

This example demonstrates ossia score's "glutton" patching mode, which allows audio, messages, and MIDI to flow between timeline segments that are not directly connected by cables.

## Overview

In standard patching, you must explicitly connect outputs to inputs with cables. The glutton mode provides an alternative where processes in sequence automatically receive audio from their predecessors on the timeline.

## When to use glutton mode

Glutton mode is useful when:

- Building effect chains that should process audio in sequence
- Creating live performance patches where timing matters
- Avoiding complex cable routing for simple sequential processing

## Limitations

Glutton mode currently supports:
- Audio signals
- Control messages
- MIDI data

For video/texture/geometry data, explicit cables are required.

## Try it

Connect an audio input device and open this example to hear how audio flows through the temporal effect chain.

[Download this example]({{ site.scores }}/examples/basics/glutton.score)

## Learn more

- [[Audio routing]] - How audio propagates through the timeline
- [[Audio plugins]] - VST, Faust, JSFX effect formats
- [[Audio device]] - Configuring audio input/output
