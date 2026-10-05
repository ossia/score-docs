---
layout: default
title: "Voxels with procedural sky"
description: "Layer a voxel mesh, volumetric clouds and depth-based post-processing."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/voxel-loader-and-sky.html
score: /examples/3d/voxel-loader-and-sky.score
---

# Voxels with procedural sky

Voxel loader feeds VoxelMeshRenderer, a native Render Pipeline. A second Render Pipeline draws the classic sky, using a Worley-noise volume for clouds. Camera goes through Scene Preprocessor and Extract buffer (by name) to provide the `camera` buffer used by the sky and depth effects. The voxel renderer also receives matching Eye and Target value controls directly.

The voxel image passes through Depth Contact Shadow, Depth Fake Point Light, Depth Micro AO and Depth Dither. That branch and the sky meet at Bloom, followed by Film Grain and Chromatic Aberration at `Window:/`. The layering uses depth, with the sky at the far distance in score's reverse-Z pipeline.

## Files and controls

Supply `Files/Can Models(Nabeel).vox` relative to the project, or change Voxel file to your own supported voxel asset: the download is a loose score, not a bundled model archive. Compute and post-processing shader code is saved in the document, with source references to `score-csf-testers` and the default shader package.

The depth effects also include `depth_helpers.glsl`; keep the `score-csf-testers/shaderlib/depth` directory installed with that shared helper. Embedded shader text alone does not replace its external include.

Start playback after resolving the voxel file. Adjust the voxel loader's transform to frame a replacement model. Keep camera Eye/Target values consistent between the camera buffer and voxel renderer when changing the view. Compare cloud settings, depth-effect strengths and Bloom separately. This is native rendering, not Qt Quick 3D.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
