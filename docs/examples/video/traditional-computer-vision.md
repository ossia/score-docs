---
layout: default
title: "Camera blobs, contours and tracking"
description: "Reduce a live camera image to blobs, outlines and tracked points for camera-based interaction."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/traditional-computer-vision.html
score: /examples/video/traditional-computer-vision.score
---

# Camera blobs, contours and tracking

![Camera analysis views compared in a grid, with detected positions drawn as points]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-traditional-computer-vision.png)

Turn a camera view into silhouettes, outlines and moving points. A comparison grid makes it possible to judge which features remain useful as a person or object moves—an important first step before mapping camera activity to sound, light or another response.

## Choose what to follow

Blob detection groups image regions, contour analysis follows boundaries, and edge detection emphasizes changes in the picture. The patch compares these views with the original image. A separate tracking branch follows contour-derived positions over time and draws the tracked points.

Blob centroids and contour-based tracking are different measurements, so they need not mark the same locations. The useful question is not which view looks most detailed, but which gives a stable description of the gesture you want to capture.

## Try it

Select an available camera in the Camera device settings and grant capture permission where required.

- Start playback and move a high-contrast object against a simple background. Compare its outline, detected regions and tracked points.
- Adjust Blob stats and Contours thresholds separately. Notice when background detail starts to compete with the intended subject.
- Change Point Tracker settings and repeat the same movement. Compare the continuity of tracked positions rather than only the appearance of a single frame.

The analysis runs on the CPU with texture inlets configured for 128×128 input. Retain a small analysis resolution unless more detail is necessary; the point-drawing branch requires compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
