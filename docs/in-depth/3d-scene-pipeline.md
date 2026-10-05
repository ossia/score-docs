---
layout: default
title: 3D scene pipeline
description: "Choose between native scene, geometry, and Qt Quick 3D workflows"
parent: In depth
permalink: /in-depth/3d-scene-pipeline.html
---

# 3D scene pipeline

score offers a native 3D scene pipeline alongside the Qt Quick 3D renderer available through JavaScript/QML.

## Choose the representation

| Representation | Carries | Typical source and destination |
|---|---|---|
| Scene | Hierarchy, transforms, meshes, materials, animation, cameras, lights and environment | [[Asset Loader]] → scene tools → [[Scene Preprocessor]] |
| Geometry | Vertex/index buffers, attributes, draw ranges and optional auxiliary resources | [[Object loader]] or a primitive → [[Model display]] or [[Render Pipeline]] |
| Buffer | Typed bytes, without a complete mesh description | Array or compute output → geometry conversion or shader input |
| Texture | Image data or a GPU image resource | Image/video/shader → material, renderer or post-processing |

A geometry port can transport scene data internally. Use Scene Preprocessor to turn a scene into renderable geometry, and PBR Mesh to put a geometry source into a scene with a material.

## A native scene patch

```text
Asset Loader → Material Override → Scene Preprocessor → Render Pipeline → texture output
```

1. Load a glTF/GLB or FBX asset with [[Asset Loader]]. Keep external texture and buffer files alongside assets that reference them.
2. Use [[Scene tools]] to select or transform objects in the hierarchy and [[Instancing and materials]] to change their appearance.
3. Use [[Scene Preprocessor]] to create GPU geometry with its scene resources. Connect it to a scene-aware [[Render Pipeline]] shader.
4. Send the renderer's texture through post-processing or to a graphics output.

A minimal geometry experiment is shorter: `Geometry Loader → Model Display`. For generated geometry with PBR material data, use `Cube → PBR Mesh → Scene Preprocessor → Render Pipeline`.

## Keep scene and shader responsibilities separate

- [[Instancing and materials]] author materials and instance data; the renderer must consume them.
- [[Cameras and lighting]] supply cameras, light parameters and shadow-cascade data. The renderer supplies the shadow-map passes.
- [[Environments and cubemaps]] provide skybox and lighting resources. The native cubemap loader uses 8-bit LDR images; Qt Quick 3D examples can instead use HDR `.exr` light probes.
- [[Geometry and buffer utilities]] expose low-level data. Match element type, stride, offset, topology and shader semantics when reconstructing a mesh.
- [[Mesh generators and splats]] and [[3D text]] provide native geometry/scene sources.

Flattened geometry can contain multiple draws, each with its own transform and material. A custom scene shader must use the scene per-draw data rather than treating the whole asset as one `MODEL_MATRIX`; see [[Render Pipeline]].

## Qt Quick 3D examples are a different path

The [[glTF Scene with Effects]] and [[Sponza Palace]] downloads use QML `RuntimeLoader` inside Qt Quick 3D. Their cameras, materials, reflection probes and HDR environments belong to that renderer. Native scene patches use Asset Loader, Scene Preprocessor and Render Pipeline instead.
