---
layout: default
title: "Audio-reactive volume"
description: "An example showing a fractal volume whose appearance responds to sound."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/audioreactive-volumetric.html
score: /examples/3d/audioreactive-volumetric.score
---

# Audio-reactive volume

![Green raymarched volume behind the RMS, smoothing, Menger SDF and orbit raymarch processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-audioreactive-volumetric.png)

This example demonstrates a volumetric image that responds to the audio envelope.

## Overview

A Menger fractal is generated as a three-dimensional texture and viewed with raymarching. Sound changes its apparent density while the viewpoint slowly orbits around it. Unlike a polygon-based object, the image is formed by sampling the volume along each viewing ray.

## Try it

Enable an audio input and start playback. Sound changes the apparent density while the view keeps orbiting. Adjust RMS Gain before changing the smoothing Alpha. Compare density changes with the Menger shader's `iters` and `zoom`, which change the volume itself.

There is no bundled audio file; use a sound-file process as the analysis source if needed. The shaders are saved in the score and require compute-shader support. This is a volume-texture example rather than a Qt Quick 3D scene.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
