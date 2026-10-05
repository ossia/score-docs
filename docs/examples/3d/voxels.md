---
layout: default
title: "Deforming a voxel model"
description: "Load a voxel asset as geometry and apply deformation, outlines and tone mapping."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/voxels.html
score: /examples/3d/voxels.zip
---

# Deforming a voxel model

Voxel loader reads `Files/monu0.vox`. Deform modifies the geometry on the GPU, driven by a small-amplitude LFO. VoxelMeshRenderer renders it, then Depth + Color Outlines and Tonemap send the result to `Window:/`.

## Try it

Open the ZIP directly in score. Start playback and compare Deform's amount and radius. Change the loader's Mode to inspect the available geometry representations; point rendering helps reveal differences in generated geometry. Adjust outline colour and opacity separately from Tonemap exposure.

The voxel file is included and the shader code is saved in the score. The outline shader's camera inlet is unconnected in this document; unlike the camera-aware depth examples, this graph does not extract a scene camera buffer. This uses native Voxel loader and Render Pipeline, not Qt Quick 3D, and the deformation requires compute-shader support.

Depth + Color Outlines includes `depth_helpers.glsl`. Install `score-csf-testers` with its `shaderlib/depth` directory and helper file intact; the embedded shader still needs that relative include.

[Download this example]({{ site.scores }}{{ page.score }})
