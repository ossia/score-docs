---
layout: default
title: Environments and cubemaps
description: "Load images, compose cubemaps and route native scene resources"
parent: Processes
grand_parent: Reference
permalink: /processes/scene-environment.html
---

# Environments and cubemaps

These processes provide settings or resources to a renderer. Combine scene contributions with **Scene Group** before [[Scene Preprocessor]], or connect the resource outputs to compatible shader inputs.

## Environment

The library process is named **Environment**, not “Environment Loader”. It emits a **Scene** with **Ambient Color**, **Ambient Intensity**, **Exposure EV100**, **Exposure (stops)**, **Gamma**, and optional **Fog** with **Fog Color**, **Fog Start** and **Fog End**. **Render target size** supplies an explicit width/height override; leave it zero to use the rendering context's dimensions.

Environment does not load an HDR image or render a skybox itself. These settings must be interpreted by the downstream scene shader. For example, changing fog controls has no visible effect in a shader that ignores scene fog data.

## Image loader (LDR)

Load a 2D image through **Image** and emit a GPU **Texture**. The advertised extensions are PNG, JPG/JPEG, BMP, TGA, WebP and TIF/TIFF; decoding depends on available Qt image handlers. The result is an 8-bit RGBA texture, not a floating-point HDR texture.

Use it for PBR Mesh or Material Override texture inputs, shader inputs or the faces of a cubemap. It is distinct from the existing image-display process and from Qt Quick 3D's image loading.

## Cubemap Loader

Select an **Image** and choose its **Layout** (Equirectangular, HorizontalCross, VerticalCross, HorizontalStrip or VerticalStrip) and **Resolution**. The loader converts the source into a cubemap and emits both **Cubemap** and **Scene** outputs. The scene contribution sets a skybox resource; the cubemap output can feed a cube-sampler shader directly.

This is an **LDR** image path using 8-bit storage. Do not assume `.hdr` or `.exr` support because a Qt Quick 3D example uses an HDR light probe. Cubemap resolution is subject to GPU allocation limits.

## Cubemap Composer

Connect six texture inputs labeled **+X**, **-X**, **+Y**, **-Y**, **+Z** and **-Z**. The outputs are **Cubemap** and a skybox **Scene** contribution, as with Cubemap Loader. Source images are scaled to a common square face size, so supply consistently oriented square faces when avoiding resampling/distortion matters.

The composer assembles supplied images; it does not capture a 3D scene automatically. Use a suitable Camera Array and render pipeline when the images should come from six scene views.

## Scene Resource Route

Connect a GPU **Texture** and select **Target Field** to emit a partial **Scene** contribution. Targets are Skybox, IrradianceMap, PrefilteredMap, BRDFLut and ShadowMapArray. The texture kind must match the destination:

| Destination | Required texture kind |
|---|---|
| Skybox, IrradianceMap, PrefilteredMap | Cubemap |
| BRDFLut | 2D texture |
| ShadowMapArray | Texture array |

This routes an existing resource; it does not compute irradiance, prefilter an environment or render a shadow map. Combine the result with the rest of the scene and ensure the shader consumes the corresponding field.

For arbitrary named resources rather than predefined environment fields, see **Inject Texture** and **Inject Buffer** in [[Geometry and buffer utilities]]. See [[Cameras and lighting]] for scene capture and shadow setup.
