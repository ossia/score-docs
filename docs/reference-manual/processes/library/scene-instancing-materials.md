---
layout: default
title: Instancing and materials
description: "Wrap meshes in PBR scenes, override materials and author GPU instances"
parent: Processes
grand_parent: Reference
permalink: /processes/scene-instancing-materials.html
---

# Instancing and materials

These processes author scene data; they do not output a rendered image. Connect their scene output to [[Scene Preprocessor]] and a scene-aware [[Render Pipeline]].

## PBR Mesh

Turn a geometry source into a scene mesh with a PBR material. Connect a primitive, [[Object loader]] or compute-generated geometry to **Mesh**. The output is **Scene Out**.

Optional **Base Color Tex**, **Metal Rough Tex**, **Normal Tex** and **Emissive Tex** inputs supply material textures. **Color R/G/B/A**, **Metallic**, **Roughness**, **Emissive R/G/B** and **Emissive strength** supply material factors. **Position**, **Rotation** and **Scale** place the resulting scene node.

```text
Sphere → PBR Mesh → Scene Preprocessor → Render Pipeline
Image loader (LDR) → Base Color Tex [PBR Mesh]
```

This is the user-facing geometry-to-scene bridge. A geometry's vertex attributes still need to meet the renderer's needs: adding a normal texture does not invent a useful UV layout for an arbitrary point cloud.

## Material Override

Modify materials in **Scene In** without reloading the asset. **Mode** selects All materials or By Index; **Index** is a zero-based material-table index, not a node number.

Wire replacement **Base Color Tex**, **Metal Rough Tex**, **Normal Tex** or **Emissive Tex** inputs to substitute image, video or shader textures. Unwired texture inputs preserve the original texture. Enable **Use base color**, **Use metallic**, **Use roughness** or **Use emissive** before their corresponding numeric controls take effect; disabled factor overrides preserve the imported values.

Use this after [[Asset Loader]] to put a live texture on an imported model. Shared materials can affect more than one visible object; selecting a material index is not equivalent to selecting one node.

## Instancer

Repeat a scene mesh using per-instance data, rather than creating many separate CPU scene nodes. Connect the prototype to **Scene In** and instance data to **Transforms**, optionally **Colors** and **Custom**. Set **Format** to match the transform buffer: `mat4`, `trs` or `translation`, and set **Count** to the number of instances.

The optional **Points** geometry input can instead provide named attributes: `translation`/`position`, `transform_matrix` and `color0`. When used, its vertex count determines the instance count and the relevant attributes take precedence over the raw buffers. This makes point-cloud or compute-generated distributions useful as instance layouts.

**Position**, **Rotation** and **Scale** place the prototype before instancing. **Per-instance transform** chooses Full matrix or Translation only. The scene output carries instance transforms, colors and custom data for downstream rendering; the shader must use the instance data it needs.

Use **Scene Duplicator** for separately addressable copies of a rich hierarchy with multiple meshes and lights. Use Instancer for large repeated-mesh populations. See [[Scene tools]] and [[Geometry and buffer utilities]] for constructing and inspecting the inputs.
