---
layout: default
title: "Delayed shader texture feedback"
description: "An example showing an evolving light trail created with texture feedback."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/shader-texture-feedback.html
score: /examples/video/shader-texture-feedback.score
---

# Delayed shader texture feedback

![A glowing curved dot trail above the connected DotTrail, VHS Glitch, Twirl and Passthrough processes]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-shader-texture-feedback.png)

This example demonstrates creating a moving light trail with texture feedback.

## Overview

Each frame carries traces of the previous image. Twirling and analog-style distortion are applied again as the image recirculates, turning a simple moving dot into an evolving pattern. Bloom gives the displayed trail a glow without accumulating inside the feedback loop.

## Try it

Start playback and move Twirl's amount toward zero to compare strong recursive warping with a straighter trail. Adjust DotTrail decay to change persistence and speed to change the moving source. Bloom is outside the feedback loop: its intensity affects the displayed image without being accumulated on the next frame.

No video file or camera is required; the dot source and all shader code are embedded. Preserve the delayed cable from Passthrough to DotTrail when rebuilding this graph, rather than creating an immediate cycle.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
