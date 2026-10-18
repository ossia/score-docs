---
layout: default
title: "Deforming a voxel model"
description: "Bend a block-built model into fluid motion and emphasize its changing shape with outlines."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/voxels.html
score: /examples/3d/voxels.zip
---

# Deforming a voxel model

![Voxel loader connected through Deform to VoxelMeshRenderer, with an LFO driving the deformation.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-voxels.png)

A block-built model takes on a gentle, fluid movement while colored outlines emphasize its edges.
Voxel loader converts the asset to geometry. A compute shader deforms it under LFO control, then the renderer, outline effect and tone mapping shape the final image. Geometry changes and image treatments remain independently adjustable.

## Try it

Open the ZIP directly in score; the voxel model is included. Start playback and vary the LFO's amplitude to change the driven deformation amount, then adjust Deform's radius. Outline color and opacity change the edges; Tonemap exposure changes the brightness of the whole image.

Change the loader's Mode and switch to point rendering to see how each mode builds the geometry. The outline effect has no camera buffer connected in this score, so do not treat it as the camera-aware depth setup used by the other scene examples.

Rendering is native; use a compute-capable graphics backend. The outline shader is embedded but still includes `depth_helpers.glsl`; install the `csf-examples` shader package with its `shaderlib/depth` directory intact.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
