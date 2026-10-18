---
layout: default
title: "Blending native scene cameras"
description: "Perform continuous camera moves by blending three viewpoints of a chess scene."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/camera-switching.html
score: /examples/3d/camera-switching.zip
---

# Blending native scene cameras

![Rendered chess scene with the Nodes blend control, three Camera processes and Camera Switch.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-camera-switching.png)

Move between an oblique view of a chessboard, an overhead view and a distant narrow-angle shot with a single two-dimensional control. Blending cameras turns a collection of composed shots into a playable viewpoint.

Three native Camera processes feed Camera Switch. Nodes converts the position of its Input Point into blend weights, so moving across the control changes the camera before the scene is rendered. This blends viewpoint parameters rather than crossfading three rendered images.

## Try it

Open the ZIP directly in score; the chess model is included. Start playback and move Nodes' Input Point toward each of its three nodes, then travel slowly between them. Watch both the viewing angle and framing change.

For a direct cut instead of a continuous move, use Camera Switch's selection mode and Index. If you replace the model, adjust all three cameras' Eye and Target values to its scale. The model and rendering shader are included; this uses the native scene pipeline, not a Qt Quick 3D controller.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
