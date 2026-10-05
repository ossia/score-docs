---
layout: default
title: "Compute-rendered Clifford attractor"
description: "Write a generated image directly from a compute shader."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/compute-image.html
score: /examples/video/compute-image.score
---

# Compute-rendered Clifford attractor

The Clifford compute shader generates AttractorImage and writes it straight to `Window:/`, without a separate Model Display or fragment-rendering process. Three LFOs drive its `a`, `b` and `c` parameters, while `d` remains a shader control.

## Try it

Start playback and observe how the attractor changes under the slow modulation. Adjust brightness and fadeRate to compare new points with the accumulated image. Change pointsPerThread to explore the workload/detail trade-off, and alter the LFOs rather than manually setting a parameter already being driven.

No external image or geometry is needed. The saved compute shader requires a graphics backend with compute support. The example demonstrates direct GPU image generation; it is not a performance benchmark or a Qt Quick 3D scene.

[Download this example]({{ site.scores }}{{ page.score }})
