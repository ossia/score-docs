---
layout: default

title: Massive Particle System
description: "An example showing a GPU-generated massive particle system with compute shaders"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/maxicube.html
---

# Massive Particle System

<video controls>
    <source src="{{ site.img }}/examples/3d/maxicube.mp4" type="video/mp4">
</video>

This example demonstrates generating and rendering millions of particles entirely on the GPU using [[Compute Shaders]].

## Overview

A compute shader generates a noise buffer of up to ~179 million points directly in GPU memory. The buffer is converted to a point cloud mesh and rendered in Points mode with a corner-color gradient texture. 

> **Note**: This example requires approximately 2 GB of available VRAM. Reduce the noise buffer size for lower-spec hardware.

## Key concepts

- **[[Compute Shaders]]**: Generate massive amounts of data directly on the GPU without CPU involvement. Here, a noise buffer fills GPU memory with random particle positions each frame.
- **Pointcloud to Mesh**: Interprets the GPU buffer as XYZ coordinates and produces renderable geometry.
- **Post-processing**: Edge blur applies a multi-pass Gaussian blur with Sobel edge detection. Motion blur uses a persistent feedback buffer for temporal smearing.

## Data flow

1. A compute shader generates the noise particle buffer on the GPU
2. Pointcloud to Mesh builds geometry from the buffer
3. A corner-color gradient provides the texture
4. [[Model display]] renders the points
5. Edge blur and motion blur [[ISF Shaders]] are applied as post-processing

## Try it

Open this example to see a massive GPU-generated particle system with dynamic blur effects.

[Download this example]({{ site.scores }}/examples/3d/maxicube.score)

## Learn more

- [[Compute Shaders]] - GPU compute for data generation
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
