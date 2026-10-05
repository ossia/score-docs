---
layout: default

title: Texture Inlet in Qt Quick 3D
description: "An example showing how to import a custom texture into a Qt Quick 3D scene"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/js-texture-inlet.html
score: /examples/3d/js-texture-inlet.score
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

## Wiring the texture

1. Add a texture-producing shader or video process and the Javascript scene to an interval.
2. Cable the producer's texture outlet to the scene's **TextureInlet**. Do not use a value inlet for image data.
3. Connect the scene's texture outlet to a graphical output and play the interval.
4. In the scene's Qt Quick 3D material, use the inlet's **`item`**, not the inlet QObject itself:

```qml
// Inside a Score.Script using `import Score as Score`:
Score.TextureInlet { id: incoming; objectName: "Texture" }

// Inside the View3D scene carried by the script's TextureOutlet:
// PrincipledMaterial {
//   baseColorMap: Texture { sourceItem: incoming.item }
// }
```

These are the two relevant declarations, not a complete stand-alone scene. `Texture` and `PrincipledMaterial` come from `QtQuick3D`; `TextureInlet` comes from `Score`. The inlet owns its exposed item, so do not manually destroy it.

## Resolution and availability

Use a desktop build with GPU JavaScript and Qt Quick 3D support. The current WebAssembly score build does not execute Javascript processes. Check that the producer, scene and output are all in an executing graph if the result is blank.

The texture's render resolution is separate from the QML item's logical dimensions. An editor script can set an inlet model's resolution override with `Score.inlet(process, index).renderSize = Qt.size(640, 360)` after looking up the correct texture inlet. Resizing preserves the interactive QML scene; persistent state across save/load still requires the script state API.

To preview an already-rendered outlet in a custom control interface, use `Score.UI.TextureSource` instead. It selects an existing process/port; it does not replace this example's cabled `TextureInlet`.

## Try it

Start playback and change the Kaleidolines shader controls to see the incoming texture change on the sphere. Compare that with the LFO-driven light rotation: it changes shading rather than the texture source. The sphere and cylinder are QML primitives and need no model file. This Qt Quick 3D scene is separate from score's native Model Display and scene-port pipeline.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Javascript]] - Javascript/QML scripting in ossia score
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
