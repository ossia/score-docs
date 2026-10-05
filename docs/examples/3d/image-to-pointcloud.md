---
layout: default
title: "Image to point cloud"
description: "Convert a shader-generated image into coloured GPU geometry."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/image-to-pointcloud.html
score: /examples/3d/image-to-pointcloud.score
---

# Image to point cloud

![Multicoloured spiky point cloud above the RGB Simplex Noise, ImageToPoints and Model Display processes.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-image-to-pointcloud.png)

RGB Simplex Noise feeds the ImageToPoints compute shader. ImageToPoints converts the input texture into geometry; native Model Display displays it in point mode and sends the image to `Window:/`. A small Drift LFO moves the noise offset.

## Try it

Start playback, then vary `zScale` and the Z component of `pointScale` to change the depth of the cloud. Raise `threshold` to compare how image samples contribute to the result. The configured vertex count is large (6,419,550), so reduce the workload if necessary before experimenting with high-resolution inputs.

No image file is required because the source is procedural. You can replace RGB Simplex Noise with a texture-producing process to try a different source. This uses a compute shader and native Model Display, not Qt Quick 3D.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
