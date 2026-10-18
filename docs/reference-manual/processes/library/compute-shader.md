---
layout: default

title: Compute Shaders
description: "Using compute shaders in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/compute-shaders.html
---

# CSF Compute Shaders

![Shader]({{ site.img }}/reference/processes/compute-shader.gif "Shader Example")

The Compute Shader process runs CSF shaders: *score*'s compute-shader extension of ISF. Use CSF when a fullscreen fragment pass is not the right model: image processing, storage images, GPU simulations, particle systems, geometry generation, geometry filters, buffer writes, volume generation, and indirect draw preparation.

A CSF file is a GLSL compute shader with a JSON header. It can be dropped from the file explorer or user library. Controls, GPU resources, input and output ports are built from the header.

## Using the process

Drop a CSF file into the score, connect its generated resource inlets, and send image outputs to a video output. Geometry outputs need [[Model Display]] or [[Render Pipeline]] before they can be displayed as an image. For geometry with its own topology, set the downstream Render Pipeline **Mode** to **Geometry**.

The [CSF language reference]({{ site.baseurl }}/reference/languages/csf.html) contains a [minimal image filter]({{ site.baseurl }}/reference/languages/csf.html#minimal-file), every resource and pass field, buffer layouts, geometry macros, expressions and built-ins. [[Shader cookbook]] provides image, geometry, indirect-work and audio recipes.

## Runtime requirements

Compute and storage images require a compatible device and backend. Integer storage formats require Qt 6.10 or newer as well as device support; earlier Qt versions can fall back to RGBA8 without preserving integer semantics. See [[Graphics pipeline]]. Keep the bounds checks in the reference examples when changing image dimensions or geometry counts.

## Related Processes

- [[ISF Shaders]]: Fullscreen fragment shaders and post-processing.
- [[Render Pipeline]]: Draw CSF-generated or filtered geometry.
- [[Model Display]]: Display geometry with a built-in renderer.
- [[Pixel Utilities|Lightness Computer]]: Convert texture outputs to pixel arrays.
