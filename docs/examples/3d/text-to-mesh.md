---
layout: default
title: "Text to deformed mesh"
description: "An example showing how to turn text into an animated 3D shape."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/text-to-mesh.html
score: /examples/3d/text-to-mesh.score
---

# Text to deformed mesh

![The extruded word sierra rendered in bright triangular colours above the deformation and rendering patch.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-text-to-mesh.png)

This example demonstrates turning text into animated 3D geometry.

## Overview

The word `sierra` is extruded into a solid shape, then warped and coloured on the GPU. Text becomes material for a visual composition rather than a flat caption: its typeface, depth and deformation all contribute to the result.

## Try it

Start playback and replace the Text value with a short word. Adjust Height to change the extrusion, then Deform's amount and radius to compare the undeformed and warped outlines. The font available on your machine can affect glyph shapes.

No external model is required. The deformation and colour shaders are stored in the document; use a graphics backend with compute support. The unrelated bit-glitch volume generator in the score is not used for the displayed text. Rendering uses the native scene pipeline.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
