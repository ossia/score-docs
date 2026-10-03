---
layout: default
title: Scene Preprocessor
description: "Flatten a native scene into GPU geometry and scene resources"
parent: Processes
grand_parent: Reference
permalink: /processes/scene-preprocessor.html
---

# Scene Preprocessor

Scene Preprocessor is the boundary between a native scene graph and the GPU geometry used by a renderer. It traverses the scene hierarchy, resolves transforms and draw data, and prepares geometry with auxiliary buffers and textures. It does not render a texture itself.

| Port | Role |
|---|---|
| Scene In | Scene contributions from loaders, scene filters, cameras, lights and environment tools. |
| Geometry Out | Flattened geometry, with material texture pools and scene resources attached. |

Use it after [[Asset Loader]], animation and hierarchy edits, and before a scene-aware [[Render Pipeline]]. Camera, environment and scene buffers, material texture arrays and a skybox travel with the geometry: shader bindings can resolve them by name without separate resource cables. Their presence depends on the incoming scene.

```text
Asset Loader → Scene Graph Filter → Scene Preprocessor → Render Pipeline
```

Use **Flattened Scene Filter** after this process when splitting draws by material, tag, topology or render state. Use **Scene Graph Filter** before it when selecting by node path, name or component. These are different stages; see [[Scene tools]].

A shader written for a single mesh is not automatically a scene renderer. It must use per-draw transforms and materials and consume the auxiliary data it needs. [[Model display]] is a quick geometry viewer, not a replacement for a complete scene-aware material shader.

See [[3D scene pipeline]] for a complete wiring overview and [[Geometry and buffer utilities]] for explicit extraction of auxiliary resources.
