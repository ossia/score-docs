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

A loaded goblet mesh is reconstructed from its position data and a new set of colours derived from an image. An [[LFO]] rotates it so the result can be viewed in motion. The example shows how geometry attributes can be treated separately, making it possible to change one part of a mesh's appearance without replacing all its data.

The process labelled Extract attribute is now registered as **Extract buffer**.

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

Open the ZIP directly in score and start playback; `Models/goblet.obj` is bundled. Change Color Test Grid's colour shift or grid dimensions and watch the reconstructed mesh change. The Value displays help compare the vertex count with the size of the colour data.

When using another texture for colours, provide at least one RGBA pixel per vertex and keep the attribute format and stride consistent with those pixels. The score's notes illustrate 3,000 vertices with a 55-by-55 texture (3,025 pixels). This uses native geometry processing rather than Qt Quick 3D.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Object loader]] - Loading 3D models
- [[Model display]] - 3D mesh rendering process
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Geometry and buffer utilities]] - Current process names, byte layouts and conversion controls
