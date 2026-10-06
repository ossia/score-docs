---
layout: default
title: "Comparing native render pipelines"
description: "An example comparing physically based, retro and wireframe views of one scene."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-rendering-pipelines.html
score: /examples/3d/scene-rendering-pipelines.zip
---

# Comparing native render pipelines

![Camera, duck asset and light feeding Scene Preprocessor and separate PBR and retro render pipelines, beside the mode-switching Scenario.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-scene-rendering-pipelines.png)

This example demonstrates how rendering style changes the appearance of the same 3D scene.

## Overview

A rotating duck is shown with physically based shading, two retro-inspired treatments and a wireframe overlay. Switching styles makes it possible to compare lighting, surface detail and the underlying mesh without changing the model.

## Try it

Open the ZIP directly in score and start playback; `Models/Duck.glb` is bundled. Trigger the manual time-syncs labelled PBR mode, PS1 mode and N64 mode to compare the three looks. Each switches the image blend and lighting together, and can be triggered again during playback.

Adjust the fourth mixer alpha to compare the wireframe overlay. Explore the renderer shaders if you want to develop another look. The retro styles are illustrative, not hardware-accurate emulators. The example uses native rendering and does not require Qt Quick 3D.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
