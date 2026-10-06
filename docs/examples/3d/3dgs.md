---
layout: default
title: "Gaussian splat scene"
description: "An example showing how to explore a room represented by Gaussian splats."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/3dgs.html
score: /examples/3d/3dgs.zip
---

# Gaussian splat scene

![Gaussian-splat patch connecting the PLY asset and camera to scene preprocessing, format selection, decoding and rendering.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-3dgs.png)

This example demonstrates viewing a Gaussian-splat scene in ossia score.

## Overview

A room stored as a PLY splat asset is decoded on the GPU and rendered from a controllable camera. Instead of relying on a conventional triangle mesh, the scene is represented by overlapping splats. Their scale and coverage affect how the reconstructed room appears.

## Try it

Open the ZIP directly in score. Start playback, then compare `scaleMod` and `coverageThreshold`: one changes splat scale while the other controls coverage in the renderer. Use the Camera controls to inspect the room from another viewpoint.

The archive includes `Models/room.ply`, and the decoding and rendering shaders are stored in the document. This example uses the native Gaussian-splat renderer and requires compute-shader support; it is not a Qt Quick 3D scene.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
