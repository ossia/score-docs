---
layout: default
title: "Volumetric texture viewers"
description: "Compare slices and raymarched views of one GPU-generated Mandelbulb volume."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/volumetric-textures.html
score: /examples/3d/volumetric-textures.score
---

# Volumetric texture viewers

![Mandelbulb volume shown as three grayscale slices and three raymarched views, with their shared generator and Grid connections.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-volumetric-textures.png)

A Mandelbulb compute shader produces one three-dimensional texture, connected to six ISF viewers. Three viewers sample individual Z slices (initially 0.142, 0.267 and 0.75). The others use isosurface or orbiting raymarch views. Grid combines their two-dimensional outputs at `Window:/`.

## Try it

Start playback and change the Mandelbulb's `power`, `zoom` or iteration count: all views should change because they share the same volume. Then move just one `sliceZ` control to inspect a different cross-section without changing the other views. Compare that slice with the isosurface viewer's `iso` threshold.

No mesh or volume file is required. This is a compute/ISF texture pipeline, not a Qt Quick 3D scene. The saved shader sources refer to `score-csf-testers/shaderlib/volume` and the default Grid shader; their code is stored in the document.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
