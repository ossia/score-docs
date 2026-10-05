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

A **Sphere** goes through **Geometry filter** into **Model Display**. A Checkerboard shader supplies the texture, and Glow processes the rendered image before it reaches `Window:/`. This is score's native geometry-rendering path, not a Qt Quick 3D scene.

The filter changes vertex positions with:

`position.xyz += this_filter.intensity * 10. * sin(TIME * position.xyz);`

A slow sine LFO controls intensity. A separate triangle LFO passes through Micromap, whose `return [360x, 360x, 360x]` expression rotates the sphere on all three axes.

## Try it

Start playback and open the Window device output. Inspect the two LFO connections before adjusting them: changing rotation and changing deformation are independent operations. Temporarily disconnect the intensity cable and set intensity to zero to compare the undeformed sphere. Increase sphere subdivisions if you want finer deformation. No mesh or image file is required.

See [[Model display]] for rendering the resulting geometry.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

