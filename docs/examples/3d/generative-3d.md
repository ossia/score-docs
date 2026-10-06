---
layout: default
title: "Generative arc sphere"
description: "An example showing a generative structure with animated deformation and texturing."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/generative-3d.html
score: /common-practices/3d/generative-3d.score
---

# Generative arc sphere

![Arc Sphere patch with Bend, HypnoSwirl, colour automation and camera modulation connected to Model Display.]({{ site.baseurl }}/assets/scores/thumbnails/common-practices-3d-generative-3d.png)

This example demonstrates animating a generative structure with deformation and procedural texturing.

## Overview

A Structure Synth program creates an arc sphere. Bending changes its shape during rendering, while an animated texture and moving camera add further variation. The result combines a rule-based structure with continuous visual movement.

## Try it

Open the score and start playback. Move the pointer in the output window to interact with the HypnoSwirl texture. Change Bend's amount, radius or animation speed, then compare the deformation with the camera movement and changing colours.

The geometry program and shaders are stored in the score; no external model is needed. Structure Synth regenerates the mesh on the CPU, while the Bend filter deforms it during native Model Display rendering.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
