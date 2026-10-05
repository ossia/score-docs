---
layout: default
title: GPU data bending
description: "Compare GPU glitch and feedback shaders driven by a shared camera texture."
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/gpu-data-bending.html
score: /examples/advanced/gpu-data-bending.score
---

# GPU data bending

Compare GPU glitch and feedback shaders driven by a shared camera texture.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/gpu-data-bending.score)

## Run and compare

Select the Camera device and start playback. Color Controls reads `Camera:/`, then fans its corrected texture out to two Sorting Smear instances, FastMosh, Key Frame Artifacts and Optical Flow Distort. Grid combines those five results with the corrected input at `Window:/`.

Square-wave LFOs toggle horizontal sorting, key-frame refresh and optical-flow reset. Try changing FastMosh's update rate (saved at 0.03), the vertical Sorting Smear's adapt level (0.039), or Optical Flow Distort's amount. Moving in front of the camera makes the temporal differences easier to see than a still image.

The shader code is embedded in the document and originates from the ISF library. A GPU graphics backend and camera are needed; alternatively connect a video or generator texture to Color Controls. This is a shader-processing graph, not a Qt Quick 3D scene.
