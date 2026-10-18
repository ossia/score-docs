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

## Related Processes

- [[ISF Shaders]]: Fullscreen fragment shaders.
- [[Compute Shaders]]: Generate images, buffers, geometry, and indirect commands.
- [[Model Display]]: Built-in renderer for geometry.
- [[Vertex Shader Art]]: Procedural vertex-based visuals.
- [[Object Loader]]: Load mesh assets for rendering.
- [[Shader cookbook]]: Source-based recipes for scenes, cubemap faces, layers, primitive data and transparency.
