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

Turn a live camera feed into visibly damaged imagery while keeping the original beside it for comparison. Three Bendage treatments expose different ways to break up the same picture, useful when choosing a glitch vocabulary for a performer or installation visitor.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/cpu-data-bending.score)

## Try it

Install the Bendage add-on, select an available camera in the Camera device settings, and grant capture permission where required. Start playback to compare JPeg, Safe Word and Xlippy with the original image.

Move in front of the camera and watch how the same gesture survives or disappears in each treatment. Adjust an undriven effect control manually to establish its character, then change the LFO frequency to compare slow deformation with rhythmic disturbance. Micromaps set how far that modulation travels through the effect controls; narrowing their ranges can preserve more of the source image.

These effects process images on the CPU, so keep the input resolution modest. Without a camera, connect a movie or generated texture to all three effects and Grid's first input so the comparison still uses one shared source.
