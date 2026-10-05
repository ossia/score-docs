---
layout: default
title: Instancing and materials
description: "Wrap meshes in PBR scenes, override materials and author GPU instances"
parent: Processes
grand_parent: Reference
permalink: /processes/scene-instancing-materials.html
---

# Instancing and materials

These processes create or modify scene data. Connect their scene output to [[Scene Preprocessor]] and a scene-aware [[Render Pipeline]] to render it.

## PBR Mesh

Turn a geometry source into a scene mesh with a PBR material. Connect a primitive, [[Object loader]] or compute-generated geometry to Mesh. The output is Scene Out.

Optional Base Color Tex, Metal Rough Tex, Normal Tex and Emissive Tex inputs supply material textures. Color R/G/B/A, Metallic, Roughness, Emissive R/G/B and Emissive strength supply material factors. Position, Rotation and Scale place the resulting scene node.

```text
Sphere → PBR Mesh → Scene Preprocessor → Render Pipeline
Native image loader → Base Color Tex [PBR Mesh]
```

The source geometry must provide the vertex attributes required by the renderer, including UV coordinates for texture mapping.

## Material Override

Modify materials in Scene In without reloading the asset. Mode selects All or By Index; Index is a zero-based material-table index.

Wire replacement Base Color Tex, Metal Rough Tex, Normal Tex or Emissive Tex inputs to substitute image, video or shader textures. Unwired texture inputs preserve the original texture. Enable Use base color, Use metallic, Use roughness or Use emissive to apply the corresponding numeric controls.

Use this after [[Asset Loader]] to put a live texture on an imported model. A material can be shared by several objects, so overriding it changes all objects that use it.

## Instancer

Repeat a scene mesh using per-instance data. Connect the prototype to Scene In and instance data to Transforms, optionally Colors and Custom. Set Format to match the transform buffer: `mat4`, `trs` or `translation`, and set Count to the number of instances.

The optional Points geometry input can instead provide named attributes: `translation`/`position`, `transform_matrix` and `color0`. Its vertex count determines the instance count, and the relevant attributes take precedence over the raw buffers.

Position, Rotation and Scale place the prototype before instancing. Per-instance transform chooses Full matrix or Translation only. The scene output carries instance transforms, colors and custom data for the shader to consume.

Use Scene Duplicator for separately addressable copies of a hierarchy with multiple meshes and lights. Use Instancer for large repeated-mesh populations. See [[Scene tools]] and [[Geometry and buffer utilities]] for constructing the inputs.
