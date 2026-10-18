---
layout: default
title: "Math arrays to GPU geometry"
description: "Compose a moving point pattern and its colors independently, then layer trails and glow."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/math-to-geometry.html
score: /examples/3d/math-to-geometry.score
---

# Math arrays to GPU geometry

![Separate position and color arrays passing through Array Flattener and Array to buffer into Buffers to geometry and the Instancing renderer.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-math-to-geometry.png)

Two mathematical arrays, one for where points move and one for how they are colored, become a single moving image with trails, blur and glow.

One Arraygen expression produces XYZ positions; another produces RGBA colors. Flattening these arrays and transferring them to GPU buffers lets Buffers to geometry pair each position with a color. The native renderer draws the result, and the mixer combines its processed images.

## Try it

Start playback and edit only the color expression first: the palette changes without rewriting the point positions. Then change the position expression while keeping the colors. Isolate the mixer's branches one at a time to see the point pattern without its trails and glow.

Keep the buffers consistent: the saved geometry has 300 vertices, three Float32 values per position and four per color, with strides of 12 and 16 bytes. If you change the number of entries, update the vertex count too. No external models, images or audio are needed.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
