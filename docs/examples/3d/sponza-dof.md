---
layout: default
title: "Native Sponza with depth of field"
description: "Move through a lit atrium while animated depth of field shifts attention between foreground and distance."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/sponza-dof.html
score: /examples/3d/sponza-dof.zip
---

# Native Sponza with depth of field

Walk through the Sponza atrium while focus moves between nearby detail and the architecture beyond it. A helmet in the foreground makes the shift easy to compare, and moving coloured light changes the mood of the same space.

The native scene pipeline combines the models, lights, camera and environment sky. Depth-based shading adds local contrast before depth of field blurs regions away from the focus distance. Both effects read the scene's camera data; a slow modulation moves the focus through the scene.

## Try it

Open the ZIP directly in score; both models and the environment image are included. Start playback and focus the output window. Use WASD to move, the arrow keys to look around, Shift to move up and Control to move down.

Edit or disconnect the modulation of `focusDepth` before choosing a fixed focus. Move past the helmet and compare `focusRange` with `blurAmount`: one changes the range that stays sharp, while the other changes the blur outside it. Then watch how the moving light affects the same view.

Unlike the separate Qt Quick 3D Sponza example, this uses native scene objects and an equirectangular PNG environment. The camera script and shaders are embedded, but the depth effects still include `depth_helpers.glsl`; install the `csf-examples` package with its `shaderlib/depth` directory intact.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
