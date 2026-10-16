---
layout: default
title: "Delayed shader texture feedback"
description: "Turn a moving dot into a glowing trail by repeatedly warping its previous image."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/shader-texture-feedback.html
score: /examples/video/shader-texture-feedback.score
---

# Delayed shader texture feedback

![A glowing curved trail built from the previous frame's image]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-shader-texture-feedback.png)

A moving dot leaves a trail that twists and distorts as its earlier image returns. This is a compact way to build evolving visual material: a simple source becomes complex because each frame inherits the marks made before it.

## What accumulates?

The delayed texture connection brings the previous image back into DotTrail. Twirl and analog-style distortion act again on that history as it recirculates. Bloom is applied only after the feedback loop, so it adds glow to the displayed result without being accumulated on the next frame.

## Try it

- Start playback and move Twirl's amount toward zero. Compare recursive warping with the path left by the moving source itself.
- Change DotTrail decay to compare a brief trace with a longer visual memory; change speed to alter how much distance the source covers during that memory.
- Adjust Bloom intensity and compare its immediate glow with a change made inside the loop, which develops through repeated frames.

No movie or camera is needed. Preserve the delayed cable from Passthrough to DotTrail when rebuilding the graph; an immediate connection does not provide the previous-frame history.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
