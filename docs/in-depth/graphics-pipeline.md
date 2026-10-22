---
layout: default

title: Graphics pipeline
description: "Understanding the ossia score graphics and GPU pipeline"

parent: In depth

permalink: /in-depth/video.html
---

# Graphics pipeline

*score* has a patchable GPU graph for video, textures, compute, and 3D scenes. The graph runs on a dedicated rendering thread and uses [Qt RHI](https://www.qt.io/blog/graphics-in-qt-6.0-qrhi-qt-quick-qt-quick-3d). OpenGL, Vulkan, Metal, and Direct3D have different feature and format limits; using RHI does not make every shader supported on every backend.

The important rule for authors is: use the *score* / ISF helpers instead of backend-specific GLSL assumptions. Coordinate origins, clip-space conventions, alpha representation, texture formats, and resource bindings are normalized by the runtime. The [GLSL runtime reference]({{ site.baseurl }}/reference/languages/glsl.html) explains the language and generated interface; this page explains how processes fit together.

## Data types in the graph

The visual graph moves several GPU-side resource types:

| Resource | Typical producers | Typical consumers |
|---|---|---|
| 2D texture | Video, camera, image, [[ISF Shaders]], [[Compute Shaders]], Qt Quick / JavaScript texture outputs | [[ISF Shaders]], [[Compute Shaders]], [[Render Pipeline]], output windows, video outputs |
| 3D texture / texture array | [[Compute Shaders]], HDF5 / volume-style sources, layered render targets | CSF volume passes, raw raster passes, volume or slice visualizers |
| Cubemap | Cubemap loader / composer, camera arrays, raw raster cubemap passes | Environment maps, skyboxes, reflection / probe shaders |
| Geometry | Object loaders, primitives, Structure Synth, [[Compute Shaders]], scene preprocessors | [[Model Display]], [[Render Pipeline]], geometry filters |
| Scene | glTF / FBX / scene loaders, Qt Quick 3D, scene graph tools | Scene preprocessor, scene filters, flattened scene renderers |
| Storage / uniform buffers | CSF resources, scene preprocessors, raw raster auxiliary data | CSF passes and raw raster shaders |

Texture and geometry ports are first-class patch cables. A shader output can drive a video window, a later shader, a Qt Quick 3D `TextureInlet`, a pixel-to-LED conversion, or a raw raster material.

For the scene-building path, see [[3D scene pipeline]]: it distinguishes native scene import and preprocessing from direct geometry rendering and Qt Quick 3D. [[Video formats and color]] explains the decoding and pixel-conversion stages before texture processing.

## Main shader processes

| Process | Shader model | Use it for |
|---|---|---|
| [[ISF Shaders]] | Fragment shader on a fullscreen image pass | Video filters, generators, feedback, post-processing, Shadertoy-style work |
| [[Compute Shaders]] | CSF compute dispatches | Image processing, GPU simulations, texture / volume generation, geometry generation or filtering |
| [[Render Pipeline]] | Raw vertex + fragment raster pipeline | Custom 3D rendering, procedural draws, instanced rendering, scene rendering, shadow / cubemap passes |
| [[Vertex Shader Art]] | Vertex Shader Art-compatible procedural vertex shader | Point / line based generative visuals |
| [[Model Display]] | Built-in renderer | Quick display of geometry with standard controls and texture projection |

These processes share a parser family, but not every field belongs to every format. The canonical contracts are [ISF]({{ site.baseurl }}/reference/languages/isf.html), [CSF]({{ site.baseurl }}/reference/languages/csf.html), [raw raster]({{ site.baseurl }}/reference/languages/raw-raster.html), and [VSA]({{ site.baseurl }}/reference/languages/vertex-shader-art.html). Standard ISF and score extensions are distinguished in the ISF reference.

## Rendering model

Each visual process writes into one or more render targets. The graph orders nodes from their cable dependencies and rebuilds GPU resources when topology, render target size, sample count, formats, or bindings change.

A process can publish more than one output:

- ISF / raw raster `OUTPUTS` can expose multiple color attachments and optional depth.
- CSF `IMAGE` resources are published as texture outputs even when the process also outputs geometry.
- CSF `geometry` resources publish GPU-resident geometry that can be connected directly to renderers.
- Scene preprocessors can publish flattened geometry plus auxiliary buffers and textures such as camera, per-draw data, material pools, light data, shadow maps, and environment maps.

## Coordinates and portability

Graphics APIs disagree on texture origin and clip-space orientation. *score* hides most of this through image sampling/store helpers and vertex-stage initialization and finalization. Treat texture lookup coordinates separately from clip-space positions: an unconditional Y flip is not a portable solution. Follow the [stage-specific coordinate conventions]({{ site.baseurl }}/reference/languages/glsl.html#coordinates-and-stage-conventions), including the distinct raw-raster and VSA contracts.

## Alpha and compositing

Straight alpha stores color independently of coverage; premultiplied alpha stores color already multiplied by coverage. Mixing these without declaring the convention can create dark fringes or incorrect overlays. Shader headers state the output convention and intended composition.

See [ISF alpha and compositing]({{ site.baseurl }}/reference/languages/isf.html#alpha-and-compositing) for the shared policy and [raw-raster transparency]({{ site.baseurl }}/reference/languages/raw-raster.html#alpha-compositing-and-transparency) for explicit blending, draw queues and private layers. Explicit raster blend state takes precedence over the composition policy.

## Depth, layers, cubemaps, and MSAA

An output is more than a color image: a render target may include depth, multiple color attachments, array layers, cubemap faces, mip levels or multisampling. These enable shadow maps, environment probes, layered effects and later depth-aware composition.

Outputs sharing a framebuffer must have compatible dimensions and supported formats. A two-dimensional preview does not show every layer or cubemap face. Raw raster can repeat draws per mip, layer or face; true volumetric writes use compute. Allocation fields belong to the [ISF output reference]({{ site.baseurl }}/reference/languages/isf.html#outputs) and [raw-raster output and execution contracts]({{ site.baseurl }}/reference/languages/raw-raster.html#fragment-outputs-and-render-targets).

## 3D and scene path

There are two common 3D paths:

1. **Geometry path**: mesh / point / primitive geometry flows directly into [[Model Display]] or [[Render Pipeline]]. `MODEL_MATRIX` contains the upstream transform.
2. **Scene path**: a scene is flattened by the scene preprocessor. Raw raster shaders read scene auxiliary buffers such as `per_draws`, `scene_counts`, `camera`, and material textures. Per-object transforms come from the per-draw data, not from `MODEL_MATRIX`.

The runtime can supply a camera interface and a **Camera** geometry inlet to shaders using the built-in camera. See [raw-raster camera uniforms]({{ site.baseurl }}/reference/languages/raw-raster.html#built-in-uniforms-and-macros) and the [geometry versus scene contract]({{ site.baseurl }}/reference/languages/raw-raster.html#geometry-path-vs-scene-path) before choosing a transform.

## Expressions

Image sizes and dispatch counts can depend on controls and upstream resource dimensions instead of fixed constants. This lets a filter follow its input resolution or a geometry pass follow its upstream vertex count. The exact variables and operators belong to [ISF size expressions]({{ site.baseurl }}/reference/languages/isf.html#size-expressions) and [CSF expressions]({{ site.baseurl }}/reference/languages/csf.html#expressions); these header expressions are evaluated by the runtime, not GLSL expressions in the shader body.

## Live editing and library scan

Shader files can be dropped from the file explorer or added to the user library. *score* scans the JSON header to decide which process owns a file:

- no `MODE`: ISF shader
- `"MODE": "COMPUTE_SHADER"`: CSF compute shader
- `"MODE": "RAW_RASTER_PIPELINE"`: render pipeline
- `"MODE": "VERTEX_SHADER_ART"`: VSA shader

Shader sources can use `#include`; includes are resolved relative to the shader file and global shader search paths before parsing and compilation.

## Preview and render size controls

The **Graphics** toolbar's **Show shader previews** toggle controls shader previews in both the library and inspector. Turning previews off is useful while editing an expensive shader; it is not a replacement for disconnecting a live output.

In a texture inlet's inspector, enable the size checkbox to set width and height. Unchecked means **Auto**, not a zero-sized texture. Automatic sizing follows the consuming render target or output viewport; with one cable and no explicit size or format, the inlet may use the producer's published texture directly. Re-enabling the checkbox restores its previous dimensions (initially 1280 × 720). Shader-declared `WIDTH` and `HEIGHT` remain important for explicitly allocated offscreen images.

Use [[Sink]] when a GPU chain must run without a visible window, for example to obtain a process's data output. Its **Rate** is a requested frame rate, capped by the rendering rate in settings.

## Backend limits

Storage-image and compute recipes require a compute-capable backend and device. Integer storage formats require Qt 6.10 or newer: with earlier Qt versions, unsupported names fall back to RGBA8, which is not equivalent to integer storage. A driver must also support the requested format and usage. Prefer `rgba8` or supported floating-point formats when integer precision is not required.

See [[Shader cookbook]] for small recipes using these shader extensions.

## Related pages

- [[ISF Shaders]]
- [[Compute Shaders]]
- [[Render Pipeline]]
- [[Vertex Shader Art]]
- [[Model Display]]
- [[Object Loader]]
- [[Asset Loader]]
