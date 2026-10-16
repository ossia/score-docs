---
layout: default
title: "Generative arc sphere"
description: "Bend a rule-generated arc sphere while its texture, colour and viewpoint keep moving."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/generative-3d.html
score: /common-practices/3d/generative-3d.score
---

# Generative arc sphere

![Arc Sphere patch with Bend, HypnoSwirl, colour automation and camera modulation connected to Model Display.]({{ site.baseurl }}/assets/scores/thumbnails/common-practices-3d-generative-3d.png)

A sphere assembled from arcs bends and ripples under a swirling texture. Its movement comes from three independent choices—deformation, surface animation and viewpoint—so you can build a complex visual rhythm without continually generating new geometry.

Structure Synth builds the arc sphere on the CPU. Bend then changes its vertices during native Model Display rendering, while colour automation and a moving camera alter how the structure is seen. Regenerating the grammar changes the underlying sculpture; it is not required for each frame of bending.

## Try it

Start playback and turn off Bend's animated bending to inspect a fixed deformation. Change its amount and radius, then re-enable animation and vary its speed. Move the pointer in the output window to affect HypnoSwirl; compare this surface response with the camera's LFO-driven movement.

The geometry program and shaders are stored in the score. No external model is needed; allow time for CPU mesh generation when editing the Structure Synth program.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
