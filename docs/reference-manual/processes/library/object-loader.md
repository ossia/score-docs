---
layout: default

title: Object loader
description: "Load mesh geometry files"

parent: Processes
grand_parent: Reference

permalink: /processes/object-loader.html
---

# Object Loader

![Object loader]({{ site.img }}/reference/processes/object-filter.png "Object loader")

This page covers the process historically called Object Loader. In current development builds its library name is **Geometry Loader**. It loads mesh files and outputs geometry for *score*'s graphics pipeline. Use it for direct mesh / point-cloud workflows with [[Model display]], [[Render Pipeline]], [[Compute Shaders]] or geometry utilities.

For full 3D scene files with materials, lights, animation, skinning, and hierarchy, use [[Asset Loader]] when available.

## Supported formats

The geometry loader supports:

| Format | Notes |
|---|---|
| `.obj` | Wavefront OBJ through tinyobjloader. Positions, normals, colors, texture coordinates, multiple mesh parts. |
| `.ply` | PLY through miniply. Meshes and point clouds, common point attributes and aliases such as intensity / confidence. |
| `.stl` | STL through vcglib. Triangle meshes with generated normals. |
| `.off` | OFF through vcglib. Meshes with optional colors. |

Loaded meshes are converted to *score* geometry buffers with standard semantics such as position, normal, color, and texture coordinate.

## Parameters

| Parameter | Type | Description |
|---|---|---|
| 3D File | File input | Select the mesh file. |
| Position | 3D vector | Translation applied to the loaded geometry. |
| Rotation | 3D vector | Euler rotation in degrees. |
| Scale | 3D vector | Per-axis scale. |

The output is a dynamic geometry collection that can be rendered directly or modified by CSF geometry filters.

## Usage

```text
[Object Loader] -> [Model Display] -> [Window]
[Object Loader] -> [Compute Shader geometry filter] -> [Render Pipeline]
```

## Object Loader vs Asset Loader

| Process | Use it for |
|---|---|
| Object Loader | Simple mesh / point-cloud files; direct geometry output; shader experiments. |
| Asset Loader | glTF / GLB / FBX / scene assets; materials; textures; lights; animation; scene graph workflows. |

For MagicaVoxel `.vox` files use **Voxel loader**, documented in [[Mesh generators and splats]]. To give ordinary geometry a PBR material and enter the native scene workflow, connect it to **PBR Mesh**; see [[Instancing and materials]] and [[3D scene pipeline]].

## Related Processes

- [[Model Display]]: Quick geometry rendering.
- [[Render Pipeline]]: Custom rendering of loaded geometry.
- [[Compute Shaders]]: Geometry generation and filtering.
- [[Structure Synth]]: Procedural geometry.
