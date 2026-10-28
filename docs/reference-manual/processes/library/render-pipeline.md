---
layout: default

title: Render Pipeline
description: "Using raw raster render pipelines in the ossia score graphics pipeline"

parent: Processes
grand_parent: Reference

permalink: /processes/render-pipeline.html
---

# Render Pipeline (Raw Raster)

The Render Pipeline process runs a raw vertex + fragment shader pipeline. Unlike [[ISF Shaders]], which render fullscreen image passes, a raw raster pipeline draws geometry: meshes, point clouds, instanced geometry, CSF-generated buffers, flattened scenes, procedural vertices, cubemaps, layered targets, and custom material passes.

Use it when you need explicit control over vertex attributes, uniforms, buffers, raster state, output attachments, depth, blending, topology, or draw count.

For a cabled geometry's own topology, select **Geometry** in the **Mode** control. **Triangles**, **Points**, and **Lines** deliberately override it. A shader's explicit `PIPELINE_STATE.TOPOLOGY` takes precedence over the control. This matters particularly for CSF-generated point clouds and line strips.

Every Render Pipeline has these controls besides the ones its shader declares:

| Control | Description |
|---|---|
| Mode | Triangles, Points, Lines or Geometry, as above. |
| Enable blend | Turns on the blend below. Off by default. |
| Src Color, Dst Color | Color blend factors (Zero, One, SrcColor, OneMinusSrcColor, DstColor, OneMinusDstColor, SrcAlpha, OneMinusSrcAlpha, DstAlpha, OneMinusDstAlpha, the constant factors and SrcAlphaSaturate). Default SrcAlpha and OneMinusSrcAlpha. |
| Op Color | Add, Subtract, Reverse Subtract, Min or Max. Default Add. |
| Src Alpha, Dst Alpha | Alpha blend factors. Default One and OneMinusSrcAlpha. |
| Op Alpha | As Op Color, for alpha. Default Add. |

Image inputs named `touch` and `point2D` inputs named like `mouse` are bound to the window device's pointer addresses by default, as in ISF; see [ISF pointer inputs]({{ site.baseurl }}/reference/languages/isf.html#pointer-inputs).

## Files

A raw raster pipeline uses two files with the same base name:

- `MyShader.fs` or `MyShader.frag`: fragment shader and JSON header.
- `MyShader.vs` or `MyShader.vert`: vertex shader.

Place both files in the [[library|user library]] or drop the fragment file in the score. The JSON header must be in the fragment shader.

Shader sources can use `#include`; includes are resolved relative to the shader path and global shader search paths before parsing.

## Authoring and connecting

Start with the [minimal geometry shader]({{ site.baseurl }}/reference/languages/raw-raster.html#minimal-geometry-shader), connect upstream geometry, and send the texture output to a display or another effect. Match the requested vertex attributes to those provided by the geometry. Connect a camera to the generated **Camera** inlet when the shader uses the built-in camera.

The [raw raster shader reference]({{ site.baseurl }}/reference/languages/raw-raster.html) owns the header, vertex/fragment interfaces, buffer layouts, camera and transform macros, raster state, attachments, transparency and execution models. Use its [scene-path contract]({{ site.baseurl }}/reference/languages/raw-raster.html#scene-path) for flattened scenes: their per-draw transforms are not supplied through `MODEL_MATRIX`.

See [[Shader cookbook]] for complete source-based scene, cubemap, layer and transparency recipes, and [[Graphics pipeline]] for the conceptual graph and backend limits.

Go directly to a relocated section:

- <a id="minimal-geometry-shader"></a>[Minimal geometry shader]({{ site.baseurl }}/reference/languages/raw-raster.html#minimal-geometry-shader)
- <a id="fragment-shader-vertexcolorfs"></a>[Fragment shader: `VertexColor.fs`]({{ site.baseurl }}/reference/languages/raw-raster.html#fragment-shader-vertexcolorfs)
- <a id="vertex-shader-vertexcolorvs"></a>[Vertex shader: `VertexColor.vs`]({{ site.baseurl }}/reference/languages/raw-raster.html#vertex-shader-vertexcolorvs)
- <a id="header-fields"></a>[Header fields]({{ site.baseurl }}/reference/languages/raw-raster.html#header-fields)
- <a id="vertex-inputs"></a>[Vertex inputs]({{ site.baseurl }}/reference/languages/raw-raster.html#vertex-inputs)
- <a id="varyings"></a>[Varyings]({{ site.baseurl }}/reference/languages/raw-raster.html#varyings)
- <a id="fragment-outputs-and-render-targets"></a>[Fragment outputs and render targets]({{ site.baseurl }}/reference/languages/raw-raster.html#fragment-outputs-and-render-targets)
- <a id="controls-and-resource-inputs"></a>[Controls and resource inputs]({{ site.baseurl }}/reference/languages/raw-raster.html#controls-and-resource-inputs)
- <a id="ui-controls"></a>[UI controls]({{ site.baseurl }}/reference/languages/raw-raster.html#ui-controls)
- <a id="texture-inputs"></a>[Texture inputs]({{ site.baseurl }}/reference/languages/raw-raster.html#texture-inputs)
- <a id="storage-and-uniform-buffers"></a>[Storage and uniform buffers]({{ site.baseurl }}/reference/languages/raw-raster.html#storage-and-uniform-buffers)
- <a id="built-in-uniforms-and-macros"></a>[Built-in uniforms and macros]({{ site.baseurl }}/reference/languages/raw-raster.html#built-in-uniforms-and-macros)
- <a id="geometry-path-vs-scene-path"></a>[Geometry path vs scene path]({{ site.baseurl }}/reference/languages/raw-raster.html#geometry-path-vs-scene-path)
- <a id="geometry-path"></a>[Geometry path]({{ site.baseurl }}/reference/languages/raw-raster.html#geometry-path)
- <a id="scene-path"></a>[Scene path]({{ site.baseurl }}/reference/languages/raw-raster.html#scene-path)
- <a id="auxiliary-scene-data"></a>[Auxiliary scene data]({{ site.baseurl }}/reference/languages/raw-raster.html#auxiliary-scene-data)
- <a id="pipeline-state"></a>[Pipeline state]({{ site.baseurl }}/reference/languages/raw-raster.html#pipeline-state)
- <a id="alpha-compositing-and-transparency"></a>[Alpha, compositing, and transparency]({{ site.baseurl }}/reference/languages/raw-raster.html#alpha-compositing-and-transparency)
- <a id="layer-shaders"></a>[Layer shaders]({{ site.baseurl }}/reference/languages/raw-raster.html#layer-shaders)
- <a id="execution-models"></a>[Execution models]({{ site.baseurl }}/reference/languages/raw-raster.html#execution-models)
- <a id="primitive-data"></a>[Primitive data]({{ site.baseurl }}/reference/languages/raw-raster.html#primitive-data)
- <a id="clip-cull-and-depth-layout"></a>[Clip, cull, and depth layout]({{ site.baseurl }}/reference/languages/raw-raster.html#clip-cull-and-depth-layout)
- <a id="examples"></a>[Examples]({{ site.baseurl }}/reference/languages/raw-raster.html#examples)
- <a id="textured-mesh"></a>[Textured mesh]({{ site.baseurl }}/reference/languages/raw-raster.html#textured-mesh)
- <a id="procedural-points"></a>[Procedural points]({{ site.baseurl }}/reference/languages/raw-raster.html#procedural-points)
- <a id="cubemap-output"></a>[Cubemap output]({{ site.baseurl }}/reference/languages/raw-raster.html#cubemap-output)

## Related Processes

- [[ISF Shaders]]: Fullscreen fragment shaders.
- [[Compute Shaders]]: Generate images, buffers, geometry, and indirect commands.
- [[Model Display]]: Built-in renderer for geometry.
- [[Vertex Shader Art]]: Procedural vertex-based visuals.
- [[Object Loader]]: Load mesh assets for rendering.
- [[Shader cookbook]]: Source-based recipes for scenes, cubemap faces, layers, primitive data and transparency.
