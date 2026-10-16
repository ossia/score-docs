---
layout: default
title: "Voxels with procedural sky"
description: "Place a voxel sculpture beneath moving volumetric clouds and shape it with depth-based lighting."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/voxel-loader-and-sky.html
score: /examples/3d/voxel-loader-and-sky.zip
---

# Voxels with procedural sky

A voxel model sits beneath a changing sky, with volumetric clouds above it and depth-based lighting giving the foreground shape. This patch is useful for building a layered environment around a small imported sculpture.

The clouds come from a generated volume, while the model is rendered as geometry. Depth keeps the sky behind the foreground in score's reverse-Z rendering system. Depth-based shadows, shading and a moving light treatment add detail before bloom, grain and chromatic aberration finish the image.

The sky and depth effects need the same viewpoint as the voxel renderer. Shared Eye and Target controls drive both paths; keep them aligned when adapting the composition.

## Try it

Open the ZIP directly in score; the voxel model is included. Start playback and vary the cloud settings before adjusting the depth-effect strengths. Compare these with Bloom so you can distinguish a change in sky structure or surface shading from a glow added to the finished image.

To use your own supported voxel asset, select it in Voxel file and adjust the loader's transform to frame it. Compute-shader support is required. The depth shaders also include `depth_helpers.glsl`: install the `csf-examples` package with its `shaderlib/depth` directory intact, even though the main shader code is stored in the score.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
