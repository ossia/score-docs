---
layout: default

title: Asset Loader
description: "Load 3D scenes, meshes, materials, textures, and animations"

parent: Processes
grand_parent: Reference

permalink: /processes/asset-loader.html
---

# Asset Loader

Asset Loader is the scene-oriented 3D file loader. It reads full assets into *score*'s scene representation: meshes, transforms, hierarchy, materials, textures, cameras / lights where supported, and animation data.

Use Asset Loader when the file is a scene. Use [[Object Loader]] when you only need simple mesh geometry.

The scene processes described here follow the current development build; they are not the Qt Quick 3D `RuntimeLoader` used by some older examples. See [[3D scene pipeline]] to choose the appropriate path.

## Supported formats

Asset Loader accepts these formats natively:

| Format | Backend | Notes |
|---|---|---|
| `.gltf`, `.glb` | fastgltf | glTF 2.0 scenes, buffers, images, node hierarchy, PBR material data, lights and material extensions where supported. |
| `.fbx` | ufbx | FBX scenes, hierarchy, animation data, and PBR / OpenPBR-style material properties where available. |
| `.obj` | tinyobjloader | Meshes converted into a scene. |
| `.ply` | miniply | Meshes and point-cloud-style data converted into a scene. |
| `.stl`, `.off` | vcglib | Mesh import with generated geometry data. |
| `.splat`, `.spz` | Gaussian splat loaders | Binary `.splat` and SPZ versions 1–3. SPZ v4 is not supported by the current decoder. |
| `.usd`, `.usda`, `.usdc`, `.usdz` | optional OpenUSD add-on | Available when the USD parser add-on is loaded. |

Unknown extensions can be handled by registered asset-loader plug-ins.

The PLY importer distinguishes polygon meshes from point/splat-shaped data by the file header. Choose a renderer appropriate to that representation; loading a point/splat asset does not turn it into a triangle mesh. MagicaVoxel `.vox` files use the separate **Voxel loader**, not Asset Loader; see [[Mesh generators and splats]].

## Controls

**Asset file** selects the asset. **Format override (auto if empty)** overrides the format identifier used for downstream routing; normally leave it empty for automatic identification. Like **Tag As Format**, this is a label for compatible data, not a file conversion or a way to bypass an unsupported decoder.

## Outputs and downstream processes

Asset Loader publishes a scene. Common downstream paths:

```text
[Asset Loader] -> [Scene Preprocessor] -> [Render Pipeline]
[Asset Loader] -> [Scene Filter] -> [Scene Preprocessor] -> [Render Pipeline]
[Asset Loader] -> [Animation Player] -> [Scene Preprocessor]
```

The scene path preserves information that plain geometry cannot express: hierarchy, material slots, textures, cameras, lights, animation channels, skinning data, and per-draw metadata.

## Scene rendering path

A typical custom renderer uses these stages:

1. **Asset Loader** reads the file and outputs a scene.
2. **Scene Filter** keeps visible nodes, while **Scene Graph Filter** and related [[Scene tools]] select by node paths, names, components and material properties. Use separate transform and material processes to modify those properties.
3. **Scene Preprocessor** flattens the scene into GPU-resident geometry and auxiliary data.
4. **Render Pipeline** draws the flattened scene with a raw raster shader.

Flattened scenes provide auxiliary buffers and textures to raw raster shaders, including per-draw transforms, material indices, material texture pools, scene counts, lights, camera data, environment maps, and shadow data depending on the patch.

For a scene raw raster shader, do not use `MODEL_MATRIX` for per-object placement. Read the per-draw model matrix from the scene auxiliary buffer. See [[Render Pipeline]] for the raw raster scene-path example.

## Materials and textures

The glTF path supports the PBR material model and several KHR material extensions. The FBX path maps FBX / OpenPBR-style properties to *score* scene material data where possible. Material textures can be packed into GPU texture pools by the scene preprocessing path and sampled by raw raster shaders as auxiliary textures.

## Animation

Use **Animation Player** before preprocessing to sample imported channels. Drive its **Time** input explicitly for timeline-controlled playback; see [[Scene animation]] for clip selection, clock behavior, IK and retargeting.

## Related Processes

- [[Object Loader]]: Simple mesh / point-cloud geometry loading.
- [[Model Display]]: Quick rendering for geometry outputs.
- [[Render Pipeline]]: Custom scene and geometry rendering.
- [[Compute Shaders]]: Geometry generation and filtering.
- [[Graphics pipeline]]: Overview of the GPU graph.
- [[Scene tools]]: Inspect names, select subtrees and group scene contributions.
- [[Instancing and materials]]: Add live textures, override materials and create GPU instances.
- [[Cameras and lighting]] and [[Environments and cubemaps]]: Supply scene camera, lighting and environment resources.
