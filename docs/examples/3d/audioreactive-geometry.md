---
layout: default
title: "Audio-reactive point geometry"
description: "Use sound level to deform a point cloud, with smoothing to shape how quickly it responds."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/audioreactive-geometry.html
score: /examples/3d/audioreactive-geometry.score
---

# Audio-reactive point geometry

![RMS and smoothing connected to NoiseField, followed by AddColor and the PointCloud3D renderer.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-audioreactive-geometry.png)

A point cloud expands into noisy deformation as the sound level changes. Smoothing makes the movement follow a gradual envelope instead of jumping at every fluctuation.

RMS measures the audio input's level. Its smoothed output drives NoiseField's deformation amplitude; separate LFO modulation keeps the noise evolving. A color stage makes the generated positions visible in the native point-cloud renderer.

## Try it

Select a working input in score's audio settings, allow microphone access if prompted, and start playback. Make a short sound, then hold a steady one. Adjust RMS Gain and Gate so the deformation responds to the levels you intend to use.

Lower Exp Smoothing Alpha: the cloud reacts and settles more slowly. The slow noise evolution can continue even when the audio response is quiet, so listen and watch for those two sources of motion separately.

No recording is included. If you do not have a microphone, connect a sound-file process to RMS instead. Compute-shader support is required; increase `gridSize` cautiously because it increases the generated geometry.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
