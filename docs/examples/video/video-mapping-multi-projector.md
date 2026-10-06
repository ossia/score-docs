---
layout: default
title: "Multi-projector output mapping"
description: "An example showing how to align and blend one image across several displays."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/video-mapping-multi-projector.html
score: /examples/video/video-mapping-multi-projector.score
---

# Multi-projector output mapping

This example demonstrates distributing one animated image across several displays or projectors.

## Overview

The Window device's Multi-window mode divides a procedural texture into output regions. Each region can be positioned, warped and edge-blended to suit a projection surface. The mapping takes place at the output, so the same approach can be used with other video sources or a composed image.

## Try it

Open the Window device settings before playback and assign each output to a screen available on your machine. The saved desktop positions and screen indices describe the author's setup, not your projector arrangement. Use the device's test cards to align the source regions. Double-click a region to edit its perspective transform and the dashed border controls to adjust edge blending.

Start playback to compare the animated source across the configured outputs. Adjacent projectors need appropriately overlapping source regions and physically aligned images for useful blending. Additional outputs and larger render sizes increase GPU and display-system requirements; the example does not promise unlimited outputs.

No external image or video is required. Window output mapping is independent of Qt Quick 3D; it can also receive the composed texture from the rectangle-mapping example.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
