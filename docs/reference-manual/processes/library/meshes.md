---
layout: default
title: Mesh generators and splats
description: "Native primitives, voxel geometry, mesh deformation and Gaussian splats"
parent: Processes
grand_parent: Reference
permalink: /processes/meshes.html
---

# Mesh generators and splats

These sources complement [[Object loader]] (the current **Geometry Loader**) and [[Asset Loader]]. Geometry sources can feed [[Model display]] directly or enter the scene path through **PBR Mesh**; see [[Instancing and materials]].

## Primitive

The registered primitive generators are **Plane**, **Cube**, **Sphere**, **Icosahedron**, **Cylinder**, **Cone** and **Torus**. They emit **Geometry** and provide **Position**, **Rotation** and **Scale** controls.

| Process | Shape controls |
|---|---|
| Plane | H divs. and V divs. control the grid density. |
| Cube | Transform controls place and scale the box. |
| Sphere | Subdivisions controls tessellation. |
| Icosahedron | Transform controls place and scale the polyhedron. |
| Cylinder | Slices and Stacks control tessellation. |
| Cone | Subdivisions, R1, R2 and Height control the cone/frustum. |
| Torus | R1 and R2 set radii; H Divisions controls tessellation. |

Start with modest tessellation. More vertices increase deformation, upload and rendering costs. Use **PBR Mesh** to add a material and scene membership; a primitive alone is geometry, not a complete lit scene.

## Mesh Noise

Deform incoming **Geometry**, with separate **Deformation X/Y/Z** choices and **Intensity X/Y/Z** controls. It emits modified **Geometry**. Use it for procedural displacement of an existing mesh; it does not replace a topology-aware modeling tool. A subdivided source gives displacement more vertices to work with.

## Voxel loader

Load a MagicaVoxel `.vox` file through **Voxel file**. **Mode** selects Point Cloud, Mesh (Simple) or Mesh (Greedy). Point Cloud represents occupied voxels as points; the mesh modes create faces, with greedy meshing combining compatible faces. **Position**, **Rotation** and **Scale** place the **Geometry** output.

Dragging a `.vox` file creates this geometry loader, not Asset Loader. Use Model Display's point mode for the point-cloud representation, or triangle mode for a mesh.

## Splat loader

Load a Gaussian-splat PLY asset through **3DGS PLY file**, producing an **Output** buffer. This is a specialized 3DGS loader: an ordinary polygon PLY mesh is not interchangeable with a Gaussian-splat dataset.

Connect the buffer to **Splat** for the dedicated viewer path. This differs from Asset Loader's scene-based `.ply`, `.splat` and `.spz` path; those scene representations need a compatible scene/render-pipeline workflow.

## Splat

The **Splat** process renders Gaussian-splat buffer data to a texture. It provides object **Position**, **Rotation**, **Scale**, **Camera position**, **Camera direction**, **FOV**, **Near/Far** and a **Camera** projection selector. Send its texture output to a window or post-processing chain.

```text
Splat loader → Splat → texture output
```

Do not use Model Display as a drop-in splat renderer: a splat's covariance, opacity and color data require the appropriate splat rendering path. For binary `.splat` and compressed `.spz` import, see [[Asset Loader]], including its format-version limitations.

## Other geometry sources

- [[Structure Synth]] generates meshes from EisenScript.
- [[3D text]] creates triangulated text scenes or text textures.
- [[Geometry and buffer utilities]] converts arrays and raw point buffers to geometry and describes their required layouts.
- [[Compute Shaders]] generates or filters geometry on the GPU.
