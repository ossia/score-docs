---
layout: default
title: Process presets, cues and automations
description: "An example showing how to control process parameters with cues and automation"
parent: Basics
grand_parent: Examples
permalink: /examples/basics/process-cues-and-automations.html
score: /examples/basics/process-cues-and-automations.score
---

# Process presets, cues and automations

![Mandelbulb and VolumeRaymarcher processes with automation curves, preset cues and a volume preview]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-process-cues-and-automations.png)

This example demonstrates different ways to control a process during a performance: continuous automation, recalled presets and transitions from the current value.

## Overview

A rendered Mandelbulb fractal provides a visual comparison. One version uses direct automation of a shader control; the other exposes its controls in the Local device so that states and automations can address them. Cues recall fractal and camera settings, while Tween makes a transition start from the current setting rather than a predetermined value.

The image uses score's native compute and ISF shaders, not Qt Quick 3D. A compute-capable graphics backend is required. The shaders originate in the `score-csf-testers` library package; no external model or media file is used.

## Try it

1. Start playback and trigger `Raymarch`. Watch the looping automation change the fractal.
2. End that branch before starting `Raymarch.1`, since both render to the same window.
3. Try the standalone cues, then the connected cue sequence. Compare choosing a setting freely with arranging changes in time.
4. Compare the Automation and Tween intervals after changing a camera control yourself.

To make a new cue, drag a process's preset-folder icon into a state. This can store the complete process state, including shader code; hold Ctrl/Cmd while dropping to choose a controls-only snapshot. To automate one inlet, right-click it and choose **Create automation**, or drag the port into another interval.

The Local device can also expose these controls for remote use. Its saved OSC and WebSocket ports are 6666 and 9999, but no external controller is required here.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

