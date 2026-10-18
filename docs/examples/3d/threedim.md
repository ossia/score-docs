---
layout: default

title: 3D meshes
description: "Texture a rotating icosahedron and separate surface animation from changes to its shape."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/threedim.html
score: /examples/3d/threedim.score
---

# 3D Meshes

<video controls>
    <source src="{{ site.img }}/examples/3d/threedim.mp4" type="video/mp4">
</video>

A rotating icosahedron carries an animated, pointer-responsive pattern. No model or image file is needed.

The primitive supplies geometry to [[Model display]], while the Oblivion shader supplies its texture. An [[LFO]] drives rotation independently: the image on the surface and the object carrying it can move at different speeds. This is direct native mesh rendering, not a Qt Quick 3D scene.

## Try it

Start playback and slow the LFO to make the rotation easier to follow. Move the pointer in the output window to change the shader pattern. Then change the shader's `iZoom` to rescale the texture, and the primitive's Scale to resize the silhouette. Adjust `iSteps` to explore the pattern's detail.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Mesh generators and splats]] - Built-in primitives and geometry sources
- [[Object loader]] - Loading 3D models and supported formats
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Supported protocols and formats]] - Complete list of supported 3D formats
- [[3D scene pipeline]] - Why direct mesh rendering differs from native scene rendering
