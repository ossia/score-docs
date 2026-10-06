---
layout: default
title: "Sphere splats with texture feedback"
description: "An example showing a particle effect influenced by its own previous image."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/sphere-splat-feedback.html
score: /examples/3d/sphere-splat-feedback.score
---

# Sphere splats with texture feedback

![Glowing multicoloured particle ring above the SphereSplat generator, feedback shader and renderer.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-sphere-splat-feedback.png)

This example demonstrates using a rendered image to influence a 3D particle effect.

## Overview

A ring of sphere splats samples its own previous image, creating a feedback effect that links geometry processing and rendering. The delayed texture connection is essential: it makes the previous frame available to the computation without creating an immediate cycle.

## Try it

Start playback and change `feedbackStrength` to compare the feedback contribution with `baseColor`. Vary `projectionScale` to explore how the previous image is sampled. Then try different particle counts, ring radii or sprite sizes, and compare those changes with the automatically moving camera.

Everything is generated in the score; no source image is needed. This example uses native rendering and requires compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
