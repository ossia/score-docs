---
layout: default

title: Curl Noise Geometry Filter
description: "An example showing vertex deformation with curl noise geometry filters"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/curl-noise.html
---

# Curl Noise Geometry Filter

<video controls>
    <source src="{{ site.img }}/examples/3d/curl-noise.mp4" type="video/mp4">
</video>

This example demonstrates using a geometry filter to deform a 3D mesh in real-time with curl noise.

## Overview

A 3D model is loaded and its vertices are displaced each frame by a curl noise function written in GLSL. The deformation intensity is modulated by an [[LFO]] through an exponential smoothing filter, creating a fluid, organic animation. The result is textured with a procedural sine warp gradient and rendered through bloom and long exposure post-processing effects.

## Key concepts

- **Geometry filters**: GLSL shaders that modify vertex positions directly on the GPU. They provide a way to deform meshes in real-time without compute shader support.
- **Curl noise**: A divergence-free 3D noise field derived from simplex noise. It produces smooth, swirling displacements well suited for fluid-like motion.
- **Modulation**: An [[LFO]] drives a [[Smooth]] filter that controls the curl noise scale parameter, producing gradual deformation changes.

## Data flow

1. [[Object loader]] loads the mesh
2. The curl noise [[Geometry Filter]] preset displaces vertices based on time and noise parameters
3. A basic shader provides procedural texturing
4. [[Model display]] renders the deformed geometry
5. Bloom and long exposure shaders are applied as post-processing

## Try it

Open this example to see real-time vertex deformation driven by curl noise.

[Download this example]({{ site.scores }}/examples/3d/curl-noise.score)

## Learn more

- [[Object loader]] - Loading 3D models
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
