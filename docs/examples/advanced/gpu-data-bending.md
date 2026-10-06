---
layout: default
title: GPU data bending
description: "An example showing GPU-based video glitch effects"
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/gpu-data-bending.html
score: /examples/advanced/gpu-data-bending.score
---

# GPU data bending

This example demonstrates GPU image distortion with glitch, sorting and feedback shaders. It is a starting point for exploring how motion and retained images can become visual material.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/gpu-data-bending.score)

## Try it

Select a working Camera device and start playback. The output places the corrected camera image beside five variations, making it easy to compare sorting, compression-like artifacts and optical-flow distortion.

Move in front of the camera: a moving subject reveals the temporal effects more clearly than a still image. Change FastMosh's update rate, Sorting Smear's adaptation or Optical Flow Distort's amount. Then try changing the LFOs that reset or refresh the effects to alter their rhythm.

The shader code is embedded in the document and originates from the ISF library. A GPU graphics backend and camera are needed; alternatively connect a video or generator texture to Color Controls. This uses score's native shaders, not Qt Quick 3D.
