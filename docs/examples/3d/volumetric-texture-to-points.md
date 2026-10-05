---
layout: default
title: "Heat volume to point cloud"
description: "Warp a heat-diffusion volume and extract visible points from it."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/volumetric-texture-to-points.html
score: /examples/3d/volumetric-texture-to-points.score
---

# Heat volume to point cloud

Heat diffusion creates a 3D texture with a moving heat source controlled by Random XYZ. Domain warp noise distorts the texture, and VolumeToVoxels samples it into geometry. Model Display renders the result as points while an Orbit expression moves the camera. The output is `Window:/`.

## Try it

Start playback and change the warp `amount` to distinguish texture deformation from camera motion. In VolumeToVoxels, vary `threshold` to select the visible density, or `resolution` to change sampling density. Use the heat shader's `clear` control to reset its accumulated state.

The score generates its volume; no voxel file is needed. It requires compute-shader support and uses native Model Display, not Qt Quick 3D. Saved shader source references point to the heat-diffusion and domain-warp shaders in `score-csf-testers`; the code is embedded in the score.

[Download this example]({{ site.scores }}{{ page.score }})
