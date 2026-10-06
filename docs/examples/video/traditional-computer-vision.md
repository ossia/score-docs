---
layout: default
title: "Camera blobs, contours and tracking"
description: "An example showing how to identify shapes and track points in a live camera image."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/traditional-computer-vision.html
score: /examples/video/traditional-computer-vision.score
---

# Camera blobs, contours and tracking

![Contours and Point Tracker 2D feeding GPU point drawing alongside image-analysis branches connected to Grid]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-traditional-computer-vision.png)

This example demonstrates finding shapes and tracking points in a live camera image.

## Overview

Blob detection, contours and edge detection offer different ways of simplifying a picture into useful features. A grid compares these analysis views with the original camera image, while tracked points show how detected positions evolve over time.

These techniques are useful when exploring camera-based interaction. Blob centroids and contour-based tracking are separate analyses here, so they need not identify the same positions.

## Try it

Select an available camera in the Camera device settings and grant capture permission where required. Start playback and move a high-contrast object against a simpler background. Tune the Blob stats and Contours thresholds to isolate the object, then adjust Point Tracker settings and observe how the tracked positions respond.

The analysis processes run on the CPU. Their texture inlets are configured for 128×128 input; retain a small analysis resolution instead of processing a full-resolution camera frame unnecessarily. The drawing branch requires compute-shader support. No recorded video file is included or needed.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
