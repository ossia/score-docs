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

A loaded angel sculpture twists into a fluid-looking form, leaving traces as it moves. Use this technique to animate a static model without a rig, and to separate deformation of the object from persistence in the final image.

The Curl noise geometry filter displaces vertices on the GPU during rendering. An [[LFO]] produces changing noise-scale values; [[Smooth|exponential smoothing]] softens the transitions before they reach the filter. A procedural gradient colours the result, and Long Exposure retains earlier rendered images.

This is a vertex-shader deformation, so the filter does not require compute-shader support. It is different from **Scene Graph Filter**, which selects scene objects rather than deforming their vertices. See [[3D scene pipeline]] for that distinction and [[Geometry and buffer utilities]] when adapting mesh attributes.

## Try it

Open the ZIP directly in score and start playback; the angel model is included. Lower Curl noise's intensity to recover more of the original silhouette, then increase it to make the swirling displacement clearer. Change the scale modulation and smoothing to compare restless motion with gradual shifts.

Adjust Long Exposure's absorption and discharge separately: these change how long the image holds a gesture, not the geometry itself. To try another sculpture, choose it in Geometry Loader. The original model source is [ModelsOBJ](https://github.com/pichiliani/ModelsOBJ).

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Object loader]] - Loading 3D models
- [[ISF Shaders]] - Interactive Shader Format for GPU effects
- [[LFO]] - Low-frequency oscillator for animation
- [[Model display]] - 3D mesh rendering process
- [[Graphics pipeline]] - How rendering works in ossia score
