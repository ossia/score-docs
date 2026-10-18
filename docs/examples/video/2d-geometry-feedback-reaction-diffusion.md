---
layout: default
title: "Reaction-diffusion geometry feedback"
description: "Grow organic patterns by feeding a GPU reaction-diffusion simulation back into itself."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/2d-geometry-feedback-reaction-diffusion.html
score: /examples/video/2d-geometry-feedback-reaction-diffusion.score
---

# Reaction-diffusion geometry feedback

![Organic reaction-diffusion patterns displayed as colored circles]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-2d-geometry-feedback-reaction-diffusion.png)

Organic patterns emerge from two simulated chemical concentrations spreading and reacting across a field. The changing concentrations are rendered as colored circles and never settle into a fixed loop.

## How the simulation runs

The simulation stores its concentrations in geometry buffers. Diffusion spreads them, reaction changes their balance, and a delayed connection carries the resulting state into the next frame. The displayed image is a view of that state, not the material fed back into the simulation.

## Try it

- Start playback and change `feed` and `kill`: small changes switch the pattern between spots, stripes and labyrinths. Press RD_Init's `reset` between experiments to regrow from a fresh field.
- Change `diffU` and `diffV` separately; their ratio sets the scale of the structure.
- If changing grid width, keep RD_Init and RD_Diffuse consistent; both start at 128. A larger field also means more simulation work.

Use a graphics backend with compute-shader support. No input image is needed; keep the delayed geometry connection when adapting the simulation.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
