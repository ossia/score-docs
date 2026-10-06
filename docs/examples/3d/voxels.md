---
layout: default
title: "Deforming a voxel model"
description: "An example showing how to give a voxel model fluid movement and outlines."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/voxels.html
score: /examples/3d/voxels.zip
---

# Deforming a voxel model

![Voxel loader connected through Deform to VoxelMeshRenderer, with an LFO driving the deformation.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-voxels.png)

This example demonstrates animating a voxel model with GPU deformation.

## Overview

A small, continuously varying deformation bends the model, while outlines emphasize its shape. Tone mapping controls the final appearance. This is a way to explore how a block-based asset can become more fluid without rebuilding it by hand.

## Try it

Open the ZIP directly in score. Start playback and compare Deform's amount and radius. Change the loader's Mode to inspect the available geometry representations; point rendering helps reveal differences in generated geometry. Adjust outline colour and opacity separately from Tonemap exposure.

The archive includes `Files/monu0.vox` and the shader code. The outline effect has no connected camera data in this version, so it is not the same setup as the camera-aware depth examples. Rendering is native, and deformation requires compute-shader support.

Depth + Color Outlines includes `depth_helpers.glsl`. Install `score-csf-testers` with its `shaderlib/depth` directory and helper file intact; the embedded shader still needs that relative include.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
