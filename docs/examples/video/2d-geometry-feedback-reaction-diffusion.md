---
layout: default
title: "Reaction-diffusion geometry feedback"
description: "Simulate a two-dimensional chemical field in GPU geometry buffers."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/2d-geometry-feedback-reaction-diffusion.html
score: /examples/video/2d-geometry-feedback-reaction-diffusion.score
---

# Reaction-diffusion geometry feedback

![A reaction-diffusion pattern above the RD_Init, RD_Diffuse, RD_React and rendering processes]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-2d-geometry-feedback-reaction-diffusion.png)

RD_Init → RD_Diffuse → RD_React forms the simulation chain. RD_React returns geometry to RD_Init through a delayed cable, preserving the previous frame's state. RD_Display separately converts the chemical attribute into colour, then a native Render Pipeline draws a circle per vertex at `Window:/`.

## Try it

Start playback and compare the patterns after changing `feed` and `kill`. Adjust `diffU` and `diffV` to change the diffusion rates. Use RD_Init's `reset` control to restart the field. If changing grid width, keep RD_Init and RD_Diffuse consistent; both are saved at 128.

No input image or data file is needed. The shaders are embedded and require compute-shader support. This uses native geometry feedback, not Qt Quick 3D and not a texture-feedback loop.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
