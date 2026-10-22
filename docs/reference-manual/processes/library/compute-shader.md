---
layout: default

title: Compute Shaders
description: "Using compute shaders in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/compute-shaders.html
---

# CSF Compute Shaders

<video src="{{ site.img }}/reference/processes/compute-shader.webm" data-loop controls muted loop playsinline preload="none" aria-label="Shader" title="Shader Example"></video>

The Compute Shader process runs CSF shaders: *score*'s compute-shader extension of ISF. Use CSF when a fullscreen fragment pass is not the right model: image processing, storage images, GPU simulations, particle systems, geometry generation, geometry filters, buffer writes, volume generation, and indirect draw preparation.

A CSF file is a GLSL compute shader with a JSON header. It can be dropped from the file explorer or user library. Controls, GPU resources, input and output ports are built from the header.

## Using the process

Drop a CSF file into the score, connect its generated resource inlets, and send image outputs to a video output. Geometry outputs need [[Model Display]] or [[Render Pipeline]] before they can be displayed as an image. For geometry with its own topology, set the downstream Render Pipeline **Mode** to **Geometry**.

The [CSF language reference]({{ site.baseurl }}/reference/languages/csf.html) contains a [minimal image filter]({{ site.baseurl }}/reference/languages/csf.html#minimal-file), every resource and pass field, buffer layouts, geometry macros, expressions and built-ins. [[Shader cookbook]] provides image, geometry, indirect-work and audio recipes.

Go directly to a relocated section:

- <a id="minimal-file"></a>[Minimal file]({{ site.baseurl }}/reference/languages/csf.html#minimal-file)
- <a id="header-fields"></a>[Header fields]({{ site.baseurl }}/reference/languages/csf.html#header-fields)
- <a id="resource-types"></a>[Resource types]({{ site.baseurl }}/reference/languages/csf.html#resource-types)
- <a id="images"></a>[Images]({{ site.baseurl }}/reference/languages/csf.html#images)
- <a id="d-image"></a>[3D image]({{ site.baseurl }}/reference/languages/csf.html#3d-image)
- <a id="persistent-image"></a>[Persistent image]({{ site.baseurl }}/reference/languages/csf.html#persistent-image)
- <a id="sampled-textures"></a>[Sampled textures]({{ site.baseurl }}/reference/languages/csf.html#sampled-textures)
- <a id="storage-buffers"></a>[Storage buffers]({{ site.baseurl }}/reference/languages/csf.html#storage-buffers)
- <a id="uniform-buffers"></a>[Uniform buffers]({{ site.baseurl }}/reference/languages/csf.html#uniform-buffers)
- <a id="geometry-resources"></a>[Geometry resources]({{ site.baseurl }}/reference/languages/csf.html#geometry-resources)
- <a id="generator-or-filter"></a>[Generator or filter]({{ site.baseurl }}/reference/languages/csf.html#generator-or-filter)
- <a id="geometry-fields"></a>[Geometry fields]({{ site.baseurl }}/reference/languages/csf.html#geometry-fields)
- <a id="attribute-fields"></a>[Attribute fields]({{ site.baseurl }}/reference/languages/csf.html#attribute-fields)
- <a id="copyfrom"></a>[`COPY_FROM`]({{ site.baseurl }}/reference/languages/csf.html#copy_from)
- <a id="indirect-draw"></a>[Indirect draw]({{ site.baseurl }}/reference/languages/csf.html#indirect-draw)
- <a id="auxiliary-buffers-and-textures"></a>[Auxiliary buffers and textures]({{ site.baseurl }}/reference/languages/csf.html#auxiliary-buffers-and-textures)
- <a id="ssbo-auxiliary"></a>[SSBO auxiliary]({{ site.baseurl }}/reference/languages/csf.html#ssbo-auxiliary)
- <a id="ubo-auxiliary"></a>[UBO auxiliary]({{ site.baseurl }}/reference/languages/csf.html#ubo-auxiliary)
- <a id="texture-auxiliary"></a>[Texture auxiliary]({{ site.baseurl }}/reference/languages/csf.html#texture-auxiliary)
- <a id="custom-types"></a>[Custom types]({{ site.baseurl }}/reference/languages/csf.html#custom-types)
- <a id="passes-and-execution-models"></a>[Passes and execution models]({{ site.baseurl }}/reference/languages/csf.html#passes-and-execution-models)
- <a id="execution-model-types"></a>[Execution model types]({{ site.baseurl }}/reference/languages/csf.html#execution-model-types)
- <a id="indirect-dispatch"></a>[Indirect dispatch]({{ site.baseurl }}/reference/languages/csf.html#indirect-dispatch)
- <a id="expressions"></a>[Expressions]({{ site.baseurl }}/reference/languages/csf.html#expressions)
- <a id="built-in-uniforms"></a>[Built-in uniforms]({{ site.baseurl }}/reference/languages/csf.html#built-in-uniforms)
- <a id="image-formats"></a>[Image formats]({{ site.baseurl }}/reference/languages/csf.html#image-formats)
- <a id="patterns"></a>[Patterns]({{ site.baseurl }}/reference/languages/csf.html#patterns)
- <a id="image-filter"></a>[Image filter]({{ site.baseurl }}/reference/languages/csf.html#image-filter)
- <a id="geometry-filter"></a>[Geometry filter]({{ site.baseurl }}/reference/languages/csf.html#geometry-filter)
- <a id="particle-feedback"></a>[Particle feedback]({{ site.baseurl }}/reference/languages/csf.html#particle-feedback)

## Runtime requirements

Compute and storage images require a compatible device and backend. Integer storage formats require Qt 6.10 or newer as well as device support; earlier Qt versions can fall back to RGBA8 without preserving integer semantics. See [[Graphics pipeline]]. Keep the bounds checks in the reference examples when changing image dimensions or geometry counts.

## Related Processes

- [[ISF Shaders]]: Fullscreen fragment shaders and post-processing.
- [[Render Pipeline]]: Draw CSF-generated or filtered geometry.
- [[Model Display]]: Display geometry with a built-in renderer.
- [[Pixel Utilities|Lightness Computer]]: Convert texture outputs to pixel arrays.
