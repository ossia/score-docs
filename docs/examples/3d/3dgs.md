---
layout: default
title: "Gaussian splat scene"
description: "Explore a captured scene built from overlapping Gaussian splats rather than triangle surfaces."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/3dgs.html
score: /examples/3d/3dgs.zip
---

# Gaussian splat scene

![Gaussian-splat patch connecting an asset and camera to scene preprocessing, decoding and rendering.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-3dgs.png)

Explore a captured scene made from overlapping Gaussian splats rather than a conventional triangle mesh. Splat size and coverage affect whether its details appear distinct or merge into a fuller image.

The native scene pipeline loads the asset and camera, selects the splat data, then decodes it on the GPU for rendering. The bundled source is a compressed SPZ asset. This is an experimental rendering example, not a reference-quality reconstruction pipeline.

## Try it

Open the ZIP directly in score and start playback. Vary `scaleMod` to compare smaller and larger splats, then change `coverageThreshold` to see how the renderer's coverage cutoff affects the image. Use Camera's Eye and Target controls to inspect it from another viewpoint.

The archive includes the splat asset, and the decoding and rendering shaders are embedded. Use a graphics backend with compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
