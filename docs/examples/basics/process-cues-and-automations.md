---
layout: default
title: Process presets, cues and automations
description: "Animate a fractal, recall complete visual looks and compare fixed automation with transitions from a live camera setting."
parent: Basics
grand_parent: Examples
permalink: /examples/basics/process-cues-and-automations.html
score: /examples/basics/process-cues-and-automations.score
---

# Process presets, cues and automations

![Mandelbulb and VolumeRaymarcher processes with automation curves, preset cues and a volume preview]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-process-cues-and-automations.png)

A rendered Mandelbulb fractal becomes a small rehearsal space for performing visual changes. Compare a movement that repeats automatically with a look recalled on demand, then try a transition that begins wherever you have left the camera.

## Overview

One version automates a shader control directly. The other exposes controls through the Local device so that states and automations can reach them. Cues recall fractal and camera settings; Tween starts a transition from the current setting rather than assuming that the previous cue has left everything in a predetermined state.

The image uses score's native compute and ISF shaders and requires a compute-capable graphics backend. The saved shader references use the `csf-examples` library package; no external model or media file is used.

## Try it

1. Start playback and trigger `Raymarch`. Watch the fractal change through a loop, then alter the automation to change the movement's shape.
2. End that branch before starting `Raymarch.1`, since both render to the same window.
3. Try the standalone cues in a different order, then play the connected cue sequence. Compare improvising between looks with rehearsing a repeatable progression.
4. Change a camera control yourself before trying the Automation and Tween intervals. Watch the beginning of each transition: Tween accommodates the live starting point, while fixed automation follows its saved curve.

To make a new cue, drag a process's preset-folder icon into a state. This can store the complete process state, including shader code; hold Ctrl/Cmd while dropping to choose a controls-only snapshot. To automate one inlet, right-click it and choose **Create automation**, or drag the port into another interval.

You can adapt the exposed Local controls for a remote performer, but no external controller is needed for these comparisons.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

