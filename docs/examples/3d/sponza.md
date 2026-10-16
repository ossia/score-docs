---
layout: default

title: Sponza Palace
description: "Explore an architectural scene with environment lighting and a slowly wandering camera target."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/sponza.html
score: /examples/3d/sponza.zip
---

# Sponza Palace

<video controls>
    <source src="{{ site.img }}/examples/3d/sponza.mp4" type="video/mp4">
</video>

Look around the [Sponza Palace](https://en.wikipedia.org/wiki/Sponza_Palace) atrium as a slowly moving camera target reveals its arches and surfaces. The patch offers a compact way to build an architectural backdrop whose viewpoint can be composed with score's control processes.

A [[Javascript|JavaScript/QML]] scene uses Qt Quick 3D's RuntimeLoader to load the [Sponza glTF-PBR model](https://themaister.net/sponza-gltf-pbr/). An HDR [environment map](https://polyhaven.com/a/resting_place) supplies the skybox and light probe. Three [[LFO]] processes feed a [[Math expressions|mathematical expression]] that changes where the camera looks; Position controls where the camera stands.

This is a Qt Quick 3D scene, not the native Asset Loader pipeline. Its HDR environment is handled by Qt's light probe. See [[3D scene pipeline]] for the native alternative and [[Environments and cubemaps]] before transferring an environment to that renderer.

## Try it

Open the ZIP directly in score: **the model and environment are both included**. There is no separate Sponza model-package download to resolve.

The saved QML script still calls `wasd.forceActiveFocus()` in `tick`, but declares no `wasd` controller. Remove that call in the script editor to avoid its reference error. This version uses Position and Look At, not WASD navigation.

Start playback and change the slow LFOs' phase offsets to alter the camera-target path. Then adjust Position to compare the same target motion from another location. Use a desktop build with GPU JavaScript and the Qt Quick 3D modules imported by the script, including AssetUtils.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Model display]] - 3D mesh rendering process
- [[LFO]] - Low-frequency oscillator for animation
- [[Math expressions]] - Expression-based value generation
- [[Graphics pipeline]] - How rendering works in ossia score
