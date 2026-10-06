---
layout: default
title: "Image to point cloud"
description: "An example showing how to turn an image into a coloured 3D point cloud."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/image-to-pointcloud.html
score: /examples/3d/image-to-pointcloud.score
---

# Image to point cloud

![Multicoloured spiky point cloud above the RGB Simplex Noise, ImageToPoints and Model Display processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-image-to-pointcloud.png)

This example demonstrates converting an image into a coloured point cloud.

## Overview

A slowly changing noise texture becomes a three-dimensional arrangement of points. Depth, scale and threshold controls offer different interpretations of the same image, making this a starting point for exploring the relationship between textures and geometry.

## Try it

Start playback, then vary `zScale` and the Z component of `pointScale` to change the depth of the cloud. Raise `threshold` to compare how image samples contribute to the result. The configured vertex count is large (6,419,550), so reduce the workload if necessary before experimenting with high-resolution inputs.

No image file is required because the source is procedural. You can replace RGB Simplex Noise with a texture-producing process to try a different source. This uses a compute shader and native Model Display, not Qt Quick 3D.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
