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

Build a moving image that shifts between clean patterns, glowing highlights and distressed video textures. Two procedural sources receive different treatments, letting you explore an analog-style visual vocabulary without starting from camera footage.

## Fresh patterns and image history

One branch shapes exposure, glow and tone mapping; the other sends processed images back into its own history. Blur, grain, pixel sorting and VHS distortion alter the patterns along the way. Smoothed modulation changes the balance between a fresh image and its processed past, and the final mixer combines the two branches.

That separation makes the patch useful for developing contrasting visual states: you can work on each treatment independently before bringing them together.

## Try it

- Start playback and isolate each branch with the mixer's alpha controls. Compare the treatment of the current pattern with changes that accumulate through feedback.
- Adjust Pixel Sort strength, then VHS analog distortion, to distinguish rearranged pixels from video-like instability.
- Change the smoothed Colour Distance progress to alter the feedback contribution. Watch several frames before judging the result: recirculation makes a change develop over time.

No movie is required, including for HDR Exposure and Tonemap. Preserve the delayed feedback cable when adapting the loop so that it uses an earlier frame rather than an immediate cycle.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
