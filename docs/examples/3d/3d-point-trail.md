---
layout: default
title: "GPU point trail"
description: "Draw a three-dimensional path by retaining and rendering the recent history of a moving point."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/3d-point-trail.html
score: /examples/3d/3d-point-trail.score
---

# GPU point trail

![Orange and magenta sphere-splat trail above the XYZ, Trail and SphereSplat process chain.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-3d-point-trail.png)

A moving point leaves a three-dimensional trail, with a bright head and a differently colored, tapering tail that shows where the point has just been.

A mathematical expression supplies XYZ positions. Trail appends them to a GPU buffer, and a sphere-splat renderer gives each sample a visible size and color. The history belongs to the geometry, so the camera can view the trail from another angle.

## Try it

Start playback and lower `maxParticles`: the trail gets shorter. Make `startSize` larger than `endSize` so the head stands out from the tail, then toggle `trailFade` to switch between a fading and a uniform trail. Use Vec3f to change the camera position independently of the path.

The saved motion is procedural: no sensor or external file is required. As an adaptation, feed a recorded or live three-component position stream into Trail's `point3D` input; you will need to configure that source yourself. The native rendering chain requires compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
