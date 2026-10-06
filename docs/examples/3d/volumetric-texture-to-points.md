---
layout: default
title: "Heat volume to point cloud"
description: "An example showing an evolving heat field as a warped point cloud."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/volumetric-texture-to-points.html
score: /examples/3d/volumetric-texture-to-points.score
---

# Heat volume to point cloud

![Faint warped point cloud above the heat-diffusion, domain-warp, VolumeToVoxels and Model Display processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-volumetric-texture-to-points.png)

This example demonstrates turning a changing volume into a point cloud.

## Overview

A moving heat source leaves an evolving field inside a three-dimensional texture. Noise warps that field, and sampling it as points reveals its shape from an orbiting camera. The example connects volumetric simulation with a more familiar geometry-based view.

## Try it

Start playback and change the warp `amount` to distinguish texture deformation from camera motion. In VolumeToVoxels, vary `threshold` to select the visible density, or `resolution` to change sampling density. Use the heat shader's `clear` control to reset its accumulated state.

The volume and shader code are generated or stored in the score; no voxel file is needed. The example requires compute-shader support and renders with native Model Display.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
