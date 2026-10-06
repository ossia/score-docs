---
layout: default
title: Face tracking to native geometry
description: "An example showing how to create visual trails from motion tracking"
parent: AI and tracking
grand_parent: Examples
permalink: /examples/ai/tracking-to-geometry.html
score: /examples/ai/tracking-to-geometry.score
---

# Face tracking to native geometry

![Tracked facial landmarks over a camera image with Array to buffer, ParticleTrail and SphereSplat processes]({{ site.baseurl }}/assets/scores/thumbnails/examples-ai-tracking-to-geometry.png)

This example demonstrates turning tracked movement into a particle trail. Facial landmarks supply positions for a visual trace combined with the camera image, connecting live movement with generated geometry.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/ai/tracking-to-geometry.score)

## Setup

Use score with ONNX/Pose Detector support and a compute-capable graphics backend. Install a [LivePose model pack](https://github.com/sat-mtl/livepose/releases/tag/model-storage) in the user library and restart score. The saved Landmark Model is `packages/models-presets/models/pose-detector/detectors/det-face-retinaface-mobile-640x480.onnx`; update it if your package layout differs. This is face tracking, not a body-pose preset.

The saved camera device is named `Logitech BRIO`. Select your own camera while retaining that name, or rebind the detector's `Logitech BRIO:/` input.

## Overview

Tracked positions are smoothed, recentered and uploaded for a GPU particle trail. The trail retains earlier positions so that movement can leave a visible history instead of only marking the current landmark locations.

This uses score's native Compute Shader and Render Pipeline processes, not Qt Quick 3D. Once the buffer counts below match your detector, try moving slowly and quickly, then adjust startSize, tailColor and SphereSplat's cameraPos to change the trace's appearance.

## Match the buffer to the detector

The saved patch needs its particle-count settings adapted to the selected model. ParticleTrail is saved with `newPointCount=762`, while Counter advances writeHead through the Micromap `42x`; neither value is derived from the incoming array. The shader reads one XY pair for each new point, so those constants do not match a five-landmark RetinaFace output.

Before relying on the visual result, set newPointCount to the number of XY pairs actually supplied and change the write-head multiplier to the same number (five for one five-keypoint face). maxParticles is 2048; totalWritten is saved at 2048, treating the ring as already full. A different detector or multi-person geometry output needs its own count handling. With coherent buffer counts, moving the detected face supplies new points to the trail rather than reading beyond its input.
