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

The goblet OBJ model supplies a position buffer. A separate Color Test Grid shader supplies a texture which Texture to buffer turns into per-vertex colour data. Buffers to geometry combines the two, using Geometry Info's vertex count. An [[LFO]] drives rotation through a micro-mapping expression. The process labelled Extract attribute is registered as **Extract buffer**.

## Key concepts

- **Extract buffer**: Selects a geometry attribute; **Extract buffer (by name)** additionally selects attributes or whole buffers by semantic, custom name or index.
- **Buffers to geometry**: Describes input buffers through offset, stride, format and semantic. The separately registered **Buffers to geometry (v1)** uses numeric locations for older patches.
- **Geometry Info**: Reports vertex/index/instance counts and attribute/binding layout.
- **Data movement**: These processes expose GPU buffer paths, but extraction strategy depends on the source layout. Do not assume every conversion is zero-copy.

## Data flow

1. [[Object loader]] loads the goblet mesh
2. The attribute-extraction process pulls position data into a buffer
3. *Geometry Info* reads the vertex count
4. Color Test Grid → Texture to buffer supplies a second buffer, bound as `color`
5. Buffers to geometry combines position and colour attributes, and native Model Display renders to `Window:/`

## Try it

Open the ZIP directly in score and start playback; `Models/goblet.obj` is bundled. Change Color Test Grid's colour shift or grid dimensions to see the reconstructed mesh's colours change. The Value displays report the vertex count and colour-buffer byte size. Ensure a replacement colour texture has at least one RGBA pixel per vertex: the score's notes illustrate 3,000 vertices with a 55-by-55 texture (3,025 pixels). Keep the attribute format and stride consistent with those pixels. This is a native buffer/geometry workflow, not Qt Quick 3D.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Object loader]] - Loading 3D models
- [[Model display]] - 3D mesh rendering process
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Geometry and buffer utilities]] - Current process names, byte layouts and conversion controls
