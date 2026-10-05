---
layout: default
title: "GPU point trail"
description: "Accumulate a moving 3D position into a GPU trail and render sphere splats."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/3d-point-trail.html
score: /examples/3d/3d-point-trail.score
---

# GPU point trail

![Orange and magenta sphere-splat trail above the XYZ, Trail and SphereSplat process chain.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-3d-point-trail.png)

An XYZ expression generates a moving three-component value. Arraymap scales it with `100(x-0.5)` before feeding the Trail compute shader's `point3D` input. Trail maintains up to 2048 particles, with separate head and tail colours and sizes. SphereSplat renders that geometry to `Window:/` through the native Render Pipeline, not Qt Quick 3D.

## Try it

Start playback and follow the trail as points accumulate. Change `maxParticles` to adjust its history, then compare `trailFade`, `startSize` and `endSize`. The Vec3f process controls the renderer's camera position independently of the trail.

No external file or sensor is required: the expression supplies the position. To use a sensor, replace the Arraymap-to-`point3D` connection with your own three-component position stream; no OSC sensor device is preconfigured. This example requires compute-shader support in the graphics backend.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
