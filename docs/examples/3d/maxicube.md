---
layout: default

title: Massive Particle System
description: "Fill a rotating cube with millions of GPU-generated points and explore the cost of visual density."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/maxicube.html
score: /examples/3d/example-big-cube.score
---

# Massive Particle System

<video controls>
    <source src="{{ site.img }}/examples/3d/maxicube.mp4" type="video/mp4">
</video>

Millions of changing points fill a rotating cloud, coloured by a corner-to-corner gradient. The patch explores visual density: how a field of individual samples can read as a larger form when generated and drawn at scale.

A [[Compute Shaders|compute shader]] writes random coordinates directly into a GPU buffer each frame. Pointcloud to mesh reads successive XYZ values as vertices, and [[Model display]] renders them as points. A mathematical expression rotates the cloud independently of the changing positions.

The saved buffer contains 10,240,000 Float32 values, enough for approximately 3.41 million XYZ points. That position buffer alone uses about 41 MB; rendering and other GPU resources add to the workload.

## Try it

On a smaller GPU, reduce NoiseBuffer size before starting playback. Choose a multiple of three when setting a new size so the values form complete XYZ positions. Compare a sparse cloud with a denser one, then adjust the corner colours to make its extent easier to read.

Changing the rotation expression changes how you view the cloud, not how many points it generates. If you alter the coordinate layout, match Pointcloud to mesh's Buffer type to it; see [[Geometry and buffer utilities]]. Compute-shader support is required, but no external file is needed.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Compute Shaders]] - GPU compute for data generation
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
