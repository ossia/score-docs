---
layout: default
title: "Depth halftone and neon outlines"
description: "Turn a lit 3D model into distance-dependent halftone patterns and glowing outlines."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-depth-effects.html
score: /examples/3d/scene-depth-effects.zip
---

# Depth halftone and neon outlines

A rotating duck becomes a graphic image of halftone dots and neon-like edges. Both treatments respond to depth as well as color, so the pattern changes with distance from the camera.

The native renderer supplies the image and depth. Halftone uses that depth to vary the pattern; the following outline pass adds edges and glow. Both receive the matching camera buffer so they can interpret distances consistently.

## Try it

Open the ZIP directly in score; the duck is included. Start playback and change `dotsNear`, `dotsFar` and `depthScale` to make the dots differ more between near and far parts of the duck. Then raise the outline threshold to keep fewer edges, or the glow radius to widen the glow around them.

An LFO already drives glow intensity. For a different pulse, change that modulation: a value set by hand is overwritten by the cable. Keep the effects' camera buffer connected to the same scene that produces the image and depth.

The shaders are embedded but include `depth_helpers.glsl`. Install the `csf-examples` package with its `shaderlib/depth` directory intact so the helper resolves.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
