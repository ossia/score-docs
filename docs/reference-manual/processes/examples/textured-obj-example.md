---
layout: default
title: "Textured OBJ Rendering Study"
description: "Give a fixed 3D form a moving surface with procedural dots and image trails."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/3d.html
score: "/reference/processes/3d.zip"
---

# Textured OBJ Rendering Study

![Procedural shader and object geometry branches joining at Model Display before blur post-processing.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-3d.png)

A moving dot pattern gives a 3D model an animated skin. The geometry can stay still while its surface changes, and blur turns that motion into a softer, accumulating image.
The **SumDotz** shader generates the dots, which are color-shifted before **Model Display** applies them to the loaded model. Edge blur and motion blur act on the rendered image, not on the geometry.
## Try it

Open the ZIP directly in score, then start playback and show the Window output. The mesh is included and the texture is generated within the score.

Change SumDotz's scale to vary the dot pattern and its rate to change the motion. Reduce the motion-blur amount to see the current texture without its trails. Finally, adjust the loaded object's rotation to inspect how the same pattern reads from another angle. See [[Object loader]] and [[Model display]].

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

