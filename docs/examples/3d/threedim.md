---
layout: default

title: 3D meshes
description: "Texture and rotate a built-in icosahedron with native Model Display."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/threedim.html
score: /examples/3d/threedim.score
---

# 3D Meshes

<video controls>
    <source src="{{ site.img }}/examples/3d/threedim.mp4" type="video/mp4">
</video>

This example textures a built-in Icosahedron primitive and rotates it during playback.

## Overview

Icosahedron supplies geometry to native Model Display. The Oblivion ISF shader supplies its texture, and a sawtooth LFO passes through the `360x` Micromap expression to drive the primitive's Rotation. Model Display writes the rendered image to `Window:/`. This is not a Qt Quick 3D scene.


## Try it

Start playback and change the LFO frequency to alter rotation speed. Move the pointer in the output window: Oblivion reads `Window:/cursor/absolute`. Compare changes to the shader's `iSteps` and `iZoom` with changes to the primitive's Scale. The mesh and texture are procedural, so no external model or image is needed.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Mesh generators and splats]] - Built-in primitives and geometry sources
- [[Object loader]] - Loading 3D models and supported formats
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Supported protocols and formats]] - Complete list of supported 3D formats
- [[3D scene pipeline]] - Why direct mesh rendering differs from native scene rendering
