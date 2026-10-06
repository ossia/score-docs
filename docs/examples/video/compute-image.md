---
layout: default
title: "Compute-rendered Clifford attractor"
description: "An example showing an evolving mathematical attractor drawn on the GPU."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/compute-image.html
score: /examples/video/compute-image.score
---

# Compute-rendered Clifford attractor

![Three LFOs connected to the Clifford compute shader's attractor parameters]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-compute-image.png)

This example demonstrates drawing a mathematical attractor directly with a compute shader.

## Overview

Slow modulation changes the Clifford attractor's shape, while accumulated points reveal its structure over time. The GPU generates the image without a separate mesh, making this an example of using computation itself as a visual source.

## Try it

Start playback and observe how the attractor changes under the slow modulation. Adjust brightness and fadeRate to compare new points with the accumulated image. Change pointsPerThread to explore the workload/detail trade-off, and alter the LFOs rather than manually setting a parameter already being driven.

No external image or geometry is needed. The embedded shader requires a graphics backend with compute support. This is an image-generation example, not a performance benchmark.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
