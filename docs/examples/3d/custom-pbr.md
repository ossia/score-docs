---
layout: default
title: "Procedural PBR material"
description: "Create an animated PBR material with procedural textures."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/custom-pbr.html
score: /examples/3d/custom-pbr.score
---

# Procedural PBR material

![PBR Mesh texture inlets for base colour, metallic roughness, normal and emissive maps, connected to Scene Preprocessor.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-custom-pbr.png)

This example demonstrates creating a changing PBR material with procedural textures.

## Overview

A cube provides a simple surface for exploring colour, metallic roughness, normal mapping and emission. Animated shader textures change its appearance, while a moving light reveals how the material responds. Bloom adds a glow to bright areas after rendering.

## Try it

Start playback and compare the material maps. Change Roughness and Metallic to explore the surface response, then Emissive strength and Bloom threshold to distinguish emitted light from the final glow. Adjust the light's modulation to see the material from another lighting angle.

This uses the native scene pipeline rather than Qt Quick 3D. The model and textures are procedural, and the shader code is stored in the score; no external movie or image is needed.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
