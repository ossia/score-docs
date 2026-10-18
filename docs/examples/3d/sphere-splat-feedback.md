---
layout: default
title: "Sphere splats with texture feedback"
description: "Let a ring of particles sample its own previous image to build a changing color feedback effect."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/sphere-splat-feedback.html
score: /examples/3d/sphere-splat-feedback.score
---

# Sphere splats with texture feedback

![Glowing multicolored particle ring above the SphereSplat generator, feedback shader and renderer.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-sphere-splat-feedback.png)

A ring of glowing sphere splats takes color from its own previous image, so each frame feeds the next.

The generator makes the ring geometry, and a compute shader samples the feedback texture before rendering. The return cable is delayed: it supplies the previous frame instead of creating an immediate processing cycle. An independently moving camera changes the view of the ring.

## Try it

Start playback with a low `feedbackStrength`, then raise it: the previous image takes over more of the ring's color. Change `baseColor` to set the starting palette, then vary `projectionScale` to change how the previous image is sampled across the geometry.

Ring radius and sprite size also affect the feedback: changing the source arrangement changes the image returned to it. No external image is needed. The native rendering and feedback chain requires compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
