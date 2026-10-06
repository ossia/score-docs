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

![LFO and expression generator controlling the Object loader and Model Display point-cloud rendering chain.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-point-cloud.png)

This example shows a 3D model as a cloud of points rather than a solid surface. A rotating bunny and motion blur let you explore how points suggest a shape.

**Object loader** reads the bundled `Files/bunny.ply`, and **Model Display** renders its vertices as points. An LFO and expression rotate the model around its vertical axis; VVMotionBlur 3.0 adds trails to the image shown in `Window:/`.

## Try it

Open the ZIP directly in score and start playback. Reduce blur to inspect individual points; change the LFO rate to alter the rotation period. Disconnect the rotation cable and set a fixed rotation to compare the point structure from one viewpoint.

This is a native geometry/Model Display example, not a Qt Quick 3D particle scene or a Gaussian-splat renderer. The PLY file is supplied; no external model package is required. See [[Model display]].

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

