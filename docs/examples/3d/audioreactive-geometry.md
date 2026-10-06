---
layout: default
title: "Audio-reactive point geometry"
description: "An example showing a 3D point cloud that deforms in response to sound."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/audioreactive-geometry.html
score: /examples/3d/audioreactive-geometry.score
---

# Audio-reactive point geometry

![RMS and smoothing connected to NoiseField, followed by AddColor and the PointCloud3D renderer.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-audioreactive-geometry.png)

This example demonstrates a 3D point cloud that responds to sound.

## Overview

Audio amplitude controls the strength of a noisy deformation, while slow modulation keeps the shape evolving. Smoothing softens the response so that the cloud can move gradually rather than jump with every change in level. It is a starting point for audio-reactive concert visuals or installations.

## Try it

Select a working audio input in score's audio settings, start playback and make sound. The point cloud's deformation should respond to the smoothed level, rather than simply following the LFO. Adjust RMS Gain and Gate to suit the input, then change Exp Smoothing Alpha to compare fast and gradual responses.

If no microphone is available, use a sound-file process as the analysis source. No audio recording is included. The example uses compute shaders and native rendering; increase `gridSize` cautiously, as it increases the amount of generated geometry.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
