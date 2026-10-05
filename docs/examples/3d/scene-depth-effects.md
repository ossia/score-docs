---
layout: default
title: "Depth halftone and neon outlines"
description: "Use a native scene depth buffer and matching camera data for post-processing."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-depth-effects.html
score: /examples/3d/scene-depth-effects.zip
---

# Depth halftone and neon outlines

A rotating duck is rendered by the classic PBR Render Pipeline. Depth Halftone converts the image to a distance-dependent dot pattern; Depth Neon Outlines adds an animated glow and writes to `Window:/`. Extract buffer (by name) takes `camera` from Scene Preprocessor and sends it to both effects.

## Try it

Open the ZIP directly in score and start playback; `Models/Duck.glb` is bundled. Change `dotsNear`, `dotsFar` and `depthScale` to compare near and distant halftone detail. Then adjust outline threshold or glow radius. One LFO controls glow intensity; another passes through `360x` and Vec3f to rotate the model.

Keep the camera buffer connected to the same scene that produces the image and depth. A mismatched camera makes depth reconstruction inconsistent. The bundled model and embedded shaders form a native scene/post-processing pipeline, not Qt Quick 3D.

The depth shader code includes `depth_helpers.glsl`. Install the `score-csf-testers` package with its `shaderlib/depth` directory intact so that this shared include resolves relative to the saved shader source paths.

[Download this example]({{ site.scores }}{{ page.score }})
