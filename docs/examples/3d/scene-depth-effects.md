---
layout: default
title: "Depth halftone and neon outlines"
description: "An example showing depth-based halftone patterns and glowing outlines."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-depth-effects.html
score: /examples/3d/scene-depth-effects.zip
---

# Depth halftone and neon outlines

This example demonstrates using depth to shape image effects in a 3D scene.

## Overview

A rotating duck is treated with a distance-dependent halftone pattern and glowing outlines. Unlike effects that only read the image's colours, these treatments use the scene depth and matching camera data to respond to distance.

## Try it

Open the ZIP directly in score and start playback; `Models/Duck.glb` is bundled. Change `dotsNear`, `dotsFar` and `depthScale` to compare halftone detail at different distances. Then adjust the outline threshold or glow radius. Compare these changes with the animated glow intensity and model rotation.

Keep the camera buffer connected to the same scene that produces the image and depth. A mismatched camera makes depth reconstruction inconsistent. The bundled model and embedded shaders form a native scene/post-processing pipeline, not Qt Quick 3D.

The depth shader code includes `depth_helpers.glsl`. Install the `score-csf-testers` package with its `shaderlib/depth` directory intact so that this shared include resolves relative to the saved shader source paths.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
