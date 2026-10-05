---
layout: default

title: glTF Scene with Effects
description: "An example showing glTF scene loading with shader effects and audio-reactive animation"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/gltf-checkers.html
score: /examples/3d/gltf-checkers.zip
---

# glTF Scene with Effects

<video controls>
    <source src="{{ site.img }}/examples/3d/gltf-checkers.mp4" type="video/mp4">
</video>

This example loads a glTF scene through Qt Quick 3D, then applies audio-reactive post-processing to its rendered texture.

## Overview

Using Qt Quick 3D integration, this example loads the [A Beautiful Game](https://github.com/KhronosGroup/glTF-Sample-Assets/tree/main/Models/ABeautifulGame/glTF-Binary) glTF chess set model and renders it with PBR materials, reflection probes, environment mapping, and dynamic lighting. 
The camera  is controllable through mouse and WASD, while post-processing effects such as bloom, color blowout, and optical flow distortion are applied on top.

## Key concepts

- **glTF loading**: QML's `RuntimeLoader` from `QtQuick3D.AssetUtils` loads the model inside the JavaScript/QML process. This is not the native Geometry Loader (historically Object Loader).
- **Environment mapping**: An HDR [environment map](https://polyhaven.com/a/resting_place) (`.exr`) provides realistic reflections and ambient lighting via a light probe.
- **Post-processing effects**: Bloom, color blowout, and optical flow distortion shaders are chained as post-processing passes on the rendered scene.
- **Audio integration**: The looping `88bpm_Freq3b Gate.wav` sound file feeds Peak and Exp Smoothing, which control Color Blowout and both Bloom intensities.

This download uses the **Qt Quick 3D** path, including its HDR light-probe support. It is not an example of the native Asset Loader pipeline. For a new native patch, see [[Asset Loader]] and [[3D scene pipeline]]; cameras, materials and environment resources must be wired for that renderer rather than copied across as QML objects.

Open the ZIP directly in score. It includes `Models/ABeautifulGame.glb`, `Images/resting_place_4k.exr` and `Audio/88bpm_Freq3b Gate.wav`, despite the older in-score note saying the model and environment are not shipped. The JavaScript/QML process requires Qt Quick 3D and its AssetUtils module.

## Try it

Start playback and use mouse/WASD navigation in the scene. Adjust Peak Gain and Gate to change how strongly the audio affects the image. The Random XYZ expression drives Light Position (not the camera), and a square LFO resets Optical Flow Distort. Its output is sent to `Window:/`.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Model display]] - 3D mesh rendering process
- [[Math expressions]] - Expression-based value generation
- [[Graphics pipeline]] - How rendering works in ossia score
