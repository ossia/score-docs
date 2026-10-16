---
layout: default
title: "Image to point cloud"
description: "Give a changing noise image depth by converting its samples into coloured points."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/image-to-pointcloud.html
score: /examples/3d/image-to-pointcloud.score
---

# Image to point cloud

![Multicoloured spiky point cloud above the RGB Simplex Noise, ImageToPoints and Model Display processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-image-to-pointcloud.png)

A slowly shifting noise image becomes a spiky, coloured form in space. Treating image samples as points lets you move between a flat texture and a volumetric-looking composition without first modelling a surface.

RGB Simplex Noise supplies the image, and a compute shader converts it into geometry for native Model Display. Depth scaling controls how far points extend from the image plane; the threshold changes which samples contribute to the cloud.

## Try it

Start playback and bring `zScale` toward zero to flatten the result, then increase it to recover depth. Compare this with the Z component of `pointScale`. Raise `threshold` gradually and watch which parts of the cloud remain.

No image file is needed. To adapt the patch, replace the noise source with another texture-producing process. Use a compute-capable graphics backend; the saved vertex count is about 6.4 million, so lower that workload if necessary before trying high-resolution sources.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
