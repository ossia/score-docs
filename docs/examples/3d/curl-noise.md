---
layout: default

title: Curl Noise Geometry Filter
description: "Give a loaded sculpture swirling deformation, then retain its motion with a long-exposure effect."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/curl-noise.html
score: /examples/3d/curl-noise.zip
---

# Curl Noise Geometry Filter

<video controls>
    <source src="{{ site.img }}/examples/3d/curl-noise.mp4" type="video/mp4">
</video>

A loaded angel sculpture twists into a fluid-looking form, leaving traces as it moves. The model needs no rig: the deformation and the trails are separate stages.

The Curl noise geometry filter displaces vertices on the GPU during rendering. An [[LFO]] produces changing noise-scale values; [[Smooth|exponential smoothing]] softens the transitions before they reach the filter. A procedural sine warp gradient colors the result, and Long Exposure retains earlier rendered images. In order: [[Object loader]] loads `Models/angel.obj`, the Curl noise filter displaces it, [[Model display]] renders it, and Long Exposure sends the image to `Window:/`.

This is a vertex-shader deformation, so the filter does not require compute-shader support. It is different from **Scene Graph Filter**, which selects scene objects rather than deforming their vertices. See [[3D scene pipeline]] for that distinction and [[Geometry and buffer utilities]] when adapting mesh attributes.

## Try it

Open the ZIP directly in score and start playback; the angel model is included. Lower Curl noise's intensity to recover more of the original silhouette, then increase it to make the swirling displacement clearer. Speed up the scale modulation for restless motion, or raise the smoothing for gradual shifts.

Adjust Long Exposure's absorption and discharge separately: these change how long the image holds each movement, not the geometry itself. To try another sculpture, choose it in Geometry Loader. The original model source is [ModelsOBJ](https://github.com/pichiliani/ModelsOBJ).

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Object loader]] - Loading 3D models
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
