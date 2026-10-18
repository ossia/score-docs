---
layout: default
title: "Generative arc sphere"
description: "Bend a rule-generated arc sphere while its texture, color and viewpoint keep moving."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/generative-3d.html
score: /common-practices/3d/generative-3d.score
---

# Generative arc sphere

![Arc Sphere patch with Bend, HypnoSwirl, color automation and camera modulation connected to Model Display.]({{ site.baseurl }}/assets/scores/thumbnails/common-practices-3d-generative-3d.png)

A sphere assembled from arcs bends and ripples under a swirling texture. Deformation, surface animation and viewpoint move independently, and none of them regenerates the geometry.

Structure Synth builds the arc sphere on the CPU. Bend then changes its vertices during native Model Display rendering, while color automation and a moving camera alter how the structure is seen. Regenerating the grammar changes the underlying sculpture; it is not required for each frame of bending.

## Try it

Start playback and turn off Bend's animated bending to inspect a fixed deformation. Change its amount and radius, then re-enable animation and vary its speed. Move the pointer in the output window to change HypnoSwirl's texture; the camera keeps following its own LFO.

The geometry program and shaders are stored in the score. No external model is needed; allow time for CPU mesh generation when editing the Structure Synth program.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
