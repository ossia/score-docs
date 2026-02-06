---
layout: default

title: glTF Scene with Effects
description: "An example showing glTF scene loading with shader effects and audio-reactive animation"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/gltf-checkers.html
---

# glTF Scene with Effects

<video controls>
    <source src="{{ site.img }}/examples/3d/gltf-checkers.mp4" type="video/mp4">
</video>

This example demonstrates loading a glTF scene in ossia score with post-processing shader effects and audio-reactive camera animation.

## Overview

Using Qt Quick 3D integration, this example loads the [A Beautiful Game](https://github.com/KhronosGroup/glTF-Sample-Assets/tree/main/Models/ABeautifulGame/glTF-Binary) glTF chess set model and renders it with PBR materials, reflection probes, environment mapping, and dynamic lighting. 
The camera  is controllable through mouse and WASD, while post-processing effects such as bloom, color blowout, and optical flow distortion are applied on top.

## Key concepts

- **glTF loading**: The [[Object loader]] node loads a `.glb` file at runtime, supporting full PBR materials and scene hierarchies.
- **Environment mapping**: An HDR [environment map](https://polyhaven.com/a/resting_place) (`.exr`) provides realistic reflections and ambient lighting via a light probe.
- **Post-processing effects**: Bloom, color blowout, and optical flow distortion shaders are chained as post-processing passes on the rendered scene.
- **Audio integration**: An audio input is analyzed with a peak detector, allowing visual parameters to react to sound levels.

## Try it

Open this example to see a glTF chess scene with dynamic camera movement and shader effects.

[Download this example]({{ site.scores }}/examples/3d/gltf-checkers.score)

## Learn more

- [[Model display]] - 3D mesh rendering process
- [[Math expressions]] - Expression-based value generation
- [[Graphics pipeline]] - How rendering works in ossia score
