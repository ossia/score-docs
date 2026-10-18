---
layout: default

title: Extract Attribute
description: "Recolor a rotating goblet by pairing its vertex positions with pixels from a generated image."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/extract-attribute.html
score: /examples/3d/extract-attribute.zip
---

# Extract Attribute

<video controls>
    <source src="{{ site.img }}/examples/3d/extract-attribute.mp4" type="video/mp4">
</video>

A rotating goblet takes its colors from a generated image instead of its original material: the mesh keeps its positions and gets new per-vertex colors.

The process labelled Extract attribute—now named **Extract buffer**—takes the loaded mesh's position data. Texture to buffer turns Color Test Grid into a second data source, and Buffers to geometry pairs positions with colors, and native [[Model display]] renders the result to `Window:/`; this is native geometry processing, not Qt Quick 3D. Geometry Info supplies the vertex count so that the reconstructed geometry follows the source mesh.

Here, the image is a palette of per-vertex RGBA values, not a texture wrapped around the goblet with UV coordinates. Buffer format and stride determine how its pixels become colors; see [[Geometry and buffer utilities]] when adapting this layout. The processing uses GPU buffers, but that does not guarantee that every extraction or conversion is zero-copy.

## Try it

Open the ZIP directly in score and start playback; the goblet model is included. Change Color Test Grid's color shift to cycle the goblet's palette, then change its grid dimensions to change how quickly the colors vary across the shape.

When substituting a color texture, provide at least one RGBA pixel per vertex. The score's notes illustrate the sizing with 3,000 vertices and a 55-by-55 texture, which supplies 3,025 pixels. Use the Value displays to compare vertex count and buffer size, and keep the attribute format and stride consistent with the texture's pixel format.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Object loader]] - Loading 3D models
- [[Model display]] - 3D mesh rendering process
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
- [[Geometry and buffer utilities]] - Current process names, byte layouts and conversion controls
