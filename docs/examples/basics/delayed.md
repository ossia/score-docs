---
layout: default

title: Temporal patching (delayed)
description: "An example showing how to patch audio and messages in time using the delayed mode"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/delayed.html
---

# Temporal Patching (Delayed Mode)

![Delayed Patching Mode]({{ site.img }}/examples/basics/delayed.png "Delayed temporal patching in ossia score")

This example demonstrates ossia score's "delayed" patching mode, which allows audio, messages, and MIDI to flow between timeline segments executing at various times and be delayed according to the time at which the data sources started executing.

## Try it

Open this example to hear how audio flows through the temporal effect chain.

[Download this example]({{ site.scores }}/examples/basics/delayed.score)

## Learn more

- [[Audio routing]] - How audio propagates through the timeline
- [[Audio plugins]] - VST, Faust, JSFX effect formats
- [[Audio device]] - Configuring audio input/output
