---
layout: default
title: "Filtering imported scene nodes"
description: "Select named parts of a glTF scene before native rendering."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-graph-filter.html
score: /examples/3d/scene-graph-filter.zip
---

# Filtering imported scene nodes

![Scene Graph Filter selecting Chessboard, King_W and Queen_W between Asset Loader and Scene Preprocessor.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-scene-graph-filter.png)

Asset Loader reads a chess scene and passes it to Scene Graph Filter before Scene Preprocessor. The saved Names selection contains Chessboard, King_W and Queen_W. Camera, Light and Environment join the filtered scene; the PBR Render Pipeline displays it at `Window:/`.

## Try it

Open the ZIP directly in score; `Models/ABeautifulGame.glb` is bundled. Start playback, then edit the filter's Names selection to compare individual pieces with the board. Filter the scene before preprocessing, as in the example: this operates on the scene hierarchy rather than selecting already-flattened render buffers.

The model is bundled and the rendering shader is embedded. Names depend on the imported asset; a replacement model will need a different selection. This is the native Scene Graph Filter, not Qt Quick 3D RuntimeLoader.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
