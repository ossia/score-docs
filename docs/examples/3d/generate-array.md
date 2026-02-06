---
layout: default

title: Generate Array
description: "An example showing procedural point cloud generation from mathematical expressions"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/generate-array.html
---

# Generate Array

<video controls>
    <source src="{{ site.img }}/examples/3d/generate-array.mp4" type="video/mp4">
</video>

This example demonstrates procedural 3D geometry generation by computing an array of values from a mathematical expression and converting it into a renderable point cloud.

## Overview

An [[Math expressions|Arraygen]] process generates arbitrary values. The resulting array is converted to a GPU buffer, then to a point cloud mesh rendered in Lines mode. An [[LFO]] rotates the geometry, and the output passes through bloom and long exposure shaders for a glowing trail effect.

## Key concepts

- **Array Generator**: Computes an array of values from an ExprTK expression each frame, where `i` iterates over the array and `pos` tracks playback position.
- **Array to Buffer**: Converts a CPU-side array into a GPU buffer suitable for rendering.
- **Pointcloud to Mesh**: Interprets a GPU buffer as XYZ vertex coordinates and produces renderable geometry.
- **Post-processing**: Bloom adds glow to bright areas, while long exposure creates persistent motion trails through a feedback buffer.

## Data flow

1. [[Math expressions|Arraygen]] evaluates the expression for 300 elements
2. Array to Buffer sends the data to the GPU
3. Pointcloud to Mesh builds geometry from the XYZ buffer
4. A sine warp gradient provides procedural texturing
5. [[Model display]] renders the geometry in Lines mode
6. Bloom and long exposure [[ISF Shaders]] are applied as post-processing

## Try it

Open this example to see a procedurally generated point cloud animated in real-time.

[Download this example]({{ site.scores }}/examples/3d/generate-array.score)

## Learn more

- [[Math expressions]] - Expression-based value generation
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
