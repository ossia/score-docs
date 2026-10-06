---
layout: default
title: "Volumetric texture viewers"
description: "An example comparing cross-sections and three-dimensional views of a fractal volume."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/volumetric-textures.html
score: /examples/3d/volumetric-textures.score
---

# Volumetric texture viewers

![Mandelbulb volume shown as three grayscale slices and three raymarched views, with their shared generator and Grid connections.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-volumetric-textures.png)

This example demonstrates several ways of viewing a three-dimensional texture.

## Overview

A Mandelbulb fractal provides the shared volume. Cross-sections reveal its interior one slice at a time, while raymarched views show its shape in depth. Displaying them together makes it possible to relate the slices to the larger structure.

## Try it

Start playback and change the Mandelbulb's `power`, `zoom` or iteration count: all views should change because they share the same volume. Then move just one `sliceZ` control to inspect a different cross-section without changing the other views. Compare that slice with the isosurface viewer's `iso` threshold.

No mesh or volume file is required. The generator and viewer shaders are stored in the document. Use a graphics backend with compute-shader support; this example works with volume textures rather than a Qt Quick 3D scene.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
