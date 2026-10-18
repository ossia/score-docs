---
layout: default
title: "Image to point cloud"
description: "Give a changing noise image depth by converting its samples into colored points."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/image-to-pointcloud.html
score: /examples/3d/image-to-pointcloud.score
---

# Image to point cloud

![Multicolored spiky point cloud above the RGB Simplex Noise, ImageToPoints and Model Display processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-image-to-pointcloud.png)

A slowly shifting noise image becomes a spiky, colored form in space. Each image sample becomes a point, so no surface needs to be modelled.

RGB Simplex Noise supplies the image, and a compute shader converts it into geometry for native Model Display. Depth scaling controls how far points extend from the image plane; the threshold changes which samples contribute to the cloud.

## Try it

Start playback and bring `zScale` toward zero to flatten the result, then increase it to recover depth. The Z component of `pointScale` also affects depth. Raise `threshold` gradually and watch which parts of the cloud remain.

No image file is needed. To adapt the patch, replace the noise source with another texture-producing process. Use a compute-capable graphics backend; the saved vertex count is about 6.4 million, so lower that workload if necessary before trying high-resolution sources.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
