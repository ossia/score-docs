---
layout: default

title: Temporal patching (delayed)
description: "Let later effect passages revisit earlier source audio, creating staggered transformations of the same material."

parent: Basics
grand_parent: Examples

permalink: /examples/basics/delayed.html
score: /examples/basics/delayed.score
---

# Temporal Patching (Delayed Mode)

![Delayed Patching Mode]({{ site.img }}/examples/basics/delayed.png "Delayed temporal patching in ossia score")

Let a sound return in another form after its original passage has moved on. Here, effects start later than their source but receive earlier source material, creating staggered transformations instead of joining the sound currently playing.

## Overview

Delayed cables retain the source material and deliver it relative to each effect's start. Moving an effect interval therefore changes when that treatment appears in the composition. The entrances are composed on the timeline, independently of the source's own lifetime.

## Try it

Configure audio output and start at a low level. Bytebeat generates the source, so no sound file is needed; Bytebeat, Faust and Airwindows support are required.

1. Listen to the direct sound, then to the Low, Medium and High effects as they begin. Follow how earlier material reappears through later treatments.
2. Let the source stop automatically, but leave the effects active. Listen for the remaining delayed material and tails, then use the effects' end triggers to close the passage.
3. Move one effect interval farther from the source and replay: its entrance moves later, but it still begins with the same early source material.

See [glutton mode]({{ site.baseurl }}/examples/basics/glutton.html), where a newly active effect receives the currently playing source without replaying its earlier material. Live input is optional; use headphones if adding a microphone to avoid loudspeaker feedback.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Audio routing]] - How audio propagates through the timeline
- [[Audio plugins]] - VST, Faust, JSFX effect formats
- [[Audio device]] - Configuring audio input/output
