---
layout: default
title: "Compute-rendered Clifford attractor"
description: "Draw a slowly changing Clifford attractor by accumulating GPU-generated points."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/compute-image.html
score: /examples/video/compute-image.score
---

# Compute-rendered Clifford attractor

![Slow modulation controlling an accumulating Clifford attractor image]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-compute-image.png)

An accumulating field of points reveals a Clifford attractor as its shape slowly changes. The image shows both the current form and traces of earlier ones.

## Modulation and fading

Slow LFOs vary the attractor parameters while the compute shader draws points into the image. Brightness shapes their visibility, and fading determines how much of the earlier drawing remains. Fast fading with slow modulation shows one distinct form; slow fading with faster modulation layers several.

## Try it

- Start playback and observe a full sweep of the slow modulation before changing it. Alter the LFOs instead of manually adjusting an inlet they already drive.
- Raise brightness to make new points more visible, then change `fadeRate` to set how quickly old ones disappear.
- Raise `pointsPerThread` for a denser drawing; past a point, the image barely improves while the frame rate drops.

Use a graphics backend with compute support. No external image or geometry is needed; this patch is a visual experiment, not a performance benchmark.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
