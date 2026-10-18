---
layout: default
title: CPU data bending
description: "Compare three distressed versions of a live camera image with their untouched source."
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/cpu-data-bending.html
score: /examples/advanced/cpu-data-bending.score
---

# CPU data bending

Turn a live camera feed into visibly damaged imagery while keeping the original beside it for comparison. Three Bendage treatments break up the same picture in different ways.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/cpu-data-bending.score)

## Try it

Install the Bendage add-on, select an available camera in the Camera device settings, and grant capture permission where required. Start playback: JPeg, Safe Word and Xlippy appear next to the original image.

Move in front of the camera: your movement stays readable in some treatments and disappears in others. Adjust an undriven effect control by hand, then lower the LFO frequency for slow deformation or raise it for rhythmic disturbance. Micromaps set how far that modulation travels through the effect controls; narrowing their ranges can preserve more of the source image.

These effects process images on the CPU, so keep the input resolution modest. Without a camera, connect a movie or generated texture to all three effects and Grid's first input so the comparison still uses one shared source.
