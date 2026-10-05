---
layout: default
title: Environments and cubemaps
description: "Load images, compose cubemaps and route native scene resources"
parent: Processes
grand_parent: Reference
permalink: /processes/scene-environment.html
---

# Environments and cubemaps

These processes provide environment settings and textures. Connect scene contributions to [[Scene Preprocessor]] with the rest of the scene, or connect resource outputs to compatible shader inputs.

## Environment

Environment emits a Scene with Ambient Color, Ambient Intensity, Exposure EV100, Exposure (stops), Gamma, and optional Fog with Fog Color, Fog Start and Fog End. Render target size supplies an explicit width/height override; leave it zero to use the rendering context's dimensions.

The downstream scene shader interprets these settings. Environment does not load an image or draw a skybox.

## Native image loader

Load a 2D image through Image and emit a GPU Texture. The advertised extensions are PNG, JPG/JPEG, BMP, TGA, WebP and TIF/TIFF. The loader uses Qt image decoding with a TGA fallback and produces an 8-bit RGBA texture.

Use it for PBR Mesh or Material Override texture inputs, shader inputs or the faces of a cubemap. Floating-point HDR loading requires a separate image loader, such as the OpenImageIO-backed process.

## Native cubemap loader

Select an Image and choose its Layout (Equirectangular, HorizontalCross, VerticalCross, HorizontalStrip or VerticalStrip) and Resolution. The native cubemap loader converts the source into a cubemap and emits both Cubemap and Scene outputs. The scene contribution sets a skybox resource; the cubemap output can feed a cube-sampler shader directly.

This path uses 8-bit LDR storage and the same advertised image formats as the native image loader. It does not load floating-point `.hdr` or `.exr` environments. Qt Quick 3D's HDR light probes use a separate loading and rendering path.

## Cubemap Composer

Connect six texture inputs labeled +X, -X, +Y, -Y, +Z and -Z. The outputs are Cubemap and a skybox Scene contribution. Source images are scaled to a common square face size.

For cubemaps captured from a 3D scene, supply the six rendered views using a Camera Array and render pipeline.

## Scene Resource Route

Connect a GPU Texture and select Target Field to emit a partial Scene contribution. Targets are Skybox, IrradianceMap, PrefilteredMap, BRDFLut and ShadowMapArray. The texture kind must match the destination:

| Destination | Required texture kind |
|---|---|
| Skybox, IrradianceMap, PrefilteredMap | Cubemap |
| BRDFLut | 2D texture |
| ShadowMapArray | Texture array |

This routes an existing resource; irradiance computation, environment prefiltering and shadow-map rendering belong to the render pipeline.

For arbitrary named resources rather than predefined environment fields, see Inject Texture and Inject Buffer in [[Geometry and buffer utilities]]. See [[Cameras and lighting]] for scene capture and shadow setup.
