---
layout: default
title: "Native instancing gallery"
description: "Compare orbiting and grid-based instances in four separately rendered views."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/instancing-full.html
score: /examples/3d/instancing-full.score
---

# Native instancing gallery

![Four rendered instancing views showing orbiting helmets, a helmet grid, a duck grid and a red box lattice.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-instancing-full.png)

Four native scene branches instance imported glTF models. The first uses OrbitParticles to position helmets; the second places helmets on an 8-by-8 grid; the third does the same with ducks. The fourth builds a three-dimensional box grid whose X and Y counts are driven by step sequencers through exponential smoothing.

Each branch combines Asset Loader and Instancer with Camera, Light and Environment in Scene Preprocessor, renders with the PBR Render Pipeline, then tone-maps its output. A four-input grid shader combines the views at `Window:/`. These are native scene objects, not Qt Quick 3D instancing.

## Files and controls

This download is a loose score. Supply `Models/DamagedHelmet.glb`, `Models/Duck.glb` and `Models/Box.glb` relative to the project, or change the Asset file controls to your copies. The saved shaders refer to the `score-csf-testers` package, including OrbitParticles, GridPoints, ToneMapping and the four-view grid shader; their code is stored in the document.

Start playback after resolving the model paths. Change the orbit radius or grid spacing and compare their effects across the four views. For the box branch, edit the sequencer values rather than a grid-count control that is already being driven.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
