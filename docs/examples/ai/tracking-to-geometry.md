---
layout: default
title: Face tracking to native geometry
description: "Upload tracked XY coordinates to a GPU buffer and render a particle trail over the camera image."
parent: AI and tracking
grand_parent: Examples
permalink: /examples/ai/tracking-to-geometry.html
score: /examples/ai/tracking-to-geometry.score
---

# Face tracking to native geometry

![Tracked facial landmarks over a camera image with Array to buffer, ParticleTrail and SphereSplat processes]({{ site.baseurl }}/assets/scores/thumbnails/examples-ai-tracking-to-geometry.png)

Upload tracked XY coordinates to a GPU buffer and render a particle trail over the camera image.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/ai/tracking-to-geometry.score)

## Setup

Use score with ONNX/Pose Detector support and a compute-capable graphics backend. Install a [LivePose model pack](https://github.com/sat-mtl/livepose/releases/tag/model-storage) in the user library and restart score. The saved Landmark Model is `packages/models-presets/models/pose-detector/detectors/det-face-retinaface-mobile-640x480.onnx`; update it if your package layout differs. This is face tracking, not a body-pose preset.

The camera device is named `Logitech BRIO`, saved with Linux `/dev/video0`, 1280×720 at 30 fps. Select your own camera while retaining the device name, or rebind the detector's `Logitech BRIO:/` input.

## Trace the graph

Pose Detector's Geometry output feeds Point2D View and a OneEuro Smooth filter. Arraymap applies `50(x-0.5)` to recenter and enlarge the coordinates. Array to buffer uploads Float32 values for ParticleTrail, whose compute shader writes positions into a circular GPU geometry buffer. SphereSplat renders camera-facing sphere impostors, and Video Mixer combines that image with the annotated camera texture at `Window:/`.

This is score's native Compute Shader / Render Pipeline path, not Qt Quick 3D. Adjust startSize, tailColor and SphereSplat's cameraPos to change the trail's appearance.

## Match the buffer to the detector

The saved patch needs its particle-count settings adapted to the selected model. ParticleTrail is saved with `newPointCount=762`, while Counter advances writeHead through the Micromap `42x`; neither value is derived from the incoming array. The shader reads one XY pair for each new point, so those constants do not match a five-landmark RetinaFace output.

Before relying on the visual result, set newPointCount to the number of XY pairs actually supplied and change the write-head multiplier to the same number (five for one five-keypoint face). maxParticles is 2048; totalWritten is saved at 2048, treating the ring as already full. A different detector or multi-person geometry output needs its own count handling. With coherent buffer counts, moving the detected face supplies new points to the trail rather than reading beyond its input.
