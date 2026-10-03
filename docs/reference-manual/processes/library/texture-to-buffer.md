---
layout: default
title: Texture to buffer
description: "Transfer texture pixel bytes into a GPU buffer"
parent: Processes
grand_parent: Reference
permalink: /processes/texture-to-buffer.html
---

# Texture to buffer

**Texture to buffer** takes a **Texture** and exposes its pixel bytes through a GPU **Buffer** outlet. There are no user controls beyond the input connection.

The output buffer is suitable for storage-buffer or vertex-buffer consumers, but the bytes are still pixels. The process does not create position, normal or UV attributes, change the image format, or infer a mesh topology.

## Workflow

1. Connect the texture source to **Texture**.
2. Inspect its dimensions and format with **Texture Info** from [[Geometry and buffer utilities]].
3. Connect **Buffer** to a compute process, or to **Buffer to array** if CPU-side values are needed.
4. Configure the receiving process for the texture's actual component representation and byte layout.

For example, RGBA8 pixels are four 8-bit components, not four Float32 values. Treating those bytes as floats will not normalize or convert their colors. If you use [[Buffers to geometry]] downstream, explicitly describe how the pixel records should be interpreted and how many records to draw.

## Transfer and resource boundaries

The implementation uploads available texture pixel bytes into a separate GPU buffer. Do not assume this is a zero-copy alias of the original GPU image: a GPU-produced image can require readback before those bytes are available. The buffer size follows the input byte size.

This is **not** the direct inverse of [[Array to texture]], whose input is a CPU float value array. For numeric value access, add **Buffer to array** with the correct element type. Keep processing on the GPU when CPU readback is unnecessary; see [[Compute Shaders]] and [[Render Pipeline]].
