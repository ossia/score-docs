---
layout: default
title: "Voxels with procedural sky"
description: "An example showing a voxel model against a procedural sky with volumetric clouds."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/voxel-loader-and-sky.html
score: /examples/3d/voxel-loader-and-sky.score
---

# Voxels with procedural sky

This example demonstrates placing a voxel model in a procedural sky.

## Overview

Volumetric clouds provide a changing backdrop, while depth-based shadows, lighting and outlines help shape the foreground. Bloom, grain and chromatic aberration finish the image. The sky is kept behind the model using depth in score's reverse-Z rendering system.

The sky and depth effects need camera data consistent with the voxel renderer. When adapting the example, keep their Eye and Target settings aligned so that the layers describe the same viewpoint.

## Files and controls

Supply `Files/Can Models(Nabeel).vox` relative to the project, or change Voxel file to your own supported voxel asset: the download is a loose score, not a bundled model archive. Compute and post-processing shader code is saved in the document, with source references to `score-csf-testers` and the default shader package.

The depth effects also include `depth_helpers.glsl`; keep the `score-csf-testers/shaderlib/depth` directory installed with that shared helper. Embedded shader text alone does not replace its external include.

Start playback after resolving the voxel file. Adjust the voxel loader's transform to frame a replacement model. Compare cloud settings, depth-effect strengths and Bloom separately before combining them. The example uses native rendering and requires compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
