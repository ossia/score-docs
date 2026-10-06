---
layout: default

title: Sponza Palace
description: "An example showing the Sponza architectural scene with environment mapping and animated camera"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/sponza.html
score: /examples/3d/sponza.zip
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
- **Camera controls**: Position sets the camera coordinates, and Look At receives the LFO-driven target.

This score uses QML `RuntimeLoader` from `QtQuick3D.AssetUtils`; it does not use the native Asset Loader or Geometry Loader. Its `.exr` environment is handled by Qt Quick 3D, not the native cubemap loader. See [[3D scene pipeline]] for the native alternative and [[Environments and cubemaps]] for its resource requirements.

Open the ZIP directly in score; its `Images/resting_place_4k.exr` environment is bundled. The model is not included: the 3D model file control points to `<LIBRARY>:packages/sponza-gltf-pbr/sponza.glb`. Install that model package or obtain the [Sponza glTF-PBR model](https://themaister.net/sponza-gltf-pbr/) and select your local `sponza.glb`. Keep its associated resources together.

## Try it

Start playback after resolving the model path. Change the slow LFOs' phase offsets to explore different camera-target trajectories, or adjust Position to view the atrium from another location. The JavaScript/QML process requires the Qt Quick 3D modules used by its script.

The saved script's `tick` function still calls `wasd.forceActiveFocus()`, but no `wasd` object is declared. Remove that stale call in the script editor to avoid its reference error; this version does not provide the WASD navigation controller used by the glTF Scene with Effects example. To explore it as saved, use Position and the driven Look At control.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Model display]] - 3D mesh rendering process
- [[LFO]] - Low-frequency oscillator for animation
- [[Math expressions]] - Expression-based value generation
- [[Graphics pipeline]] - How rendering works in ossia score
