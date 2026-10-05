---
layout: default

title: Massive Particle System
description: "An example showing a GPU-generated massive particle system with compute shaders"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/maxicube.html
score: /examples/3d/example-big-cube.score
---

# Massive Particle System

<video controls>
    <source src="{{ site.img }}/examples/3d/maxicube.mp4" type="video/mp4">
</video>

This example demonstrates generating and rendering millions of particles entirely on the GPU using [[Compute Shaders]].

## Overview

A compute shader generates a buffer of 10,240,000 floats each frame, interpreted as approximately 3.41 million XYZ points. Pointcloud to mesh passes the geometry to native Model Display, which renders it with Corner Colors and writes directly to `Window:/`. This is not a Qt Quick 3D scene.

The position buffer alone contains about 41 MB of Float32 data; other GPU resources add to the workload. Reduce NoiseBuffer size before running on a smaller GPU.

## Key concepts

- **[[Compute Shaders]]**: Generate massive amounts of data directly on the GPU without CPU involvement. Here, a noise buffer fills GPU memory with random particle positions each frame.
- **Pointcloud to Mesh**: Interprets the GPU buffer as XYZ coordinates and produces renderable geometry.
- **Buffer layout**: The Pointcloud to mesh Buffer type must match the generated coordinates and their stride. See [[Geometry and buffer utilities]] before changing the compute output format.

## Data flow

1. A compute shader generates the noise particle buffer on the GPU
2. Pointcloud to Mesh builds geometry from the buffer
3. A corner-color gradient provides the texture
4. [[Model display]] renders the points
5. An expression rotates the geometry with `return [360sin(pos), 360cos(pos), c];`

## Try it

Start playback and compare the changing point cloud with its rotation. Adjust NoiseBuffer size to vary the amount of generated geometry, retaining complete XYZ triples when choosing a new size. The example requires compute-shader support but no external file. There are no blur post-processors in this version of the score.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Compute Shaders]] - GPU compute for data generation
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
