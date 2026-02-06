---
layout: default

title: Texture Inlet in Qt Quick 3D
description: "An example showing how to import a custom texture into a Qt Quick 3D scene"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/js-texture-inlet.html
---

# Texture Inlet in Qt Quick 3D

<video controls>
    <source src="{{ site.img }}/examples/3d/js-texture-inlet.mp4" type="video/mp4">
</video>

This example shows how to import a dynamically generated texture into a Qt Quick 3D scene using a `TextureInlet`.

## Overview

A [[Javascript]] process defines a Qt Quick 3D scene containing a sphere and a cylinder. A shader generates an animated procedural pattern that is routed into the 3D scene via a `Score.TextureInlet`. Inside the QML code, this inlet is used as the `sourceItem` of a `Texture`, which is then applied as the `baseColorMap` of the sphere's `PrincipledMaterial`. An [[LFO]] modulates the directional light rotation.

## Key concepts

- **TextureInlet**: A special inlet type in [[Javascript]] processes that receives a texture from another process in the score. It allows any shader or video output to be used as a texture source inside a Qt Quick 3D scene.
- **PrincipledMaterial**: Qt Quick 3D's PBR material, here using the incoming texture as its base color map.
- **Shader-to-3D pipeline**: The Kaleidolines shader output is routed via cable into the 3D scene, demonstrating how 2D shader effects and 3D rendering can be combined.

## Try it

Open this example to see a procedural shader texture applied to a 3D object in real-time.

[Download this example]({{ site.scores }}/examples/3d/js-texture-inlet.score)

## Learn more

- [[Javascript]] - Javascript/QML scripting in ossia score
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
