---
layout: default
title: "Audio-reactive volume"
description: "Make a raymarched fractal appear denser with sound while its viewpoint slowly orbits."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/audioreactive-volumetric.html
score: /examples/3d/audioreactive-volumetric.score
---

# Audio-reactive volume

![Green raymarched volume behind the RMS, smoothing, Menger SDF and orbit raymarch processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-audioreactive-volumetric.png)

A green fractal volume becomes more or less dense-looking with the audio envelope while the viewpoint slowly orbits. Use this patch to explore a sound-reactive image that changes through the way a volume is viewed, rather than through mesh deformation.

A compute shader generates a Menger fractal as a three-dimensional texture. The viewer samples that texture along viewing rays to form the image. Smoothed RMS level drives the viewer's density, while two LFOs drive its viewing angles; the audio does not regenerate the fractal's structure.

## Try it

Enable a working audio input, allow microphone access if prompted, and start playback. Adjust RMS Gain until sounds give a useful density range, then change smoothing Alpha to compare quick and lingering responses.

Change the Menger generator's `iters` or `zoom` separately. These alter the volume being sampled, whereas the audio changes its apparent density in the viewer. No audio file is bundled; connect a sound-file process to RMS if needed. The embedded volume generator requires compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
