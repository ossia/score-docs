---
layout: default
title: "Pose-driven Particle Shader"
description: "Use movement in a video to animate a particle shader."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/ai-recognition.html
score: "/reference/processes/ai-recognition.zip"
---

# Pose-driven Particle Shader

![Blaze Pose detection connected to an Object filter keypoint query and exponential smoothing before the particle shader.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-ai-recognition.png)

This example turns body movement into a visual control. **Blaze Pose** tracks a person doing jumping jacks, and one detected coordinate changes a particle shader. You can compare the original video, the tracked movement and the resulting animation.

**Object filter** selects the first position coordinate of keypoint 15 with `[ .keypoints[15].position[0]]`. Exp Smoothing softens the movement before it reaches ParticleZoom's Tau control. Its alpha starts at about 0.035. The separate Range Filter branch is unconnected and does not control the effect.

## Try it

Open the ZIP directly in score. It includes `Files/pose_landmark_full.onnx` and `Video/4859226-uhd_3840_2160_25fps.mp4`. This example requires the ONNX/Blaze Pose and Object filter add-ons. Start playback, show both Window outputs, and compare the plotted coordinate with the particle shader. Increase smoothing alpha for a faster response or decrease it for a slower one.

This example uses prerecorded video, not a configured live camera. The ParticleZoom shader divides an angle by Tau, so a zero control value is a problematic input rather than a meaningful pose effect. Inspect or remap the detected range when adapting the graph. See [[AI Recognition]].

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

