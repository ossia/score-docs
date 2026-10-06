---
layout: default
title: "Animated Sphere Geometry Filter"
description: "Rotate and deform a checkerboard sphere with two control signals."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/geometry-filter.html
score: "/reference/processes/geometry-filter.score"
---

# Animated Sphere Geometry Filter

![Sphere and Geometry filter connected to Model Display, with separate LFO controls and a Checkerboard texture branch.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-geometry-filter.png)

This example animates a checkerboard sphere in two ways: turning it in space and deforming its surface. The two movements are controlled independently, so you can explore how they contribute to the result.

**Geometry filter** moves the sphere's vertices with a sine expression:

`position.xyz += this_filter.intensity * 10. * sin(TIME * position.xyz);`

A slow sine LFO controls deformation intensity, while a triangle LFO and Micromap rotate the sphere on all three axes. **Model Display** renders the result with a generated checkerboard texture and Glow. This uses score's native geometry rendering, not Qt Quick 3D.

## Try it

Start playback and open the Window device output. Inspect the two LFO connections before adjusting them: changing rotation and changing deformation are independent operations. Temporarily disconnect the intensity cable and set intensity to zero to compare the undeformed sphere. Increase sphere subdivisions if you want finer deformation. No mesh or image file is required.

See [[Model display]] for rendering the resulting geometry.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

