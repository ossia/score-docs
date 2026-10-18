---
layout: default
title: "Multi-projector output mapping"
description: "Align and edge-blend one moving image across several projectors or displays."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/video-mapping-multi-projector.html
score: /examples/video/video-mapping-multi-projector.score
---

# Multi-projector output mapping

Extend one animated image across several displays or projectors, then align the portions so they read as a continuous composition. The image is composed first; the mapping only fits it to the physical displays.

## Output mapping

The Window device's Multi-window mode divides a procedural texture into output regions. Each region can be positioned, warped and edge-blended independently. Because this happens at the output, the source could instead be a movie or a texture composed with the rectangle mapper.

## Set up your displays

Before playback, open the Window device settings and assign each output to a screen on your machine. Replace the saved desktop positions and screen indices with your own arrangement.

Use the device's test cards to align the source regions. Double-click a region to edit its perspective transform; use the dashed border controls to adjust edge blending. Adjacent projections need both overlapping source regions and physically aligned images: a soft edge alone cannot repair a misaligned projection.

## Try it

Start playback and follow a feature of the animated source across the configured outputs. Adjust one region's perspective until the feature lines up across the seam, then its blend border until the overlap is no brighter than its surroundings.

No external media or Qt Quick 3D is required. More outputs and larger render sizes increase GPU and display-system requirements; establish a working alignment at a modest resolution before increasing it.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
