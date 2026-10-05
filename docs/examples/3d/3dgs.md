---
layout: default
title: "Gaussian splat scene"
description: "Decode and render a PLY Gaussian-splat asset through the native scene pipeline."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/3dgs.html
score: /examples/3d/3dgs.zip
---

# Gaussian splat scene

Asset Loader loads `Models/room.ply`. Scene Preprocessor combines it with Camera, and Flattened Scene Filter selects the `3dgs.classic` format. A compute shader decodes the splat data, with spherical-harmonic degree and depth-sort controls, before a dedicated Render Pipeline writes to `Window:/`.

## Try it

Open the ZIP directly in score. Start playback, then compare `scaleMod` and `coverageThreshold`: one changes splat scale while the other controls coverage in the renderer. Use the Camera controls to inspect the room from another viewpoint.

The PLY model is bundled. Compute and render shader code is stored in the document; the decoder's saved source is `score-csf-testers/splat-formats/3dgs.classic/01_Decode.cs`. This example uses native Gaussian-splat rendering, not Qt Quick 3D. It requires compute-shader support.

[Download this example]({{ site.scores }}{{ page.score }})
