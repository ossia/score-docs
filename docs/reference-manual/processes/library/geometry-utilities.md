---
layout: default
title: Geometry and buffer utilities
description: "Convert, inspect and route mesh, buffer, array and texture data"
parent: Processes
grand_parent: Reference
permalink: /processes/geometry-utilities.html
---

# Geometry and buffer utilities

Use these tools at the boundaries between value arrays, GPU buffers, geometry and textures. A buffer contains bytes, not a self-describing mesh. Its element type, stride, offset and count must agree with the consumer. Start with a small dataset and inspect the result before increasing counts.

## Choose a conversion path

| Starting data | Goal | Process |
|---|---|---|
| XYZ value array | Geometry positions or reconstructed surface | [[Array to mesh]] |
| Numeric pixel array | Texture | [[Array to texture]] |
| GPU vertex/index buffers | Geometry with an explicit layout | [[Buffers to geometry]] |
| Geometry | One attribute or an existing buffer | [[Extract buffer]] |
| Geometry | A new interleaved attribute buffer | [[Repack attributes]] |
| Texture | Pixel bytes in a GPU buffer | [[Texture to buffer]] |
| Geometry | Counts and layout diagnostics | [[Geometry Info]] |

Keep resource boundaries explicit: value arrays live on the CPU, buffers contain typed-by-convention bytes, geometry adds a draw description, and scenes carry hierarchy and resources. The individual references above are the canonical control and port manuals; the sections below locate them within a workflow.

## Array to buffer and Buffer to array

**Array to buffer** accepts a numeric array or string on **Input** and exposes it as **Output** buffer data. **Type** selects Float32, Float64, signed/unsigned 32-bit, 16-bit or 8-bit elements. Numeric values are converted to that type; strings supply bytes.

**Buffer to array** performs the opposite boundary crossing. Set **Type** to the buffer's actual element representation; **Mode** selects FloatArray, IntArray or String on **Output**. Reading GPU-produced data into a value array introduces a readback path: keep calculations on the GPU when a CPU array is not needed.

## Array to mesh

See [[Array to mesh]] for the XYZ-array contract, placement controls and limits of its optional surface reconstruction. For explicit attribute layouts, use [[Buffers to geometry]] instead.

## Pointcloud to mesh

Wrap a **Buffer** in a point-cloud geometry description. **Buffer type** selects `XYZ`, `XYZ_RGB`, `XYZW` or `XYZW_RGBA`; choose the format actually produced upstream. **Position**, **Rotation** and **Scale** control placement. Despite the name, this supplies renderable point geometry; it is not a surface-reconstruction algorithm.

## Buffers to geometry

See [[Buffers to geometry]] for named-semantic attribute setup, indexed draws, instances and topology. Its reference also distinguishes the separately registered **Buffers to geometry (v1)**, which uses numeric attribute locations.

## Extract buffer

See [[Extract buffer]] for semantic/index selection and vec3 padding. Use the by-name variant below when selecting custom names or scene auxiliary resources.

## Extract buffer (by name)

**Mode** selects Attribute or Buffer, and **Name / index** identifies the resource:

- Attribute mode accepts semantics such as `position`, `normal`, `tangent`, `texcoord0`, `color0`, a numeric attribute index or a custom attribute name.
- Buffer mode accepts a numeric buffer index, `index` for the index buffer, an auxiliary-buffer name, or an attribute name to retrieve its containing buffer.

Auxiliary names allow explicit access to resources carried by [[Scene Preprocessor]] output. Selecting a whole buffer is different from extracting one tightly packed attribute from an interleaved buffer.

## Repack attributes

See [[Repack attributes]] for attribute selection, packing order and the byte-stride outlet. This creates a new layout rather than selecting a whole existing buffer.

## Merge Geometries

Combine eight **Geometry 1–8** inputs into **Merged**. This composes geometry draws and their transforms; it does not weld vertices, perform a boolean union or create a new scene hierarchy. Use Scene Group for hierarchy composition.

## Array to texture

See [[Array to texture]] for pixel component counts, formats and numeric ranges. It uploads numeric pixels, not encoded image-file bytes.

## Texture to buffer

See [[Texture to buffer]] for the pixel-byte transfer path and downstream layout requirements. It does not create mesh attributes and is not the direct inverse of Array to texture.

## Inject Buffer and Inject Texture

Both take **Scene In**, a **Buffer** or **Texture**, and an **Aux name**, then emit **Scene Out** carrying the named auxiliary resource. Use these before Scene Preprocessor to pass custom resources alongside a scene. An unwired resource input leaves the scene unchanged. These tools do not replace material textures; use Material Override for that operation.

## Extract Scene Buffer

Read a GPU-backed **Buffer** from **Scene In**. **Kind** selects Environment, Camera or Material. **Index** selects the camera/material entry and is ignored for Environment. This exposes existing scene resource storage, not an arbitrary serialization of the hierarchy; an absent or unavailable resource cannot produce usable bytes.

## Extract texture (by name)

Read an auxiliary texture from **Geometry**, using **Name** (for example `skybox`), and output **Texture**. Use this after preprocessing when another consumer needs a scene-carried texture explicitly. A 2D texture, cubemap and texture array are different resource kinds: the receiving shader must agree with the extracted resource.

## Geometry Info, Buffer Info and Texture Info

| Process | Input | Outputs useful for debugging |
|---|---|---|
| [[Geometry Info]] | Geometry | Integer counts, structured attribute/binding/input lists and a Readable layout report; see its reference for details. |
| Buffer Info | Buffer | Byte size, Byte offset, Handle, Changed and Readable summary. |
| Texture Info | Texture | Width, Height, Format, Handle and Readable summary. |

Handles are opaque resource identities for diagnostics, not stable values to save and reuse in another run. Connect Readable to a value display to troubleshoot an empty or incorrectly interpreted draw.

See [[Compute Shaders]], [[Render Pipeline]], [[Mesh generators and splats]] and [[3D scene pipeline]] for consumers and end-to-end workflows.
