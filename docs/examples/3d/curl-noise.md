---
layout: default

title: Curl Noise Geometry Filter
description: "An example showing vertex deformation with curl noise geometry filters"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/curl-noise.html
score: /examples/3d/curl-noise.zip
---

# Curl Noise Geometry Filter

<video controls>
    <source src="{{ site.img }}/examples/3d/curl-noise.mp4" type="video/mp4">
</video>

This example demonstrates using a geometry filter to deform a 3D mesh in real-time with curl noise.

## Overview

A 3D model is loaded and its vertices are displaced each frame by a curl noise function written in GLSL. An [[LFO]] and exponential smoothing modulate the noise scale. A procedural sine warp gradient supplies the texture, and Long Exposure accumulates the rendered image.

## Key concepts

- **Geometry filters**: GLSL shaders that modify vertex positions directly on the GPU. They provide a way to deform meshes in real-time without compute shader support.
- **Curl noise**: A divergence-free 3D noise field derived from simplex noise. It produces smooth, swirling displacements well suited for fluid-like motion.
- **Modulation**: An [[LFO]] drives a [[Smooth]] filter that controls the curl noise scale parameter, producing gradual deformation changes.

## Data flow

1. [[Object loader]] loads the mesh
2. The curl noise Geometry Filter preset displaces vertices based on time and noise parameters
3. A basic shader provides procedural texturing
4. [[Model display]] renders the deformed geometry
5. Long Exposure processes the image and sends it to `Window:/`

This is a direct geometry workflow, not a native scene-graph filter. **Scene Graph Filter** selects scene nodes; it does not evaluate this vertex-deformation shader. See [[3D scene pipeline]] for the representation boundary and [[Geometry and buffer utilities]] when adapting attribute layouts.

## Try it

Open the ZIP directly in score and start playback; `Models/angel.obj` is bundled. Change Curl noise's intensity to adjust displacement and its scale modulation to change the spatial pattern. Long Exposure's absorption and discharge controls affect persistence, not the mesh itself. This is native Geometry Loader → Geometry filter → Model Display rendering, not Qt Quick 3D, and the vertex filter does not require a compute shader. To substitute a model, change the Geometry Loader file control; the original model source is [ModelsOBJ](https://github.com/pichiliani/ModelsOBJ).

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Object loader]] - Loading 3D models
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
