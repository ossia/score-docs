---
layout: default
title: "Mapping textures to editable shapes"
description: "Place and deform textured shapes to compose a projection around a surface."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/video-mapping-rect.html
score: /examples/video/video-mapping-rect.score
---

# Mapping textures to editable shapes

![Checkerboard texture routed into an editable projection-mapping composition]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-video-mapping-rect.png)

Fit moving patterns to a set of shapes instead of filling a rectangular screen. Editable corners, polygons and freehand outlines let you sketch a projection composition around objects or architectural details, with soft edges and blending where shapes overlap.

## Compose before output

Three generated patterns feed a mapping interface that places them within one viewport. One source rotates and another responds to the pointer, so you can see how motion behaves inside a deformed shape. The mapper produces a composed texture; splitting that image across physical displays is a separate output step.

## Setup

Use a build with JavaScript/QML and Qt Quick 3D, and install the default preset package containing rect-mapper. Keep the preset's helper scripts and material shaders together: the saved interface still relies on its relative imports. No movie is required.

## Try it

- Start playback and click rect-mapper's **Show/hide UI** button in its process header. Assign a texture to a quad and move its corners; use the checkerboard to see where the image stretches.
- Compare hard boundaries with soft edges, then change blend or mask settings where shapes overlap.
- Double-click the background to start a polygon, or hold Alt/Option while drawing in the background for a freehand shape. Compare these outlines with a four-corner mapping.

Reduce Subdivisions from 32 if deformation is too costly, comparing the visual result as you do. For projection across several displays, send the composed texture to the Window device's Multi-window mode.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
