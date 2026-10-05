---
layout: default
title: "Blending native scene cameras"
description: "Blend three camera viewpoints over an imported chess scene."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/camera-switching.html
score: /examples/3d/camera-switching.zip
---

# Blending native scene cameras

![Rendered chess scene with the Nodes blend control, three Camera processes and Camera Switch.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-camera-switching.png)

Three Camera processes feed Camera Switch. Nodes supplies the blend weights, and the selected camera joins Asset Loader, Light and Environment in Scene Preprocessor. A PBR Render Pipeline and ToneMapping produce the output at `Window:/`.

## Try it

Open the ZIP directly in score and start playback; `Models/ABeautifulGame.glb` is bundled. Move the Input Point in Nodes toward each of its three nodes: the view blends between an oblique view, an overhead view and a narrow-field distant view. Compare this with Camera Switch's selection mode and Index for discrete changes.

The model and shader code are included. This uses the native Camera Switch and scene pipeline, not a Qt Quick 3D camera controller. When replacing the model, adjust all three cameras' Eye and Target values to its scale.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
