---
layout: default
title: "Rotating PLY Point Cloud"
description: "Use rotation and image trails to make a cloud of vertices read as a three-dimensional form."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/point-cloud.html
score: "/reference/processes/point-cloud.zip"
---

# Rotating PLY Point Cloud

![LFO and expression generator controlling the Object loader and Model Display point-cloud rendering chain.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-point-cloud.png)

A bunny appears as scattered points instead of a solid skin. As it rotates, the points reveal the model's depth, while image trails soften its outline.

**Object loader** supplies the model's vertices and **Model Display** draws them as points. A repeating ramp becomes a full rotation around the vertical axis. Motion blur combines the new image with earlier frames, giving the points a visible history.

## Try it

Open the ZIP directly in score, start playback and show the Window output. The model is included. Lower the motion-blur amount to distinguish individual points from their trails, then increase the LFO rate: with the same blur setting, faster rotation leaves longer trails.

Disconnect the rotation cable and set a fixed angle to inspect the shape without movement. Reconnecting it shows how motion helps the eye reconstruct volume. This uses score's native geometry renderer; see [[Model display]].

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

