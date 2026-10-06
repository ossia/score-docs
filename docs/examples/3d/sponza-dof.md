---
layout: default
title: "Native Sponza with depth of field"
description: "An example exploring depth of field and changing light in an architectural scene."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/sponza-dof.html
score: /examples/3d/sponza-dof.zip
---

# Native Sponza with depth of field

This example demonstrates depth of field in an architectural scene.

## Overview

The Sponza atrium and a helmet model provide foreground and background detail for exploring focus. Moving lights, an environment sky and subtle depth-based shading add to the scene, while an animated focus distance moves the sharpest area through the image. Both depth effects use the scene's camera data to interpret distance correctly.

## Try it

Open the ZIP directly in score. It includes `Models/sponza.glb`, `Models/DamagedHelmet.glb` and `Images/IndoorEnvironmentHDRI012.png`. The cubemap loader reads the PNG as an equirectangular environment at resolution 1024. Unlike the separate Qt Quick 3D Sponza example, this project uses native scene objects.

Start playback and focus the output window. Use WASD to move, the arrow keys to look around, Shift to move up and Control to move down. A slow modulation changes focusDepth; edit or disconnect it before choosing a fixed focus. Compare focusRange and blurAmount while moving past the helmet, then explore how the animated lighting changes its appearance.

The model and environment files are bundled, and the shaders and camera script are stored in the score. The depth shaders also need `depth_helpers.glsl`: install the `score-csf-testers` package with its `shaderlib/depth` directory intact.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
