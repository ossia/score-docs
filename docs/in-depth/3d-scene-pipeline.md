---
layout: default
title: 3D scene pipeline
description: "Choose between native scene, geometry, and Qt Quick 3D workflows"
parent: In depth
permalink: /in-depth/3d-scene-pipeline.html
---

# 3D scene pipeline

The native 3D processes described here follow the current development source. An older installed release may not contain every process. They are separate from the Qt Quick 3D renderer embedded in a JavaScript/QML process.

## Choose the representation

| Representation | Carries | Typical source and destination |
|---|---|---|
| Scene | Hierarchy, transforms, meshes, materials, animation, cameras, lights and environment | [[Asset Loader]] → scene tools → [[Scene Preprocessor]] |
| Geometry | Vertex/index buffers, attributes, draw ranges and optional auxiliary resources | [[Object loader]] or a primitive → [[Model display]] or [[Render Pipeline]] |
| Buffer | Typed bytes, without a complete mesh description | Array or compute output → geometry conversion or shader input |
| Texture | Image data or a GPU image resource | Image/video/shader → material, renderer or post-processing |

A geometry port can transport scene data internally, but this does not make every geometry consumer scene-aware. Use Scene Preprocessor as the explicit scene-to-renderable-geometry boundary. Use **PBR Mesh** to put a geometry source into a scene with a material. There is no library process named “Scene From Meshes”: that name belongs to an internal importer helper.

## A native scene patch

```text
Asset Loader → Animation Player → Material Override → Scene Group
Camera ────────────────────────────────────────────→ Scene Group
Light ─────────────────────────────────────────────→ Scene Group
Environment ───────────────────────────────────────→ Scene Group
Scene Group → Scene Preprocessor → Render Pipeline → texture output
```

1. Load a glTF/GLB or FBX asset with [[Asset Loader]]. Keep external texture and buffer files alongside assets that reference them.
2. Inspect names and paths with **Scene Inspector** before selecting or filtering objects. [[Scene tools]] operate on the hierarchy before flattening.
3. Drive **Animation Player**'s Time input for timeline-controlled animation. Apply transforms, retargeting or IK before preprocessing; see [[Scene animation]].
4. Combine models, camera and light contributions with **Scene Group**. Nest groups when more than four scene inputs are needed.
5. Use [[Scene Preprocessor]] to create GPU geometry with its scene resources. Connect a scene-aware [[Render Pipeline]] shader: preprocessing alone does not draw a picture or implement shading.
6. Send the renderer's texture through post-processing or to a graphics output.

A minimal geometry experiment is shorter: `Geometry Loader → Model Display`. For generated geometry with PBR material data, use `Cube → PBR Mesh → Scene Preprocessor → Render Pipeline`.

## Keep scene and shader responsibilities separate

- [[Instancing and materials]] author materials and instance data; the renderer must consume them.
- [[Cameras and lighting]] author cameras, light parameters and shadow-cascade data. A shadow-casting checkbox is not a shadow-map render pass.
- [[Environments and cubemaps]] route skybox and lighting resources. The native LDR image/cubemap loaders are not the HDR `.exr` loader used by Qt Quick 3D examples.
- [[Geometry and buffer utilities]] expose low-level data. Match element type, stride, offset, topology and shader semantics when reconstructing a mesh.
- [[Mesh generators and splats]] and [[3D text]] provide native geometry/scene sources.

Flattened geometry can contain multiple draws, each with its own transform and material. A custom scene shader must use the scene per-draw data rather than treating the whole asset as one `MODEL_MATRIX`; see [[Render Pipeline]].

## Qt Quick 3D examples are a different path

The [[glTF Scene with Effects]] and [[Sponza Palace]] downloads use QML `RuntimeLoader` inside Qt Quick 3D. Their cameras, materials, reflection probes and HDR environment handling belong to that renderer. They do not demonstrate Asset Loader or Geometry Loader accepting a full scene directly into Model Display. Recreating one in the native graph means authoring the scene, camera, environment and renderer connections above; it is not just a loader substitution.
