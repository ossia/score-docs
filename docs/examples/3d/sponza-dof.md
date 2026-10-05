---
layout: default
title: "Native Sponza with depth of field"
description: "Combine native scene assets, skybox, moving lights and camera-aware depth effects."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/sponza-dof.html
score: /examples/3d/sponza-dof.zip
---

# Native Sponza with depth of field

Two Asset Loaders supply Sponza and a helmet. They join Camera, three Lights, Environment and the native cubemap loader in Scene Preprocessor. PBR and skybox Render Pipelines feed Depth Micro AO, followed by Depth of Field at `Window:/`. Extract buffer (by name) supplies the matching camera buffer to both depth effects.

## Try it

Open the ZIP directly in score. It includes `Models/sponza.glb`, `Models/DamagedHelmet.glb` and `Images/IndoorEnvironmentHDRI012.png`. The cubemap loader reads the PNG as an equirectangular environment at resolution 1024. Unlike the separate Qt Quick 3D Sponza example, this project uses native scene objects.

Start playback and focus the output window. The fps-camera script reads `Window:/key/press/code` and `Window:/key/release/code`: WASD moves, arrow keys look around, Shift moves up and Control moves down. An LFO through `10x` drives focusDepth, so edit that modulation or disconnect it before setting a fixed focus. Compare focusRange and blurAmount while moving past the helmet. Other modulators rotate the helmet and move and recolour a light.

The model and environment files are bundled, and the shader and camera-script code is stored in the score. The depth shaders include `depth_helpers.glsl`: install the `score-csf-testers` package with its `shaderlib/depth` directory intact so that the include resolves. This graph uses native scene rendering and depth effects.

[Download this example]({{ site.scores }}{{ page.score }})
