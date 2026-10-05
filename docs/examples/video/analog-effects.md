---
layout: default
title: "Layered analog-style effects"
description: "Combine procedural sources, HDR processing and delayed texture feedback."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/analog-effects.html
score: /examples/video/analog-effects.score
---

# Layered analog-style effects

Two branches meet at Video Mixer. The curve-1 Vertex Shader Art branch passes through Gaussian Blur, HDR Exposure, Film Grain, Pixel Sort, Bloom, a second grain pass and Tonemap. The Trigonometric2 branch enters Colour Distance, VHS Glitch and another Pixel Sort, then blur and grain.

The second Pixel Sort also feeds Colour Distance's endImage through a delayed cable. A sample-and-hold LFO and Exp Smoothing control the blend progress, so each frame mixes a fresh procedural image with a processed previous frame.

## Try it

Start playback and isolate each branch with the mixer's alpha controls before changing the effects. Compare Pixel Sort strength with VHS analog distortion; then adjust the smoothed Colour Distance progress to change the feedback's contribution. Keep the delayed feedback cable when rebuilding the loop.

The final output is `Window:/`. All sources and shader code are procedural and stored in the score; no movie file is required. HDR Exposure and Tonemap are image-processing stages, not a requirement for an external HDR movie.

[Download this example]({{ site.scores }}{{ page.score }})
