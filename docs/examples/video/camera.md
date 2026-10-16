---
layout: default

title: Camera input
description: "Make a live camera image change colour, blur and distortion in response to sound."

parent: Video Examples
grand_parent: Examples

permalink: /examples/video/camera.html
score: /examples/video/camera.score
---

# Camera input

![Live camera processing with audio-controlled effects]({{ site.img }}/examples/video/camera.png "Camera input in ossia score")

Keep a performer or installation visitor visible while sound changes the colour, blur and distortion of their live image. Rather than generating an unrelated animation, this patch makes the treatment of the camera feed part of the performance.

## Two kinds of motion

Audio analysis turns microphone level into controls for the shader pipeline. Smoothing makes some changes gradual; peak detection resets the distortion on sharper accents. Movement in front of the camera changes the source picture, while sound changes what happens to it.

## Setup

Select an available camera in the Camera device settings and a working audio input in the audio settings. Grant camera permission where required and close applications that hold exclusive access to it.

## Try it

- Start playback and move silently in front of the camera, then make sound while staying still. Compare changes in the source image with changes in its treatment.
- Adjust RMS Gain to suit your input, then alter the smoothing to compare abrupt responses with lingering transitions.
- Change peak detection's trigger and reload thresholds. Try isolated claps followed by sustained sound and observe when the distortion resets.

Without a microphone, connect a sound-file process to RMS. The recording replaces the analysis source, not the camera.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Analysis]] - Audio analysis processes (RMS, FFT, pitch, onset)
- [[Camera Device]] - Using camera input in ossia score.
- [[ISF Shaders]] - Interactive Shader Format effects
- [[Smooth]] - Signal smoothing for fluid animations
- [[Graphics pipeline]] - How the rendering system works
