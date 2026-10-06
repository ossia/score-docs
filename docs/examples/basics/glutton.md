---
layout: default

title: Temporal patching (glutton)
description: "An example showing how to patch audio and messages in time using the glutton mode"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/glutton.html
score: /examples/basics/glutton.score
---

# Temporal Patching (Glutton Mode)

![Glutton Patching Mode]({{ site.img }}/examples/basics/glutton.png "Glutton temporal patching in ossia score")

This example demonstrates ossia score's "glutton" patching mode, which allows audio, messages, and MIDI to flow between timeline segments executing at various times.

## Overview

An audio source is shared by three effect intervals that begin at different times. Each effect processes the source that is currently playing: the cable does not replay earlier material when a new effect starts. This makes it possible to bring effects into a performance independently of the sound that feeds them.

## Try it

Configure audio output and start playback at a low level. Bytebeat supplies the sound, so no sample file or external controller is needed. The example requires Bytebeat, Faust and Airwindows support.

Listen as the Low, Medium and High effect intervals join the source. Trigger their ends separately to change the combination of effects, then end Source and listen to the remaining tails. All four ends are interactive; their drawn positions do not stop them automatically.

Compare this with the [delayed example]({{ site.baseurl }}/examples/basics/delayed.html), where each later effect receives earlier source material. Live input is optional through the saved `audio:/in/main` binding; use headphones if adding a microphone to avoid feedback.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Audio routing]] - How audio propagates through the timeline
- [[Audio plugins]] - VST, Faust, JSFX effect formats
- [[Audio device]] - Configuring audio input/output
