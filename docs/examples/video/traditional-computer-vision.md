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

Turn a camera view into silhouettes, outlines and moving points. A grid shows the views side by side, so you can see which features stay stable as a person or object moves before mapping them to sound, light or another response.

## Blobs, contours and tracking

Blob detection groups image regions, contour analysis follows boundaries, and edge detection emphasizes changes in the picture. The patch shows these views next to the original image. A separate tracking branch follows contour-derived positions over time and draws the tracked points.

Blob centroids and contour-based tracking are different measurements, so they need not mark the same locations. Pick the view that describes the movement you want to capture most stably, not the most detailed one.

## Try it

Select an available camera in the Camera device settings and grant capture permission where required.

- Start playback and move a high-contrast object against a simple background. Its outline, detected regions and tracked points follow it in separate views.
- Adjust Blob stats and Contours thresholds separately. Lower them until background detail starts to compete with the subject, then back off.
- Change Point Tracker settings and repeat the same movement. Check that the tracked positions stay continuous over the movement, not just that a single frame looks right.

The analysis runs on the CPU with texture inlets configured for 128×128 input. Retain a small analysis resolution unless more detail is necessary; the point-drawing branch requires compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
