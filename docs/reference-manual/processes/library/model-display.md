---
layout: default

title: Model display
description: "Display and texture 3D geometry"

parent: Processes
grand_parent: Reference

permalink: /processes/model-display.html
---

# Model Display


Model Display is the quick renderer for geometry ports. Connect geometry from [[Object loader]], a primitive generator, [[Structure Synth]], [[Compute Shaders]] or a geometry filter, optionally connect a texture, and render the result to a texture output. Native scenes from [[Asset Loader]] first need [[Scene Preprocessor]]; Model Display does not implement the complete imported scene material/lighting workflow.

Use [[Render Pipeline]] instead when you need custom vertex / fragment shaders, custom raster state, scene auxiliary buffers, cubemaps, multiview, or advanced material logic.

## Ports

| Port | Type | Description |
|---|---|---|
| Texture In | Texture input | Optional image / video / shader texture applied to the geometry. |
| Geometry In | Geometry input | Mesh, point cloud, primitive, CSF geometry, or converted scene geometry. |
| Texture Out | Texture output | Rendered result. Connect it to a window, shader, recorder, or another texture consumer. |

## Camera controls

| Control | Description |
|---|---|
| Position | Camera position. Default looks from `(-1, -1, -1)` toward the center. |
| Center | Camera look-at target. |
| FOV | Field of view in degrees. |
| Near / Far | Near and far clipping planes. |
| Camera | Projection model: Perspective, Fulldome equidistant, Fulldome equisolid, Fulldome stereographic, or Fulldome orthographic. |

Fulldome modes render fisheye-style output for dome projection workflows.

## Drawing controls

| Control | Description |
|---|---|
| Tex. Proj. | Texture projection mode. |
| Mode | Triangles, Points, or Lines. |
| Enable blend and blend factors | Optional fixed-function alpha blending. |

Texture projection modes include:

- Texture coordinates: use mesh UVs.
- Spherical: generate spherical coordinates.
- View-space: project from view position.
- Barycentric: show triangle barycentric coordinates.
- Funky A / Funky B: procedural projections.
- Light: lighting-oriented projection.
- Color: prefer geometry vertex colors.

When the input geometry has vertex colors, texture projection remains available instead of being discarded in favor of the vertex-color path.

## Typical patches

```text
[Object Loader] -> [Model Display] -> [Window]
[ISF Shader] -> Texture In [Model Display]
[Compute Shader geometry] -> [Model Display]
```

For custom materials:

```text
[Geometry source] -> [Render Pipeline]
[Texture / cubemap / buffers] -> [Render Pipeline]
```

## Related Processes

- [[Object Loader]]: Load mesh files as geometry.
- [[Compute Shaders]]: Generate or filter GPU geometry.
- [[Render Pipeline]]: Custom raw raster rendering.
- [[ISF Shaders]]: Texture generation and post-processing.
- [[3D scene pipeline]]: Choose between scene-aware rendering and direct geometry viewing.
