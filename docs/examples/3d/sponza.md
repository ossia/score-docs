---
layout: default

title: Sponza Palace
description: "An example showing the Sponza architectural scene with environment mapping and animated camera"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/sponza.html
score: /examples/3d/sponza.score
---

# Sponza Palace

<video controls>
    <source src="{{ site.img }}/examples/3d/sponza.mp4" type="video/mp4">
</video>

This example demonstrates loading and rendering the Sponza Palace architectural model with PBR materials, environment mapping, and an animated camera.

## Overview

The [Sponza Palace](https://en.wikipedia.org/wiki/Sponza_Palace) atrium is a classic test scene in real-time graphics. This example loads a glTF-PBR version of the model using Qt Quick 3D, with an HDR skybox providing realistic ambient lighting and reflections. Three LFOs drive a mathematical expression that smoothly animates the camera look-at target through the scene.

## Key concepts

- **Architectural glTF scene**: The Sponza glTF-PBR model is loaded from a QtQuick 3D script, with full PBR material support.
- **HDR environment**: A high-dynamic-range `.exr` [environment map](https://polyhaven.com/a/resting_place) is used both as a skybox background and as a light probe for image-based lighting.
- **Camera animation**: Three [[LFO]] processes feed a [[Math expressions]] node that outputs animated 3D coordinates, controlling where the camera looks in the scene.
- **Interactive navigation**: The scene supports real-time WASD keyboard and mouse navigation for free camera control.

This score uses QML `RuntimeLoader` from `QtQuick3D.AssetUtils`; it does not use the native Asset Loader or Geometry Loader. Its `.exr` environment is handled by Qt Quick 3D, not the native LDR Cubemap Loader. See [[3D scene pipeline]] for the native alternative and [[Environments and cubemaps]] for its resource requirements.

The score contains model/environment URL controls. Supply the referenced assets and adjust those controls for your machine. This documentation update does not establish that the external assets are reachable or that the downloaded scene has been rendered on your platform.

## Try it

Open this example and give an antique mood to your score!

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Model display]] - 3D mesh rendering process
- [[LFO]] - Low-frequency oscillator for animation
- [[Math expressions]] - Expression-based value generation
- [[Graphics pipeline]] - How rendering works in ossia score
