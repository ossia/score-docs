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

## Array to buffer and Buffer to array

**Array to buffer** accepts a numeric array or string on **Input** and exposes it as **Output** buffer data. **Type** selects Float32, Float64, signed/unsigned 32-bit, 16-bit or 8-bit elements. Numeric values are converted to that type; strings supply bytes.

**Buffer to array** performs the opposite boundary crossing. Set **Type** to the buffer's actual element representation; **Mode** selects FloatArray, IntArray or String on **Output**. Reading GPU-produced data into a value array introduces a readback path: keep calculations on the GPU when a CPU array is not needed.

## Array to mesh

Interpret **Input** as consecutive XYZ triples: `[x0, y0, z0, x1, y1, z1, …]`. Supply complete triples. **Triangulate** requests surface reconstruction from the points; otherwise the points supply the geometry positions. **Position**, **Rotation** and **Scale** place the output.

This is not an importer for arbitrary indexed-mesh JSON. Use **Buffers to geometry** when you already have vertex/index buffers and a known layout.

## Pointcloud to mesh

Wrap a **Buffer** in a point-cloud geometry description. **Buffer type** selects `XYZ`, `XYZ_RGB`, `XYZW` or `XYZW_RGBA`; choose the format actually produced upstream. **Position**, **Rotation** and **Scale** control placement. Despite the name, this supplies renderable point geometry; it is not a surface-reconstruction algorithm.

## Buffers to geometry

Connect up to eight inputs, **Buffer 0–7**, and describe up to eight attributes. Each attribute has a buffer selection, byte offset, byte stride, data format, semantic and instanced flag. Configure **Index Buffer**, **Index Format** and **Index Offset** when using indexed geometry, and set **Vertices** and **Instances** consistently with the data.

The current **Buffers to geometry** uses named semantics. **Buffers to geometry (v1)** is also registered for existing documents and uses numeric attribute locations instead. They are distinct library entries. Use the semantic version for new patches unless a specific existing layout requires the older one.

## Extract buffer

Select an **Attribute** from the incoming **Geometry** and emit a **Buffer**. **Pad vec3 to vec4** changes three-component attributes into four-component records when required by a downstream buffer layout. Account for that changed stride in the consumer.

## Extract buffer (by name)

**Mode** selects Attribute or Buffer, and **Name / index** identifies the resource:

- Attribute mode accepts semantics such as `position`, `normal`, `tangent`, `texcoord0`, `color0`, a numeric attribute index or a custom attribute name.
- Buffer mode accepts a numeric buffer index, `index` for the index buffer, an auxiliary-buffer name, or an attribute name to retrieve its containing buffer.

Auxiliary names allow explicit access to resources carried by [[Scene Preprocessor]] output. Selecting a whole buffer is different from extracting one tightly packed attribute from an interleaved buffer.

## Repack attributes

Take **Geometry** and build a **Buffer** with a chosen packing for **Position**, **Normal**, **Color**, **TexCoord** and **Tangent**. The **Stride** outlet reports the resulting byte stride. Use this to match a downstream compute/raster layout rather than assuming every loader packs attributes identically.

## Merge Geometries

Combine eight **Geometry 1–8** inputs into **Merged**. This composes geometry draws and their transforms; it does not weld vertices, perform a boolean union or create a new scene hierarchy. Use Scene Group for hierarchy composition.

## Array to texture

Turn a float **Input** array into an image with **Size** and **Format**, emitted through **Output**. The selected format determines the pixel representation: the number of supplied values must match the intended image layout. This is useful for generated scalar/color fields, not encoded PNG/JPEG bytes.

## Texture to buffer

Expose a **Texture**'s pixel data as a GPU **Buffer**. It does not create position, normal or UV attributes. Match the texture's pixel format and dimensions when interpreting the bytes, and expect a transfer path rather than assuming a zero-copy GPU image alias.

## Inject Buffer and Inject Texture

Both take **Scene In**, a **Buffer** or **Texture**, and an **Aux name**, then emit **Scene Out** carrying the named auxiliary resource. Use these before Scene Preprocessor to pass custom resources alongside a scene. An unwired resource input leaves the scene unchanged. These tools do not replace material textures; use Material Override for that operation.

## Extract Scene Buffer

Read a GPU-backed **Buffer** from **Scene In**. **Kind** selects Environment, Camera or Material. **Index** selects the camera/material entry and is ignored for Environment. This exposes existing scene resource storage, not an arbitrary serialization of the hierarchy; an absent or unavailable resource cannot produce usable bytes.

## Extract texture (by name)

Read an auxiliary texture from **Geometry**, using **Name** (for example `skybox`), and output **Texture**. Use this after preprocessing when another consumer needs a scene-carried texture explicitly. A 2D texture, cubemap and texture array are different resource kinds: the receiving shader must agree with the extracted resource.

## Geometry Info, Buffer Info and Texture Info

| Process | Input | Outputs useful for debugging |
|---|---|---|
| Geometry Info | Geometry | Vertices, Indices, Instances, Attributes, Bindings, Inputs and Readable layout report. |
| Buffer Info | Buffer | Byte size, Byte offset, Handle, Changed and Readable summary. |
| Texture Info | Texture | Width, Height, Format, Handle and Readable summary. |

Handles are opaque resource identities for diagnostics, not stable values to save and reuse in another run. Connect Readable to a value display to troubleshoot an empty or incorrectly interpreted draw.

See [[Compute Shaders]], [[Render Pipeline]], [[Mesh generators and splats]] and [[3D scene pipeline]] for consumers and end-to-end workflows.
