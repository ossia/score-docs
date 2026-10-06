---
layout: default

title: Temporal patching (delayed)
description: "An example showing how to patch audio and messages in time using the delayed mode"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/delayed.html
score: /examples/basics/delayed.score
---

# Temporal Patching (Delayed Mode)

![Delayed Patching Mode]({{ site.img }}/examples/basics/delayed.png "Delayed temporal patching in ossia score")

This example demonstrates ossia score's "delayed" patching mode, which allows audio, messages, and MIDI to flow between timeline segments executing at various times and be delayed according to the time at which the data sources started executing.

## Overview

One source supplies several effects that start later on the timeline. Delayed cables retain the source material so that each effect can hear it relative to its own start, rather than receiving only what the source is playing now. The result is a staggered temporal effect chain.

## Try it

Configure audio output and start at a low level. Bytebeat generates the source, so no sound file is needed; Bytebeat, Faust and Airwindows support are required.

Compare the direct sound with the Low, Medium and High effects as they begin. The source stops automatically, but the effects wait for their end triggers. Leave them active to hear the delayed material and tails, then stop them explicitly. Try moving an effect interval to change its offset from the source.

Compare this with [glutton mode]({{ site.baseurl }}/examples/basics/glutton.html), which processes the currently executing source without replaying its earlier material. Live audio input is optional; if using a microphone, avoid loudspeaker feedback.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Audio routing]] - How audio propagates through the timeline
- [[Audio plugins]] - VST, Faust, JSFX effect formats
- [[Audio device]] - Configuring audio input/output
