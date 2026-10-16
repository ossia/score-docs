---
layout: default

title: Extract Attribute
description: "Recolour a rotating goblet by pairing its vertex positions with pixels from a generated image."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/extract-attribute.html
score: /examples/3d/extract-attribute.zip
---

# Extract Attribute

<video controls>
    <source src="{{ site.img }}/examples/3d/extract-attribute.mp4" type="video/mp4">
</video>

A rotating goblet takes its colours from a generated image rather than from its original material. This is a way to treat a mesh as editable data: keep its positions, replace its colours, and build a new appearance without remodelling the object.

The process labelled Extract attribute—now named **Extract buffer**—takes the loaded mesh's position data. Texture to buffer turns Color Test Grid into a second data source, and Buffers to geometry pairs positions with colours. Geometry Info supplies the vertex count so that the reconstructed geometry follows the source mesh.

Here, the image is a palette of per-vertex RGBA values, not a texture wrapped around the goblet with UV coordinates. Buffer format and stride determine how its pixels become colours; see [[Geometry and buffer utilities]] when adapting this layout. The processing uses GPU buffers, but that does not guarantee that every extraction or conversion is zero-copy.

## Try it

Open the ZIP directly in score and start playback; the goblet model is included. Change Color Test Grid's colour shift, then its grid dimensions, and compare how colours spread across the rotating shape.

When substituting a colour texture, provide at least one RGBA pixel per vertex. The score's notes illustrate the sizing with 3,000 vertices and a 55-by-55 texture, which supplies 3,025 pixels. Use the Value displays to compare vertex count and buffer size, and keep the attribute format and stride consistent with the texture's pixel format.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Object loader]] - Loading 3D models
- [[Model display]] - 3D mesh rendering process
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Geometry and buffer utilities]] - Current process names, byte layouts and conversion controls
