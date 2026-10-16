---
layout: default

title: Texture Inlet in Qt Quick 3D
description: "Paint a bouncing 3D sphere with a live shader texture inside a Qt Quick 3D scene."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/js-texture-inlet.html
score: /examples/3d/js-texture-inlet.score
---

# Texture Inlet in Qt Quick 3D

<video controls>
    <source src="{{ site.img }}/examples/3d/js-texture-inlet.mp4" type="video/mp4">
</video>

A bouncing, rotating sphere carries a live shader pattern while a red cylinder and moving light give it a simple stage. The useful connection is from a score texture into a QML material: the same approach can put generated images or video onto objects in a scripted scene.

[[ISF Shaders|Kaleidolines]] produces the pattern, and a [[Javascript|JavaScript/QML]] process receives it through a texture inlet. Inside Qt Quick 3D, a Texture uses that inlet's `item` as its `sourceItem`, then supplies the sphere's base-colour map. The image on the object can change independently of the object's motion.

The sphere's bounce and rotation are scripted. A separate [[LFO]] controls the directional light and cylinder rotation, giving you another layer of movement to compare with the texture.

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

Use a desktop build with GPU JavaScript and Qt Quick 3D support; the current WebAssembly build does not execute JavaScript processes. No model file is needed because the sphere and cylinder are QML primitives. If the image is blank, check that the texture source, scripted scene and output are all executing.

The texture's render resolution is separate from the QML item's logical dimensions. When adapting the patch, change the texture inlet's render resolution rather than expecting a QML item resize to supply more image detail.

To preview an already-rendered outlet in a custom control interface, use `Score.UI.TextureSource` instead. It selects an existing process and port; it does not replace the cabled texture inlet used here.

## Try it

Start playback and change Kaleidolines' controls to alter the pattern on the sphere. Then slow the LFO and compare the light and cylinder movement with the sphere's scripted motion. Finally, replace Kaleidolines with another shader or video source to change the surface image without rebuilding the scene.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Javascript]] - Javascript/QML scripting in ossia score
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
