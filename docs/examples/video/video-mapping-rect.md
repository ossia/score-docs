---
layout: default
title: "Mapping textures to editable shapes"
description: "An example showing how to arrange images on editable shapes for projection mapping."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/video-mapping-rect.html
score: /examples/video/video-mapping-rect.score
---

# Mapping textures to editable shapes

![Checkerboard connected to a texture inlet of rect-mapper]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-video-mapping-rect.png)

This example demonstrates arranging images on editable shapes for projection mapping.

## Overview

A QML interface lets you position and deform textured quads, polygons and freehand shapes. Three procedural patterns provide contrasting sources for experimenting with shape, soft edges and blending; one pattern rotates, and another responds to the pointer.

## Try it

Start playback and click rect-mapper's Show/hide UI button in its process header. Edit the mapped quads and assign their texture sources. Compare corner deformation, soft edges and blend/mask settings. Double-click the background to start a custom polygon, or hold Alt/Option and draw in the background for a freehand shape.

Reduce Subdivisions from its saved value of 32 if fine mesh deformation is too costly. No external movie is needed. The mapper uses Qt Quick 3D inside a JavaScript/QML process, so use a build providing those features.

Install the default preset package containing `Presets/Javascript/rect-mapper/rect-mapper.qml` and keep its helper files together: `MeshUtils.js`, `ShapeData.js`, `GeomUtils.js`, `SnapUtils.js`, `edgeblend.vert` and `edgeblend.frag`. The score stores the main script and UI, but their relative imports and custom-material shaders still need those files. The UI also imports Qt Quick Controls, Layouts and score's OssiaUI module. For output split across physical displays, combine the mapper with the Window device's Multi-window mode.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
