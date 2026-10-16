---
layout: default
title: "Multiple shader render targets"
description: "Compare colour, image-derived normals and edges produced together from a changing 3D image."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/multi-render-target.html
score: /examples/video/multi-render-target.score
---

# Multiple shader render targets

![Four views of a generated mesh comparing colour, image-derived normals and edges]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-multi-render-target.png)

Watch a generated 3D form as an image, a surface-like normal view and a set of edges. The four-view grid helps you compare different readings of the same composition, useful when developing treatments that emphasize shape, texture or outline.

## One source, several readings

A textured generative mesh is rendered to an image. A shader then produces colour, image-derived normals and detected edges in a single pass, displayed alongside the original. The normal view estimates changes from the image; it does not expose the original mesh's geometric normals.

## Try it

- Start playback and compare the four views as Structure Synth periodically regenerates the mesh. A structural change in the source should be visible across the treatments.
- Change `normalStrength` in mrt-gbuffer to alter the image-derived normal view without changing the mesh.
- Change `edgeThreshold` to compare sparse outlines with more image detail. Watch which texture features become edges as well as the object's silhouette.

The mesh, texture and shaders are generated in the score. Rendering uses native Model Display and ISF multiple render targets, with no external model or Qt Quick 3D scene required.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
