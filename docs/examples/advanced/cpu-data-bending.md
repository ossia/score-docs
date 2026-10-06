---
layout: default
title: CPU data bending
description: "An example showing video glitch effects with the Bendage toolkit"
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/cpu-data-bending.html
score: /examples/advanced/cpu-data-bending.score
---

# CPU data bending

This example demonstrates image degradation with the Bendage effects. A side-by-side comparison lets you explore different ways of distorting the same camera image.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/cpu-data-bending.score)

## Try it

Install the Bendage add-on, select a working camera for the Camera device, and start playback. The output shows JPeg, Safe Word and Xlippy alongside the original image.

Move in front of the camera and compare the effects. Try their controls manually, then change the LFO frequency to see how periodic modulation changes the distortion. Adjust the Micromaps if you want the modulation to cover a different range.

These effects process images on the CPU; keep the input resolution modest. Without a camera, connect a video-file or shader texture to all three effects and Grid's first input. No external video is bundled.
