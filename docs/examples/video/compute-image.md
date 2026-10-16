---
layout: default
title: "Compute-rendered Clifford attractor"
description: "Draw a slowly changing Clifford attractor by accumulating GPU-generated points."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/compute-image.html
score: /examples/video/compute-image.score
---

# Compute-rendered Clifford attractor

![Slow modulation controlling an accumulating Clifford attractor image]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-compute-image.png)

An accumulating field of points reveals a Clifford attractor as its shape slowly changes. This gives you a visual source made from computation rather than footage or a mesh: the image records both the current mathematical form and traces of where it has been.

## Balance change and persistence

Slow LFOs vary the attractor parameters while the compute shader draws points into the image. Brightness shapes their visibility, and fading determines how much of the earlier drawing remains. The balance between modulation and persistence determines whether you perceive a distinct form or a layered history.

## Try it

- Start playback and observe a full sweep of the slow modulation before changing it. Alter the LFOs rather than manually adjusting an inlet they already drive.
- Compare brightness and `fadeRate`: make the new points more visible, then change how quickly the old ones disappear.
- Change `pointsPerThread` and compare the drawing density with responsiveness. More work is not automatically a more useful image.

Use a graphics backend with compute support. No external image or geometry is needed; this patch is a visual experiment, not a performance benchmark.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
