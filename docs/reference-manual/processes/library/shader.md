---
layout: default

title: ISF Shaders
description: "Using ISF shaders in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/shaders.html
---

# ISF Shaders

![Shader]({{ site.img }}/reference/processes/shader.png "Shader Example")

The ISF Shader process runs [Interactive Shader Format](https://isf.video) fragment shaders on the GPU. Use it for video filters, generators, feedback effects, post-processing, texture conversion, and Shadertoy-style visuals.

ISF shaders can be drag-and-dropped from the process library, user library, or file explorer. *score* reads the JSON header, creates controls and texture ports automatically, and recompiles the shader while the score is running.

## When to use ISF

Use ISF when the shader renders a fullscreen image pass. Use a different process when the work is not a fullscreen fragment pass:

| Goal | Better process |
|---|---|
| Run arbitrary compute, write storage images, generate geometry | [[Compute Shaders]] |
| Draw custom 3D geometry with a vertex shader | [[Render Pipeline]] |
| Display existing geometry quickly | [[Model Display]] |
| Write Vertex Shader Art-style point / line visuals | [[Vertex Shader Art]] |

## Files and live editing

An ISF shader is a `.fs` or `.frag` file with a JSON header followed by GLSL. A custom vertex shader can be paired with the fragment shader: a `.vs` / `.vert` file with the same name next to it is used as its vertex stage. The editor can live-code both stages. A `.glsl` file dropped in the score is not an ISF shader: it is handled as a [geometry filter]({{ site.baseurl }}/reference/languages/geometry-filter.html), and an include file that is not one makes no process.

Press {% include shortcut.html content="Ctrl+Enter" %} in the shader editor to recompile during playback. For production authoring, the official ISF editor remains useful, but *score* supports the runtime-specific features documented here.

Shader sources can use `#include`; include paths are resolved before parsing. Compiling a shader again picks up the changes of the files it includes.

When a shader process loads a shader that cannot be used — a header or GLSL error — it has no ports, and a warning naming the process and the error is shown in the **Messages** panel. The editor shows the same error while typing.

## Language reference

The [ISF language reference]({{ site.baseurl }}/reference/languages/isf.html) documents the JSON header, controls, textures, audio, built-ins, outputs, multipass rendering, sizing and alpha. It distinguishes standard ISF from score extensions. Start with its [brightness filter]({{ site.baseurl }}/reference/languages/isf.html#simple-color-filter), or follow [[Shader cookbook]] for feedback and MRT recipes.

Go directly to a relocated section:

- <a id="json-header"></a>[JSON header]({{ site.baseurl }}/reference/languages/isf.html#json-header)
- <a id="common-fields"></a>[Common fields]({{ site.baseurl }}/reference/languages/isf.html#common-fields)
- <a id="scalar-input-types"></a>[Scalar input types]({{ site.baseurl }}/reference/languages/isf.html#scalar-input-types)
- <a id="texture-inputs"></a>[Texture inputs]({{ site.baseurl }}/reference/languages/isf.html#texture-inputs)
- <a id="d-image"></a>[2D image]({{ site.baseurl }}/reference/languages/isf.html#2d-image)
- <a id="d-image--volume"></a>[3D image / volume]({{ site.baseurl }}/reference/languages/isf.html#3d-image--volume)
- <a id="cubemap"></a>[Cubemap]({{ site.baseurl }}/reference/languages/isf.html#cubemap)
- <a id="sampleable-depth"></a>[Sampleable depth]({{ site.baseurl }}/reference/languages/isf.html#sampleable-depth)
- <a id="sampler-state"></a>[Sampler state]({{ site.baseurl }}/reference/languages/isf.html#sampler-state)
- <a id="audio-textures"></a>[Audio textures]({{ site.baseurl }}/reference/languages/isf.html#audio-textures)
- <a id="texture-macros"></a>[Texture macros]({{ site.baseurl }}/reference/languages/isf.html#texture-macros)
- <a id="built-in-uniforms"></a>[Built-in uniforms]({{ site.baseurl }}/reference/languages/isf.html#built-in-uniforms)
- <a id="outputs"></a>[Outputs]({{ site.baseurl }}/reference/languages/isf.html#outputs)
- <a id="multiple-render-targets"></a>[Multiple render targets]({{ site.baseurl }}/reference/languages/isf.html#multiple-render-targets)
- <a id="output-fields"></a>[Output fields]({{ site.baseurl }}/reference/languages/isf.html#output-fields)
- <a id="multipass-rendering"></a>[Multipass rendering]({{ site.baseurl }}/reference/languages/isf.html#multipass-rendering)
- <a id="size-expressions"></a>[Size expressions]({{ site.baseurl }}/reference/languages/isf.html#size-expressions)
- <a id="alpha-and-compositing"></a>[Alpha and compositing]({{ site.baseurl }}/reference/languages/isf.html#alpha-and-compositing)
- <a id="examples"></a>[Examples]({{ site.baseurl }}/reference/languages/isf.html#examples)
- <a id="simple-color-filter"></a>[Simple color filter]({{ site.baseurl }}/reference/languages/isf.html#simple-color-filter)
- <a id="generator"></a>[Generator]({{ site.baseurl }}/reference/languages/isf.html#generator)
- <a id="feedback-trail"></a>[Feedback trail]({{ site.baseurl }}/reference/languages/isf.html#feedback-trail)
- <a id="mrt-output"></a>[MRT output]({{ site.baseurl }}/reference/languages/isf.html#mrt-output)

## Connecting and previewing

Connect a video or image producer to the generated image inlet, adjust the controls, and connect the shader output to a video output or another effect. Generators need no image inlet. The **Show shader previews** toolbar action controls library and inspector previews. See [[Graphics pipeline]] for sizing and backend limits.

The texture inlet inspector has these rows:

| Row | Description |
|---|---|
| Size | Explicit render size of the input, with width and height controls; uncheck it for **Auto** sizing. |
| Format | Render target format: **Auto** (RGBA8, or the texture the upstream process publishes when the inlet can read it directly), RGBA8, RGBA16F, RGBA32F, R8, R16, R16F or R32F. |
| Filter | Nearest or Linear. |
| Address mode | Repeat, Clamp to edge or Mirror. |
| Mipmaps | None, Nearest or Linear. A mipmap mode gives the input a mip chain. |

The first entry of Filter, Address mode and Mipmaps leaves the field to the shader: it reads **Shader: …** when the shader's JSON declares that field, **Default: …** otherwise, with the value it resolves to. A value picked in the inspector takes precedence over the shader's. When the shader samples the input with a depth comparison (`COMPARE`), these three rows are disabled. See [ISF sampler state]({{ site.baseurl }}/reference/languages/isf.html#sampler-state).

An input whose name the shader reserves for pointers (`mouse`, `iMouse`, `touch`) is bound to the window device's mouse and touch addresses by default; see [ISF pointer inputs]({{ site.baseurl }}/reference/languages/isf.html#pointer-inputs).

## Related Processes

- [[Compute Shaders]]: Compute shaders for images, buffers, volumes, and geometry.
- [[Render Pipeline]]: Raw vertex / fragment pipeline for custom 3D rendering.
- [[Vertex Shader Art]]: Vertex Shader Art-compatible generative shaders.
- [[Model Display]]: Built-in renderer for geometry.
- [[Pixel Utilities|Lightness Computer]]: Convert textures to pixel arrays for LED workflows.
