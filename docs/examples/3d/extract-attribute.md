---
layout: default

title: Extract Attribute
description: "An example showing GPU-side geometry attribute extraction and reconstruction"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/extract-attribute.html
score: /examples/3d/extract-attribute.zip
---

# Extract Attribute

<video controls>
    <source src="{{ site.img }}/examples/3d/extract-attribute.mp4" type="video/mp4">
</video>

This example demonstrates the two main tools for GPU-side geometry processing: extracting individual attributes from a mesh and reconstructing geometry from raw buffers.

## Overview

An OBJ model is loaded, and its geometry attributes (position, normals, UVs, etc.) are extracted into separate buffers and reassembled into geometry. An [[LFO]] drives a rotation animation through a micro-mapping expression. In current development builds, search for **Extract buffer** or **Extract buffer (by name)** rather than the older “Extract Attribute” label.

## Key concepts

- **Extract buffer**: Selects a geometry attribute; **Extract buffer (by name)** additionally selects attributes or whole buffers by semantic, custom name or index.
- **Buffers to geometry**: Describes input buffers through offset, stride, format and semantic. The separately registered **Buffers to geometry (v1)** uses numeric locations for older patches.
- **Geometry Info**: Reports vertex/index/instance counts and attribute/binding layout.
- **Data movement**: These processes expose GPU buffer paths, but extraction strategy depends on the source layout. Do not assume every conversion is zero-copy.

## Data flow

1. [[Object loader]] loads the goblet mesh
2. The attribute-extraction process pulls position data into a buffer
3. *Geometry Info* reads the vertex count
4. *Buffers to Geometry* rebuilds a mesh from the extracted buffer
5. A solid color texture is applied, and [[Model display]] renders the result

## Try it

Open this example to see GPU-side geometry attribute extraction and mesh reconstruction.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Object loader]] - Loading 3D models
- [[Model display]] - 3D mesh rendering process
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Geometry and buffer utilities]] - Current process names, byte layouts and conversion controls
