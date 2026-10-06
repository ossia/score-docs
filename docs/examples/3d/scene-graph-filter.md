---
layout: default
title: "Filtering imported scene nodes"
description: "An example showing how to select individual objects from an imported 3D scene."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-graph-filter.html
score: /examples/3d/scene-graph-filter.zip
---

# Filtering imported scene nodes

![Scene Graph Filter selecting Chessboard, King_W and Queen_W between Asset Loader and Scene Preprocessor.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-scene-graph-filter.png)

This example demonstrates selecting parts of an imported 3D scene by name.

## Overview

A chess set provides a familiar scene to explore: the saved selection shows the board, white king and white queen. Filtering the hierarchy lets you work with particular objects while retaining a scene-based lighting and camera setup.

## Try it

Open the ZIP directly in score; `Models/ABeautifulGame.glb` is bundled. Start playback, then edit the filter's Names selection to compare individual pieces with the board. Filter the scene before preprocessing, as in the example: this operates on the scene hierarchy rather than selecting already-flattened render buffers.

The model is bundled and the rendering shader is embedded. Object names belong to the imported asset, so a replacement model will need a different selection. This example uses the native scene pipeline.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
