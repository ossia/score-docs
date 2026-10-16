---
layout: default
title: "Heat volume to point cloud"
description: "Reveal a moving heat source's lingering field as a warped, orbiting point cloud."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/volumetric-texture-to-points.html
score: /examples/3d/volumetric-texture-to-points.score
---

# Heat volume to point cloud

![Faint warped point cloud above the heat-diffusion, domain-warp, VolumeToVoxels and Model Display processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-volumetric-texture-to-points.png)

A moving heat source leaves a field that diffuses and cools over time. Sampling that field as points turns an invisible volume into a spatial trace, useful for exploring how a gesture can linger and spread rather than disappear immediately.

The heat simulation writes a three-dimensional texture. Noise warps that texture before VolumeToVoxels samples it into point geometry, which Model Display views from an orbiting camera. The motion of the source, deformation of the field and motion of the viewpoint are separate parts of the image.

## Try it

Start playback and bring the warp `amount` toward zero to see the underlying heat field. Increase it to compare the distorted form, then vary VolumeToVoxels' `threshold` to reveal different parts of the field.

Change `resolution` to compare coarse and dense sampling; higher values increase the workload. Use the heat shader's `clear` control to reset accumulated state and watch a new trace form. No voxel file is needed, but the simulation and conversion require compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
