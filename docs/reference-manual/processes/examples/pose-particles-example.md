---
layout: default
title: "Pose-driven Particle Shader"
description: "Extract a tracked keypoint coordinate and use it as a shader control."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/ai-recognition.html
score: "/reference/processes/ai-recognition.zip"
---

# Pose-driven Particle Shader

The bundled jumping-jacks video feeds **Blaze Pose**, configured with `Files/pose_landmark_full.onnx`, 256 × 256 model input and minimum confidence 0.5. Its texture output goes to `Window_input:/`; its Detection output goes to **Object filter**.

The query `[ .keypoints[15].position[0]]` selects the first position coordinate of keypoint 15 and wraps it in an array. The result is displayed numerically, plotted, and passed through Exp Smoothing (alpha about 0.035) to ParticleZoom's Tau control. ParticleZoom writes to `Window_output:/`. A separate Range Filter → Value display branch has no input cable in the saved graph; it is not part of the pose-control path.

## Try it

Open the ZIP directly in score. It includes `Files/pose_landmark_full.onnx` and `Video/4859226-uhd_3840_2160_25fps.mp4`. This example requires the ONNX/Blaze Pose and Object filter add-ons. Start playback, show both Window outputs, and compare the plotted coordinate with the particle shader. Increase smoothing alpha for a faster response or decrease it for a slower one.

This example uses prerecorded video, not a configured live camera. The ParticleZoom shader divides an angle by Tau, so a zero control value is a problematic input rather than a meaningful pose effect. Inspect or remap the detected range when adapting the graph. See [[AI Recognition]].

[Download this example]({{ site.scores }}{{ page.score }})
