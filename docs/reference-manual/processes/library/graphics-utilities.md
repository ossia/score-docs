---
layout: default
title: "Graphics Utilities"
description: "Select tools for texture processing and conversion"
parent: Processes
grand_parent: Reference
permalink: /processes/graphics-utilities.html
---

# Graphics Utilities


Graphics processes operate on textures rather than ordinary control-value lists. Connect texture outlets to texture inlets; use conversion or analysis processes when crossing between image data and control values.

| Task | Processes |
|---|---|
| Generate or transform an image on the GPU | [Shader]({{ site.baseurl }}/processes/shaders.html), [Compute shader]({{ site.baseurl }}/processes/compute-shaders.html) |
| Sample an image into control values | [Lightness computer and Lightness sampler]({{ site.baseurl }}/processes/pixel-utilities.html) |
| Inspect a pixel-value array | [LED View]({{ site.baseurl }}/processes/led-view.html) |
| Load time-varying image content | [Video]({{ site.baseurl }}/processes/video.html) |
| Convert arrays to textures or exchange GPU buffer data | [Geometry and buffer utilities]({{ site.baseurl }}/processes/geometry-utilities.html#array-to-texture) |

For pixel analysis, choose between converting all pixels and sampling just a few positions. Resize or simplify the upstream image when a large array is unnecessary. Texture format, dimensions and graphics-backend support belong to the producing and consuming processes; a cable is not a guarantee that every texture kind is interchangeable.
