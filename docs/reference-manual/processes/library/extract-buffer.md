---
layout: default
title: Extract buffer
description: "Extract a geometry attribute, index buffer or vertex buffer"
parent: Processes
grand_parent: Reference
permalink: /processes/extract-buffer.html
---

# Extract buffer

**Extract buffer** exposes data from incoming **Geometry** through a GPU **Buffer** outlet. Use it to feed a compute process or inspect data with **Buffer to array** from [[Geometry and buffer utilities]]. It does not output a complete mesh or scene.

## Controls

**Attribute** selects what to extract:

- **Position**, **TexCoord**, **Color**, **Normal** or **Tangent** select a standard attribute semantic.
- **Attribute 0–8** select an attribute by its index in the geometry description.
- **Index** selects the geometry's index buffer.
- **Buffer 0–8** select a whole buffer by index.

Attribute extraction and whole-buffer selection are different operations. An attribute can occupy only part of an interleaved vertex record; a whole buffer can contain several attributes. Use [[Geometry Info]] to inspect the source layout before choosing an index.

**Pad vec3 to vec4** requests four-component records when extracting a three-component attribute. Account for the changed record size in the downstream consumer; this is not a general format-conversion control for arbitrary whole buffers.

## Workflow

Connect a geometry producer to **Geometry**, select a resource actually present in it, and connect **Buffer** to the consumer. Match the consumer's element type and stride to the extracted data. For several attributes in one newly packed buffer, use [[Repack attributes]] instead.

For custom attribute names and scene auxiliary resources, use the distinct **Extract buffer (by name)** process documented in [[Geometry and buffer utilities]]. That process has **Mode** and **Name / index** controls rather than this page's **Attribute** selector. Neither process replaces [[Scene Preprocessor]]: preprocess a scene before extracting resources from its geometry output.
