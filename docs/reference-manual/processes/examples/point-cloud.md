---
layout: default
title: "Rotating PLY Point Cloud"
description: "Display the vertices of a bundled bunny model as points."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/point-cloud.html
score: "/reference/processes/point-cloud.zip"
---

# Rotating PLY Point Cloud

**Object loader** reads `<PROJECT>:Files/bunny.ply` and sends it to **Model Display**, saved in point rendering mode. A saw LFO drives parameter `a` of Expression Value Generator, whose `return [0, -360a,0];` expression rotates the model about its vertical axis. VVMotionBlur 3.0 processes the image before `Window:/`.

## Try it

Open the ZIP directly in score and start playback. Reduce blur to inspect individual points; change the LFO rate to alter the rotation period. Disconnect the rotation cable and set a fixed rotation to compare the point structure from one viewpoint.

This is a native geometry/Model Display example, not a Qt Quick 3D particle scene or a Gaussian-splat renderer. The PLY file is supplied; no external model package is required. See [[Model display]].

[Download this example]({{ site.scores }}{{ page.score }})
