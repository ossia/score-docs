---
layout: default
title: Face landmarks and radial blur
description: "An example showing how to control video effects with face tracking"
parent: AI and tracking
grand_parent: Examples
permalink: /examples/ai/pose-detection.html
score: /examples/ai/pose-detection.score
---

# Face landmarks and radial blur

![Facial keypoint filters connected to a radial blur over the camera image]({{ site.baseurl }}/assets/scores/thumbnails/examples-ai-pose-detection.png)

This example demonstrates using face tracking to control a video effect. Facial landmarks provide positions that can be inspected as data and used to make an image respond to movement.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/ai/pose-detection.score)

## Requirements and setup

This document's name is pose-detection, but its saved model is RetinaFace 5-kpt: face boxes and five facial landmarks, not a full-body skeleton. Install score's ONNX/Pose Detector support and the [LivePose model pack](https://github.com/sat-mtl/livepose/releases/tag/model-storage) in your score user library, then restart score. Select the model matching `packages/pose-detector/detectors/det-face-retinaface-mobile.onnx`, or update Landmark Model to its actual extracted location. GPU inference additionally depends on the acceleration libraries supported by your score build; model installation alone does not provide those libraries.

Select a working camera for `Camera:/`, start playback, and face the camera. The output shows the annotated camera image with radial blur. The accompanying displays let you inspect detected positions and the number of faces found.

## Try it

Move your head and watch the blur's center follow your nose. Increase the blur amount to make the relationship more apparent, then try selecting another landmark in the Object filter.

The nose is the third, zero-indexed landmark: the filter uses `.keypoints[2]` and flips its vertical coordinate to match the effect's coordinates. A separate plot shows the first landmark's horizontal movement. Comparing these views helps when mapping tracking data into another visual control.

If the camera image appears but values do not change, check the model path and detection count before editing the filters. The Object filter process requires the Jk data-query add-on.
