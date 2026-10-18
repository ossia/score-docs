---
layout: default
title: Face tracking to native geometry
description: "Leave a particle trace of facial movement by turning tracked positions into GPU geometry."
parent: AI and tracking
grand_parent: Examples
permalink: /examples/ai/tracking-to-geometry.html
score: /examples/ai/tracking-to-geometry.zip
---

# Face tracking to native geometry

![Facial tracking over a camera image alongside the particle-trail rendering controls]({{ site.baseurl }}/assets/scores/thumbnails/examples-ai-tracking-to-geometry.png)

Facial landmarks feed a particle renderer that draws the recent path of your head, and the trace is mixed with the camera image. Match the particle settings to the detector first, as described below.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/ai/tracking-to-geometry.zip)

## Setup

Open the ZIP directly in score; it includes the RetinaFace model selected by the patch. Use a build with ONNX/Pose Detector support and a compute-capable graphics backend. The model tracks faces, not whole bodies. Other models are available in the [LivePose model pack](https://github.com/sat-mtl/livepose/releases/tag/model-storage), but changing the model also means checking the number of points supplied to the renderer.

Select your camera in the saved `Logitech BRIO` device, retaining its name so that the detector stays connected. Alternatively, rebind the detector's camera input. Grant camera access if prompted and check the point display before troubleshooting the trail.

## From positions to a trace

The detector supplies normalized positions. Smoothing reduces small fluctuations, and a mapping recenters and enlarges the coordinates before uploading them to the GPU. A compute shader keeps a circular history of points; the renderer turns that history into visible particles, so the image shows past positions as well as the current one.

Once the counts below are coherent, move your head slowly, then sweep it quickly: a quick sweep spreads the same number of marks over a longer path. Adjust ParticleTrail's startSize to change the weight of the marks and tailColor to set the color of older parts of the trail. Changing SphereSplat's cameraPos changes the viewpoint of the generated geometry, not the physical camera.

## Match the buffer to the detector

**The saved particle counts need adjustment before use.** ParticleTrail expects `newPointCount=762`, while the counter's Micromap advances the write position by `42x`. Neither follows the incoming array automatically; these values do not match a single face with five landmarks.

Set newPointCount to the actual number of XY pairs and change the write-head multiplier to that same number: five for one five-keypoint face. Otherwise the shader can read past the supplied positions. Keep the test to a stable, single-face input while making this adjustment; a detector with a variable number of points needs corresponding count handling.

The history holds 2048 particles, and totalWritten is saved at 2048, treating it as full from the start. These are history settings, not the number of landmarks. A longer history preserves more of the past; more points per update add more marks for each new detection.
