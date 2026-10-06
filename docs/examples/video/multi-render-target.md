---
layout: default
title: "Multiple shader render targets"
description: "An example comparing several image treatments produced by one shader."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/multi-render-target.html
score: /examples/video/multi-render-target.score
---

# Multiple shader render targets

![Four views of a generated mesh comparing colour, image-derived normals and edges]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-multi-render-target.png)

This example demonstrates producing several images from a single shader pass.

## Overview

A textured, generative mesh provides the source image. Alongside the original view, a grid shows colour, image-derived normals and detected edges. Comparing them makes it easier to explore how one image can support several different treatments.

## Try it

Start playback and compare the four views. Change normalStrength and edgeThreshold in mrt-gbuffer to explore surface-like shading and edge detection. The normals are estimated from the image, not taken from the original mesh. Structure Synth periodically regenerates the mesh; compare those changes in shape with adjustments to the image effects.

The source mesh, texture and shaders are generated in the score, so no external file is needed. This uses native Model Display followed by ISF multiple render targets, not Qt Quick 3D.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
