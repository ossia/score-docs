---
layout: default

title: Camera input
description: "An example showing how to use camera input"

parent: Video Examples
grand_parent: Examples

permalink: /examples/video/camera.html
score: /examples/video/camera.score
---

# Camera input

![Camera Example]({{ site.img }}/examples/video/camera.png "Camera input in ossia score")

This example demonstrates modifying live video input on the GPU with a simple audio-reactive ISF shader pipeline.

## Overview

`Camera:/` feeds Color Blowout → Edge Blur → Optical Flow Distort → `Window:/`. RMS reads `audio:/in/main`. Micromap scales its values, and OneEuro smoothing controls colour intensity, blur amount and distortion amount. Peak detection sends Peak max to Optical Flow Distort's reset input.

## Inputs and controls

Select an available camera in the Camera device settings and a working audio input in the audio settings. Grant camera permission where required and close applications that hold exclusive access to it. No external movie is needed.

Adjust RMS Gain to suit the input before changing the mapping expressions. Compare the direct RMS-to-Edge Blur intensity path with the smoothed controls, then change Peak detection's trigger/reload thresholds to alter when distortion resets.

## Try it

Start playback and make sound while moving in front of the camera. The camera image should remain the source while the audio changes its treatment. If no microphone is available, connect a sound-file process to RMS instead; this does not replace the camera input.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Analysis]] - Audio analysis processes (RMS, FFT, pitch, onset)
- [[Camera Device]] - Using camera input in ossia score.
- [[ISF Shaders]] - Interactive Shader Format effects
- [[Smooth]] - Signal smoothing for fluid animations
- [[Graphics pipeline]] - How the rendering system works
