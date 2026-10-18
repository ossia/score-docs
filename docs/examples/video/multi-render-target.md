---
layout: default
title: "Multiple shader render targets"
description: "Produce color, image-derived normals and edges together from a changing 3D image."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/multi-render-target.html
score: /examples/video/multi-render-target.score
---

# Multiple shader render targets

![Four views of a generated mesh comparing color, image-derived normals and edges]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-multi-render-target.png)

Watch a generated 3D form as an image, a surface-like normal view and a set of edges. A four-view grid shows them next to the original image.

## Render targets

A textured generative mesh is rendered to an image. A shader then produces color, image-derived normals and detected edges in a single pass, displayed alongside the original. The normal view estimates changes from the image; it does not expose the original mesh's geometric normals.

## Try it

- Start playback and watch the four views as Structure Synth periodically regenerates the mesh: each regeneration shows up in all four at once.
- Change `normalStrength` in mrt-gbuffer to alter the image-derived normal view without changing the mesh.
- Raise `edgeThreshold` to keep only sparse outlines, or lower it until texture features become edges as well as the object's silhouette.

The mesh, texture and shaders are generated in the score. Rendering uses native Model Display and ISF multiple render targets, with no external model or Qt Quick 3D scene required.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
