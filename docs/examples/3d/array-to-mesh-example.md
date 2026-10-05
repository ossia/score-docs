---
layout: default
title: "Array to triangle mesh"
description: "Build an animated triangle mesh from a CPU-generated array of coordinates."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/array-to-mesh.html
score: /examples/3d/array-to-mesh.score
---

# Array to triangle mesh

Arraygen produces 360 scalar values, arranged as XYZ coordinates. Its expression groups values into vertices and triangles and uses interval position to vary their angle, radius and height. Array to mesh converts the result into native geometry, with Triangulate disabled: the expression already provides triangle vertices.

## Try it

Start playback to see the radial mesh change shape. Edit the Arraygen expression to change its radius or Z displacement; keep groups of three coordinates per vertex and three vertices per triangle. Change the Render Pipeline's `baseColor`, `eye` or `target` controls to distinguish geometry changes from shading and camera changes.

The custom native Render Pipeline sends its texture to `Window:/`. It does not use Qt Quick 3D and needs no external mesh or texture file.

[Download this example]({{ site.scores }}{{ page.score }})
