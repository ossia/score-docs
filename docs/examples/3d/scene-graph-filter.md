---
layout: default
title: "Filtering imported scene nodes"
description: "Isolate named objects from an imported chess scene without rebuilding its geometry."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-graph-filter.html
score: /examples/3d/scene-graph-filter.zip
---

# Filtering imported scene nodes

![Scene Graph Filter selecting Chessboard, King_W and Queen_W between Asset Loader and Scene Preprocessor.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-scene-graph-filter.png)

Strip a chess scene back to the board, white king and white queen. Selecting objects by name lets you recompose an imported scene around the parts that matter, rather than edit the model outside score.

Scene Graph Filter works on the imported hierarchy before scene preprocessing. The selected objects then share a native camera and lighting setup. This is object selection, not a filter that deforms vertices or removes pixels from the rendered image.

## Try it

Open the ZIP directly in score; the chess model is included. Start playback and edit the filter's Names selection to show one piece, then add the board back. Compare how the same camera frames the reduced composition.

Keep the filter before Scene Preprocessor when adapting the patch. Names come from the imported asset, so a replacement model needs a selection matching its own hierarchy. The rendering shader is embedded.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
