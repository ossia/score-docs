---
layout: default

title: Camera input
description: "An example showing how to use camera input"

parent: Video Examples
grand_parent: Examples

permalink: /examples/video/camera.html
---

# Camera input

![Camera Example]({{ site.img }}/examples/video/camera.png "Camera input in ossia score")

This example demonstrates modifying live video input on the GPU with a simple audio-reactive ISF shader pipeline.

## Overview

Audio-reactive graphics are a staple of live performance and music visualization. 
This example shows how to analyze audio and use the results to modify video input.

## Live performance

This type of patch is ideal for:
- VJ performances
- Concert visuals
- Interactive installations
- Music videos

## Try it

Connect an audio source (microphone or music), check that your webcam is connected and not in use by another software,
and open this example to see real-time audio-reactive graphics!

[Download this example]({{ site.scores }}/examples/video/camera.score)

## Learn more

- [[Analysis]] - Audio analysis processes (RMS, FFT, pitch, onset)
- [[Camera Device]] - Using camera input in ossia score.
- [[ISF Shaders]] - Interactive Shader Format effects
- [[Smooth]] - Signal smoothing for fluid animations
- [[Graphics pipeline]] - How the rendering system works
