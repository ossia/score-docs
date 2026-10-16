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

A rotating duck becomes a graphic image of halftone dots and neon-like edges. These treatments respond to depth as well as colour, so distance becomes a design parameter rather than just a consequence of perspective.

The native renderer supplies the image and depth. Halftone uses that depth to vary the pattern; the following outline pass adds edges and glow. Both receive the matching camera buffer so they can interpret distances consistently.

## Try it

Open the ZIP directly in score; the duck is included. Start playback and change `dotsNear`, `dotsFar` and `depthScale` to compare the pattern across near and far parts of the scene. Then adjust the outline threshold or glow radius to separate edge detection from the glow around it.

An LFO already drives glow intensity. Change that modulation if you want a different pulse, rather than setting a value that the cable will overwrite. Keep the effects' camera buffer connected to the same scene that produces the image and depth.

The shaders are embedded but include `depth_helpers.glsl`. Install the `csf-examples` package with its `shaderlib/depth` directory intact so the helper resolves.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
