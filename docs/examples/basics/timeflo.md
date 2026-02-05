---
layout: default

title: Basic timeline
description: "A basic example showing time-based composition with audio files and effects"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/timeflo.html
---

# Basic Timeline Example

![Basic Timeline]({{ site.img }}/examples/basics/timeflo.png "Timeline-based composition in ossia score")

This example demonstrates fundamental timeline-based composition in ossia score, combining audio file playback with effects processing.

## Overview

The score shows how to arrange audio clips on a timeline, apply effects, and create basic temporal structures with the scenario system.

## Working with intervals

In ossia score, intervals are the basic building blocks:
- They have a duration (shown in the timeline)
- They can contain any number of processes
- They can be triggered by events or play automatically
- They can be nested inside scenarios

## Try it

Open this example to explore basic timeline composition. Try:
- Moving intervals to rearrange the timeline
- Adjusting the automation curve
- Adding new sound files

[Download this example]({{ site.scores }}/examples/basics/timeflo.zip)

## Learn more

- [[Scenario]] - Timeline and scenario container reference
- [[Soundfiles]] - Audio file playback process
- [[Automation]] - Creating parameter automation curves
- [[Faust]] - Faust DSP effects like freeverb
