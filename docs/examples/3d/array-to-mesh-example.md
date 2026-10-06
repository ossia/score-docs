---
layout: default
title: "Array to triangle mesh"
description: "An example showing how to animate a triangle mesh with mathematical expressions."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/array-to-mesh.html
score: /examples/3d/array-to-mesh.score
---

# Array to triangle mesh

![Magenta radial triangle mesh above its Arraygen, Array to mesh and Render Pipeline processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-array-to-mesh.png)

This example demonstrates generating an animated triangle mesh from a mathematical expression.

## Overview

The expression describes a radial shape whose angle, radius and height change with playback position. It produces complete triangles rather than a model file, making the geometry itself something you can compose and animate.

## Try it

Start playback to see the radial mesh change shape. Edit the Arraygen expression to change its radius or Z displacement. Keep three coordinates per vertex and three vertices per triangle; Triangulate is disabled because the expression already supplies triangles. Then try changing the renderer's colour or camera to compare geometry, shading and viewpoint.

The custom native renderer and expression are stored in the score. No external mesh or texture file is needed.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
