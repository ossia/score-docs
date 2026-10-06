---
layout: default
title: "GPU point trail"
description: "An example showing how to draw a trail from a moving 3D position."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/3d-point-trail.html
score: /examples/3d/3d-point-trail.score
---

# GPU point trail

![Orange and magenta sphere-splat trail above the XYZ, Trail and SphereSplat process chain.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-3d-point-trail.png)

This example demonstrates drawing a 3D trail from a moving position.

## Overview

A mathematical expression supplies the motion, and a GPU buffer retains its recent history. Sphere splats turn those positions into a visible trail whose head and tail can have different colours and sizes. This is useful for exploring motion over time rather than showing only an object's current position.

## Try it

Start playback and follow the trail as points accumulate. Change `maxParticles` to adjust its history, then compare `trailFade`, `startSize` and `endSize`. The Vec3f process controls the renderer's camera position independently of the trail.

No external file or sensor is required. To explore recorded or live motion instead, supply your own three-component position stream to Trail's `point3D` input. No OSC sensor device is preconfigured. This example requires compute-shader support and uses native rendering.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
