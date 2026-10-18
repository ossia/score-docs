---
layout: default
title: "Layered analog-style effects"
description: "Mix distressed procedural patterns with glowing highlights and recirculating image history."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/analog-effects.html
score: /examples/video/analog-effects.score
---

# Layered analog-style effects

Build a moving image that shifts between clean patterns, glowing highlights and distressed video textures. Two procedural sources receive different treatments; no camera footage is needed.

## Two branches

One branch shapes exposure, glow and tone mapping; the other sends processed images back into its own history. Blur, grain, pixel sorting and VHS distortion alter the patterns along the way. Smoothed modulation changes the balance between a fresh image and its processed past, and the final mixer combines the two branches, so each treatment can be developed on its own.

## Try it

- Start playback and isolate each branch with the mixer's alpha controls: one treats only the current pattern, the other accumulates changes through feedback.
- Adjust Pixel Sort strength to rearrange pixels into streaks, then VHS analog distortion to add tape-like wobble and noise.
- Change the smoothed Colour Distance progress to alter the feedback contribution. Watch several frames before judging the result: recirculation makes a change develop over time.

No movie is required, including for HDR Exposure and Tonemap. Preserve the delayed feedback cable when adapting the loop so that it uses an earlier frame instead of an immediate cycle.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
