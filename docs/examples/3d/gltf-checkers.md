---
layout: default

title: glTF Scene with Effects
description: "Explore a lit chess scene while a looping beat drives color, bloom and image distortion."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/gltf-checkers.html
score: /examples/3d/gltf-checkers.zip
---

# glTF Scene with Effects

<video controls>
    <source src="{{ site.img }}/examples/3d/gltf-checkers.mp4" type="video/mp4">
</video>

Navigate a chess scene while a looping beat pushes its colors and glow and distorts the rendered image. The sound changes the image, not the camera.

A [[Javascript|JavaScript/QML]] scene loads [A Beautiful Game](https://github.com/KhronosGroup/glTF-Sample-Assets/tree/main/Models/ABeautifulGame/glTF-Binary) through Qt Quick 3D's RuntimeLoader. An HDR [environment map](https://polyhaven.com/a/resting_place), reflections and a moving light establish the scene before score's shaders process its output.

Peak analysis of the looping sound feeds smoothing, then color blowout and bloom intensity. Optical Flow Distort acts on the resulting image, with a separate beat-synchronised LFO periodically resetting it. Camera navigation and moving light are independent of the audio analysis.

## Try it

Open the ZIP directly in score: the model, environment and sound loop are included, despite the older note inside the score saying otherwise. Use a desktop build with GPU JavaScript, Qt Quick 3D and its AssetUtils module.

Start playback and focus the output window to navigate with the mouse and WASD. Begin with modest output volume. Raise Peak Gain or lower Gate for a stronger visual response; lower smoothing Alpha so the glow fades gradually after each hit.

The color and bloom follow the audio; the distortion resets on its own beat-synchronised LFO. For a native scene-based adaptation, see [[Asset Loader]] and [[3D scene pipeline]]: Qt cameras and environment objects cannot simply be cabled into that renderer.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Model display]] - 3D mesh rendering process
- [[Math expressions]] - Expression-based value generation
- [[Graphics pipeline]] - How rendering works in ossia score
