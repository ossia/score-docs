---
layout: default
title: "Math arrays to GPU geometry"
description: "Build position and colour buffers on the CPU, then render them as points."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/math-to-geometry.html
score: /examples/3d/math-to-geometry.score
---

# Math arrays to GPU geometry

Two Arraygen processes generate 300 entries each. Array Flattener converts their nested position and colour arrays to flat lists, and Array to buffer uploads Float32 buffers. Buffers to geometry binds buffer 0 to `position` with a 12-byte stride and buffer 1 to `color` with a 16-byte stride, with 300 vertices.

The native Instancing Render Pipeline renders the geometry. RGB Trails, Multi Pass Gaussian Blur, Exposure Adjust and Glow form a post-processing chain; Video Mixer combines the original trail and processed branches at `Window:/`. This does not use Qt Quick 3D.

## Try it

Start playback and edit the Arraygen expressions to change positions or colours. Keep three floats per position and four per colour, matching the attribute strides; if changing the number of entries, update the geometry vertex count too. Compare the mixer's branches to separate the generated point pattern from blur and glow.

The score is procedural and does not require external models, images or audio.

[Download this example]({{ site.scores }}{{ page.score }})
