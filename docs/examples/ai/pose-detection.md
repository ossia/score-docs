---
layout: default
title: Face landmarks and radial blur
description: "Make radial blur follow your nose, and explore how facial landmarks become coordinates for a live video effect."
parent: AI and tracking
grand_parent: Examples
permalink: /examples/ai/pose-detection.html
score: /examples/ai/pose-detection.zip
---

# Face landmarks and radial blur

![Facial keypoint filters connected to a radial blur over the camera image]({{ site.baseurl }}/assets/scores/thumbnails/examples-ai-pose-detection.png)

Move your head and the center of a radial blur follows your nose across the camera image. This is a small, direct visual instrument: one tracked point gives the performer control over where an effect acts, while the blur amount determines how strongly the gesture changes the image.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/ai/pose-detection.zip)

## Requirements and setup

Open the ZIP directly in score: it includes the RetinaFace model used by the patch. You need score's ONNX/Pose Detector support. Despite the document's filename, this model detects faces and five facial landmarks, not a full-body skeleton. To explore other models, use the [LivePose model pack](https://github.com/sat-mtl/livepose/releases/tag/model-storage) and select the appropriate Landmark Model. GPU inference also needs the acceleration libraries supported by your score build.

Select a working camera for `Camera:/`, grant camera access if prompted, and start playback facing the camera. Look for the annotated image and a nonzero detection count before adjusting the effect. The Object filter process requires the Jk data-query add-on.

## Try it

Keep the blur amount fixed and move your head slowly from side to side. Then increase the amount: the same gesture should become easier to see in the image. This separates the mapping's position control from the effect's intensity.

The Object filter extracts the nose with `.keypoints[2]` and flips its vertical coordinate to match the effect. Try another of the five landmarks and compare where the blur settles on your face. A separate plot follows the first landmark's horizontal position; it is a useful reference when checking whether motion is being detected.

If the camera image appears but the effect does not follow you, check the detection count and Landmark Model selection first. If movement is detected but appears inverted, inspect the coordinate conversion rather than changing the model.
