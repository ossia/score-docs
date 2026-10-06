---
layout: default
title: "Orbiting glTF instances"
description: "An example showing how to animate a swarm of repeated 3D models."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-gltf-instancing.html
score: /examples/3d/scene-gltf-instancing.zip
---

# Orbiting glTF instances

This example demonstrates animating many copies of a glTF model with GPU-generated positions.

## Overview

Thousands of ducks move along an orbit, turning a single model into a moving swarm. Instancing separates the model from the positions of its copies, allowing the overall arrangement to change without preparing each object individually. PBR lighting, bloom and tone mapping complete the scene.

## Try it

Open the ZIP directly in score; `Models/Duck.glb` is bundled. Start playback to see the orbiting instances. Change the Float control that drives orbit radius, then compare `orbitSpeed` and `spread`. The generator is configured for 30,000 points; lower that count if the scene is too costly on your GPU.

Keep floating-point render targets when working with the PBR branch, and tone-map before display so bright lighting is not clipped to an 8-bit range too early. The shaders are stored in the score. This is native scene instancing, not Qt Quick 3D.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
