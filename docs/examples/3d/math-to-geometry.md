---
layout: default
title: "Math arrays to GPU geometry"
description: "An example showing how to compose point positions and colours with mathematical expressions."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/math-to-geometry.html
score: /examples/3d/math-to-geometry.score
---

# Math arrays to GPU geometry

![Separate position and colour arrays passing through Array Flattener and Array to buffer into Buffers to geometry and the Instancing renderer.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-math-to-geometry.png)

This example demonstrates generating a point pattern and its colours from mathematical expressions.

## Overview

Separate arrays describe where each point is and what colour it has. They are transferred to GPU buffers and combined into geometry, allowing position and colour to be composed independently. Trails, blur and glow turn the moving points into a layered image.

The example uses 300 vertices, with three Float32 values per position and four per colour. The corresponding attribute strides are 12 and 16 bytes. Keep these layouts consistent when adapting the expressions. Rendering uses the native pipeline rather than Qt Quick 3D.

## Try it

Start playback and edit the Arraygen expressions to change positions or colours. Keep three floats per position and four per colour, matching the attribute strides; if changing the number of entries, update the geometry vertex count too. Compare the mixer's branches to separate the generated point pattern from blur and glow.

The score is procedural and does not require external models, images or audio.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
