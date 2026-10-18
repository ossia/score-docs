---
layout: default
title: "Volumetric texture viewers"
description: "Inspect one fractal volume through cross-sections and raymarched views displayed together."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/volumetric-textures.html
score: /examples/3d/volumetric-textures.score
---

# Volumetric texture viewers

![Mandelbulb volume shown as three grayscale slices and three raymarched views, with their shared generator and Grid connections.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-volumetric-textures.png)

Look inside a fractal as well as around it. Three cross-sections and three raymarched views share the same Mandelbulb volume.

The generator writes a three-dimensional texture. Slice viewers read individual planes through it, while raymarching viewers sample through its depth or reveal a surface at a chosen threshold. A grid places the results together, so changing the source has a visible effect across all six views.

## Try it

Start playback and change the Mandelbulb's `power` or `zoom`: all six views update together. Move just one `sliceZ` control to explore a different cross-section without changing the source.

Then vary an isosurface viewer's `iso` threshold. This chooses a different boundary within the same field; it does not generate a new volume. No mesh or volume file is required; the embedded generator needs a graphics backend with compute-shader support. This uses native volume textures, not a Qt Quick 3D scene.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
