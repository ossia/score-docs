---
layout: default
title: "Generative arc sphere"
description: "Deform a Structure Synth mesh and animate its shader texture and camera."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/generative-3d.html
score: /common-practices/3d/generative-3d.score
---

# Generative arc sphere

The Arc Sphere Structure Synth program generates a mesh on the CPU. A Bend geometry filter deforms its vertices during native Model Display rendering; this is not a Qt Quick 3D scene. HypnoSwirl supplies the texture, while a looping colour automation passes through Arraymap (`0.01x`) to its colour input.

## Try it

Open the score and start playback. The textured sphere bends while an LFO and the expression `return [-1.5, 50a, -1];` move the Model Display camera. Move the pointer in the output window: HypnoSwirl reads `Window:/cursor/absolute`. Change Bend's amount, radius or animation speed to isolate the deformation from camera motion.

The geometry and shader are stored in the score; no external model is needed. Regenerating the Structure Synth program is CPU work, unlike the Bend filter. The final texture is sent to `Window:/`.

[Download this example]({{ site.scores }}{{ page.score }})
