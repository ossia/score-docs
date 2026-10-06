---
layout: default
title: "Layered analog-style effects"
description: "An example showing layered analog-style visuals made from procedural images."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/analog-effects.html
score: /examples/video/analog-effects.score
---

# Layered analog-style effects

This example demonstrates building layered, analog-style visuals from procedural images.

## Overview

Blur, film grain, pixel sorting and VHS distortion give two generated patterns contrasting textures. One treatment explores exposure, glow and tone mapping; the other recirculates earlier images to create an evolving feedback effect.

A smoothed modulation changes the balance between the fresh image and its processed history. Mixing the two treatments lets you move between cleaner patterns and a more heavily distressed result.

## Try it

Start playback and isolate each branch with the mixer's alpha controls before changing the effects. Compare Pixel Sort strength with VHS analog distortion; then adjust the smoothed Colour Distance progress to change the feedback's contribution. Keep the delayed feedback cable when rebuilding the loop.

All sources and shader code are stored in the score; no movie file is required. HDR Exposure and Tonemap process the generated image and do not require an external HDR movie.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
