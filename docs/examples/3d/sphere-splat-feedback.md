---
layout: default
title: "Sphere splats with texture feedback"
description: "Let a ring of particles sample its own previous image to build a changing colour feedback effect."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/sphere-splat-feedback.html
score: /examples/3d/sphere-splat-feedback.score
---

# Sphere splats with texture feedback

![Glowing multicoloured particle ring above the SphereSplat generator, feedback shader and renderer.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-sphere-splat-feedback.png)

A ring of glowing sphere splats takes colour from its own previous image. This connects the appearance of the rendered scene back to the particles, making the image part of the process that produces the next frame.

The generator makes the ring geometry, and a compute shader samples the feedback texture before rendering. The return cable is delayed: it supplies the previous frame rather than creating an immediate processing cycle. An independently moving camera changes the view of the ring.

## Try it

Start playback with a low `feedbackStrength` and compare the result as you raise it. Adjust `baseColor` separately to distinguish the base contribution from the sampled image. Then vary `projectionScale` to change how that image is sampled across the geometry.

Compare ring radius or sprite size with the feedback settings: changing the source arrangement also changes the image returned to it. No external image is needed. The native rendering and feedback chain requires compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
