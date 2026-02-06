---
layout: default

title: Extract Attribute
description: "An example showing GPU-side geometry attribute extraction and reconstruction"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/extract-attribute.html
---

# Extract Attribute

<video controls>
    <source src="{{ site.img }}/examples/3d/extract-attribute.mp4" type="video/mp4">
</video>

This example demonstrates the two main tools for GPU-side geometry processing: extracting individual attributes from a mesh and reconstructing geometry from raw buffers.

## Overview

A OBJ model is loaded, and its geometry attributes (position, normals, UVs, etc.) are extracted into separate GPU buffers using the *Extract Attribute* process. These buffers are then reassembled into a new mesh with the *Buffers to Geometry* process. An [[LFO]] drives a rotation animation through a micro-mapping expression. All data stays on the GPU throughout the pipeline.

## Key concepts

- **Extract Attribute**: Takes a geometry and fetches a specific attribute by name (position, color, UV, normal, tangent...), by index (attribute 0 to 8), or as a raw buffer from the source geometry data.
- **Buffers to Geometry**: Takes multiple GPU buffers as input and recreates a renderable mesh, with configurable attribute layout (buffer, offset, stride, format, location), topology, and culling.
- **Geometry Info**: Reports vertex count, index count, instance count, and attribute count from a geometry.
- **GPU-side processing**: As far as possible, everything stays in GPU memory: geometry is never transferred back to the CPU, for maximum performance.

## Data flow

1. [[Object loader]] loads the goblet mesh
2. *Extract Attribute* pulls position data into a GPU buffer
3. *Geometry Info* reads the vertex count
4. *Buffers to Geometry* rebuilds a mesh from the extracted buffer
5. A solid color texture is applied, and [[Model display]] renders the result

## Try it

Open this example to see GPU-side geometry attribute extraction and mesh reconstruction.

[Download this example]({{ site.scores }}/examples/3d/extract-attribute.score)

## Learn more

- [[Object loader]] - Loading 3D models
- [[Model display]] - 3D mesh rendering process
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
