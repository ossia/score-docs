---
layout: default
title: "Audio-reactive volume"
description: "Control a raymarched Menger volume with the audio envelope."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/audioreactive-volumetric.html
score: /examples/3d/audioreactive-volumetric.score
---

# Audio-reactive volume

![Green raymarched volume behind the RMS, smoothing, Menger SDF and orbit raymarch processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-audioreactive-volumetric.png)

The Menger SDF compute shader generates a three-dimensional texture. An ISF orbit raymarch shader turns that volume into an image: no polygon mesh or Qt Quick 3D scene is involved. RMS reads `audio:/in/main`, and Exp Smoothing drives the raymarcher's density. Two slow sawtooth LFOs control yaw and pitch.

## Try it

Enable an audio input and start playback. Sound changes the apparent density while the view keeps orbiting. Adjust RMS Gain before changing the smoothing Alpha. Compare density changes with the Menger shader's `iters` and `zoom`, which change the volume itself.

There is no bundled audio file; connect a sound-file process to RMS if needed. The shaders are saved in the score and require compute-shader support. The raymarch output goes directly to `Window:/`.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
