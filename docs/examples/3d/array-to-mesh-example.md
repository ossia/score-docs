---
layout: default
title: "Array to triangle mesh"
description: "Compose a pulsing radial sculpture by generating triangle coordinates with an expression."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/array-to-mesh.html
score: /examples/3d/array-to-mesh.score
---

# Array to triangle mesh

![Magenta radial triangle mesh above its Arraygen, Array to mesh and Render Pipeline processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-array-to-mesh.png)

A radial mesh changes shape as playback advances. Its vertex positions come from an expression instead of an imported model.

Arraygen computes the coordinates; Array to mesh groups them into triangles for a custom native renderer. The expression varies angle, radius and height with playback position. Triangulate is disabled because the expression already supplies complete triangles.

## Try it

Start playback, then change the radius term in Arraygen and watch the shape expand or contract. Change its Z displacement separately to give the pattern more or less depth. Keep three coordinates per vertex and three vertices per triangle. Finally, adjust the renderer's color or camera to distinguish changes in geometry from changes in presentation.

The expression and renderer are embedded. No external mesh or texture is needed.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
