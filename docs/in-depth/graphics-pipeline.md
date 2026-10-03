---
layout: default

title: Graphics pipeline
description: "Understanding the ossia score graphics and GPU pipeline"

parent: In depth

permalink: /in-depth/video.html
---

# Graphics pipeline

*score* has a patchable GPU graph for video, textures, compute, and 3D scenes. The graph runs on a dedicated rendering thread and uses [Qt RHI](https://www.qt.io/blog/graphics-in-qt-6.0-qrhi-qt-quick-3d). OpenGL, Vulkan, Metal, and Direct3D have different feature and format limits; using RHI does not make every shader supported on every backend.

The important rule for authors is: use the *score* / ISF helpers instead of backend-specific GLSL assumptions. Coordinate origins, clip-space conventions, alpha representation, texture formats, and resource bindings are normalized by the runtime.

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

These processes share the same parser family and many header fields: controls, texture inputs, sampler settings, output declarations, alpha / compositing policy, time uniforms, and resource expressions.

## Rendering model

Each visual process writes into one or more render targets. The graph orders nodes from their cable dependencies and rebuilds GPU resources when topology, render target size, sample count, formats, or bindings change.

A process can publish more than one output:

- ISF / raw raster `OUTPUTS` can expose multiple color attachments and optional depth.
- CSF `IMAGE` resources are published as texture outputs even when the process also outputs geometry.
- CSF `geometry` resources publish GPU-resident geometry that can be connected directly to renderers.
- Scene preprocessors can publish flattened geometry plus auxiliary buffers and textures such as camera, per-draw data, material pools, light data, shadow maps, and environment maps.

## Coordinates and portability

Graphics APIs disagree on texture origin and clip-space orientation. *score* hides most of this, but shader authors must use the provided helpers:

- In fragment shaders, sample 2D textures with `IMG_NORM_PIXEL`, `IMG_PIXEL`, `IMG_THIS_NORM_PIXEL`, `IMG_THIS_PIXEL`, or `IMG_TEXEL` rather than hand-coded `texture()` / `gl_FragCoord` math.
- In compute shaders, use `IMG_LOAD`, `IMG_STORE`, and `IMG_STORE_LAYER` for image resources when image origin matters.
- In raw raster vertex shaders, call `isf_vertShaderInit()` at the start of `main()` and `isf_vertShaderFinish()` at the end. This keeps multiview data and clip-space Y correction consistent.
- Multiply clip-space positions by `clipSpaceCorrMatrix` and use `VIEWPROJECTION_MATRIX` / `MODEL_MATRIX` when rendering geometry with the raw raster pipeline.

## Alpha and compositing

The renderer supports both straight and premultiplied alpha. Header fields let a shader state its contract instead of relying on implicit blending:

```json
{
  "ALPHA": "premultiplied",
  "COMPOSITE": "over"
}
```

`ALPHA` can be `"straight"` or `"premultiplied"`. `COMPOSITE` can be `"over"`, `"add"`, `"multiply"`, `"screen"`, or `"replace"`. These can be declared globally or per output where supported.

If a shader declares explicit `PIPELINE_STATE.BLEND`, that blend state wins over `COMPOSITE`.

For raw raster transparency, current shaders use `QUEUE` and `LAYER`. The historical `TRANSPARENCY` block is not a current parser field: do not copy it from an older development example. See [[Render Pipeline]] for private targets, resolve shaders and depth policies.

## Depth, layers, cubemaps, and MSAA

Raw raster and ISF outputs can declare richer render targets:

```json
"OUTPUTS": [
  { "NAME": "color", "TYPE": "color", "FORMAT": "rgba16f", "SAMPLES": 4 },
  { "NAME": "depth", "TYPE": "depth", "FORMAT": "d32f" }
]
```

Additional output fields include:

- `WIDTH`, `HEIGHT`: fixed or expression-sized offscreen targets.
- `LAYERS`: texture array outputs.
- `DEPTH`: 3D texture outputs.
- `CUBEMAP`: cubemap outputs.
- `GENERATE_MIPS`: automatic mip generation after rendering.
- `SAMPLES`: per-output MSAA sample count.

Raw raster execution models can render per mip, per layer, per cubemap face, or a manual number of times. This is how environment precomputation, shadow cascades, layered effects, and probe rendering are built.

## 3D and scene path

There are two common 3D paths:

1. **Geometry path**: mesh / point / primitive geometry flows directly into [[Model Display]] or [[Render Pipeline]]. `MODEL_MATRIX` contains the upstream transform.
2. **Scene path**: a scene is flattened by the scene preprocessor. Raw raster shaders read scene auxiliary buffers such as `per_draws`, `scene_counts`, `camera`, and material textures. Per-object transforms come from the per-draw data, not from `MODEL_MATRIX`.

Raw raster shaders automatically get a `camera` uniform auxiliary when they do not declare one. The helper macros are:

```glsl
VIEW_MATRIX
PROJECTION_MATRIX
VIEWPROJECTION_MATRIX
CAMERA_POSITION
```

If a raw raster shader declares camera access, *score* adds a `Camera` geometry inlet so a camera or camera array can drive those matrices.

## Expressions

Many size and dispatch fields accept expressions:

- scalar inputs: `$size`, `$iterations`
- texture dimensions: `$WIDTH_input`, `$HEIGHT_input`, `$DEPTH_input`, `$LAYERS_input`
- geometry counts: `$VERTEX_COUNT`, `$INSTANCE_COUNT`, `$VERTEX_COUNT_geo`
- user slider: `$USER`

Expressions support arithmetic, comparisons, and common math functions such as `min`, `max`, `sqrt`, `ceil`, `floor`, `pow`, `sin`, `cos`, `clamp`, `step`, and `smoothstep`.

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

Storage-image and compute recipes require a compute-capable backend and device. Integer storage formats in the current format mapping require Qt 6.10 or newer: on older builds unsupported names fall back to RGBA8, which is not equivalent to integer storage. A driver must also support the requested format and usage. Prefer `rgba8` or supported floating-point formats when integer precision is not required.

See [[Shader cookbook]] for small, source-based recipes and backend-sensitive checks. These newer shader extensions describe current development builds, not a guarantee for every released version.

## Related pages

- [[ISF Shaders]]
- [[Compute Shaders]]
- [[Render Pipeline]]
- [[Vertex Shader Art]]
- [[Model Display]]
- [[Object Loader]]
- [[Asset Loader]]
