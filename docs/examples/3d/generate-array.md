---
layout: default

title: Generate Array
description: "Turn a mathematical sequence into rotating lines with glow and persistent trails."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/generate-array.html
score: /examples/3d/generate-array.score
---

# Generate Array

<video controls>
    <source src="{{ site.img }}/examples/3d/generate-array.mp4" type="video/mp4">
</video>

A sequence of numbers becomes a rotating line drawing in space. Glow and a long exposure turn its changing geometry into luminous traces—a useful way to explore mathematical patterns as moving images.

[[Math expressions|Arraygen]] evaluates an expression on the CPU, using `i` for each array element and `pos` for playback position. The 300 resulting values describe 100 XYZ vertices. Array to buffer transfers those values to the GPU, and Pointcloud to mesh makes geometry that [[Model display]] draws in Lines mode.

A procedural gradient colours the drawing. An [[LFO]] rotates it, while bloom brightens its highlights and Long Exposure retains earlier images. The visible trail therefore contains previous rendered frames, not additional vertices in the current mesh.

## Try it

Start playback and edit the expression to change the distribution of points. Keep complete XYZ triples and the Array to buffer type set to Float32; see [[Geometry and buffer utilities]] if you change the layout.

Slow the LFO, then vary Long Exposure's discharge rate. One changes how fast the drawing moves; the other changes how long the image remembers it.

No external asset is required. The saved Window uses an HDR swapchain format: use a compatible HDR output, or change the Window format and adapt the final image for an SDR display.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Math expressions]] - Expression-based value generation
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
