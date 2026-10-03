---
layout: default
title: Array to texture
description: "Upload numeric pixel arrays as textures"
parent: Processes
grand_parent: Reference
permalink: /processes/array-to-texture.html
---

# Array to texture

**Array to texture** turns a float value array into a texture. Use it for generated scalar fields, lookup tables or color data, not encoded PNG or JPEG file bytes.

## Ports and controls

| Port or control | Meaning |
|---|---|
| Input | Flat float array containing consecutive pixel components. |
| Size | Image width and height in pixels. |
| Format | Pixel storage format and channel count. |
| Output | Texture containing the uploaded pixel data. |

Supply `width × height × components` values. For example, **Size** `2 × 1` with **Format** `RGBA32F` expects eight values: `[1, 0, 0, 1, 0, 1, 0, 1]` describes a red pixel followed by a green pixel. Connect **Output** to a texture consumer in the [[Render Pipeline]].

## Formats and numeric ranges

The converter implements these storage formats:

- 8-bit components: RGBA8, BGRA8, R8, RG8, RED_OR_ALPHA8 and R8UI.
- 16-bit unsigned components: R16 and RG16.
- 32-bit unsigned components: R32UI, RG32UI and RGBA32UI.
- Floating-point components: R16F, RGBA16F, R32F and RGBA32F.

Values are converted directly to the destination component type: there is **no automatic 0–1 to 0–255 scaling** for 8-bit formats. Supply values in the format's representable range; for example, an RGBA8 red pixel is `[255, 0, 0, 255]`, not `[1, 0, 0, 1]`. Channel order follows the selected format, including BGRA rather than RGBA where selected.

Extra values are ignored after the image is full. A short array does not define all pixels, so do not rely on missing components being filled for you. Changes to **Input**, **Size** or **Format** recreate and upload the texture.

[[Texture to buffer]] produces GPU buffer bytes, not a float array, and is therefore not the direct inverse of this process. See [[Geometry and buffer utilities]] for CPU-array and GPU-buffer conversions.
