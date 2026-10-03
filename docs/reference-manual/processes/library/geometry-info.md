---
layout: default
title: Geometry Info
description: "Inspect geometry counts and structured vertex layout metadata"
parent: Processes
grand_parent: Reference
permalink: /processes/geometry-info.html
---

# Geometry Info

**Geometry Info** inspects one connected **Geometry** input. It reports the geometry description; it does not read back vertex values, render an image or pass the geometry through to another outlet.

## Outputs

| Output | Type and contents |
|---|---|
| Vertices | Integer vertex count from the geometry description. |
| Indices | Integer index count from the geometry description. |
| Instances | Integer instance count. |
| Attributes | Structured list of attribute descriptors: semantics, formats, bindings and offsets. **Not a count.** |
| Bindings | Structured list describing record strides, step rates and per-vertex/per-instance classification. **Not a count.** |
| Inputs | Structured list mapping bindings to buffer indices and byte offsets. **Not a count.** |
| Readable | Text summary of the counts and layout descriptors. |

## Diagnosing a draw

Branch a geometry producer to this process and connect **Readable** to a value display. Check:

1. Whether the reported counts match the intended draw.
2. Whether the expected position, normal, UV or color semantics exist.
3. Whether attribute formats and byte offsets agree with the producer's layout.
4. Whether binding strides and per-instance classification agree with the consumer.

The report describes metadata, not proof that all referenced buffer bytes are valid. For example, [[Buffers to geometry]] uses your explicit layout settings rather than deducing them from the data. Use [[Extract buffer]] and **Buffer to array** when you need to inspect actual values, or **Buffer Info** and **Texture Info** from [[Geometry and buffer utilities]] for those resource types.
