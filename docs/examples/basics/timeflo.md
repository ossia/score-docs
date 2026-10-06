---
layout: default

title: Basic timeline
description: "A basic example showing time-based composition with audio files and effects"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/timeflo.html
score: /examples/basics/timeflo.zip
---

# Basic Timeline Example

![Basic Timeline]({{ site.img }}/examples/basics/timeflo.png "Timeline-based composition in ossia score")

This example demonstrates fundamental timeline-based composition in ossia score, combining audio file playback with effects processing.

## Overview

The score shows how to arrange audio clips on a timeline, apply effects, and create basic temporal structures with the scenario system. Alongside the linear arrangement, interactive endings let you decide when to move on, a condition selects a branch, and a loop returns to an earlier part of the composition.

Intervals are the basic building blocks: they contain processes, can play automatically or wait for interaction, and can be nested inside scenarios. Their drawn duration is not always their actual duration during playback.

## Try it

Open the ZIP directly in score and configure audio output. The audio files are bundled; some process labels retain older filenames. Faust support is needed for the reverb. The patch credits the OLPC sample pack and Mike DiMattia.

- Move intervals to rearrange the composition, or replace a sound file with one of your own.
- Adjust the reverb automation and listen to how the sound changes over time.
- Use the end triggers to continue through the waiting intervals. The parallel branches can progress independently.
- Change B's false condition to include the otherwise inactive branch, then try the shared end trigger and watch the loop return to an earlier time sync.

Use the final drum end trigger or Stop when finished.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Scenario]] - Timeline and scenario container reference
- [[Soundfiles]] - Audio file playback process
- [[Automation]] - Creating parameter automation curves
- [[Faust]] - Faust DSP effects like freeverb
