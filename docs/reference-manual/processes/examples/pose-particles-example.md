---
layout: default
title: "Pose-driven Particle Shader"
description: "Turn a tracked body coordinate into a smoothed control for a particle animation."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/ai-recognition.html
score: "/reference/processes/ai-recognition.zip"
---

# Pose-driven Particle Shader

![Blaze Pose detection connected to an Object filter keypoint query and exponential smoothing before the particle shader.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-ai-recognition.png)

A person's jumping-jack movements reshape a particle animation. The video, tracking trace and shader output let you follow the translation from a recognisable physical gesture to an abstract visual response—a starting point for movement-led performance visuals.

**Blaze Pose** estimates body landmarks from the video. **Object filter** extracts one coordinate, and exponential smoothing reduces abrupt changes before the value reaches the particle shader's Tau control. The important step is reducing a whole pose to one usable control, then choosing how quickly the visual should follow it.

## Try it

Open the ZIP directly in score; the video and pose model are included. The ONNX/Blaze Pose and Object filter add-ons are required. Start playback and show both Window outputs, then compare the tracked coordinate with the particle image.

Increase the smoothing Alpha for a quicker response to movement, or decrease it for a slower, more fluid response. To try another tracked coordinate, edit the Object filter query, initially `[ .keypoints[15].position[0]]`, and compare the trace before judging the visual result.

This patch uses prerecorded video; a live camera would be an adaptation. Before changing the tracking source or coordinate, remap its range away from zero: the shader divides an angle by Tau. The disconnected Range Filter does not currently protect that input. See [[AI Recognition]].

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

