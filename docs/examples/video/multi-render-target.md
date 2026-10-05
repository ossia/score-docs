---
layout: default
title: "Multiple shader render targets"
description: "Produce colour, image-derived normals and edges from one shader pass."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/multi-render-target.html
score: /examples/video/multi-render-target.score
---

# Multiple shader render targets

Octopod II generates a Structure Synth mesh. NoiseAnimationElectric textures it in native Model Display. The resulting image enters mrt-gbuffer, whose three texture outlets are `colorOut`, `normalsOut` and `edgesOut`. Grid displays those alongside the original image at `Window:/`.

## Try it

Start playback and compare the four views. Change normalStrength and edgeThreshold in mrt-gbuffer to see which attachments change. Its normals are derived from the input image, not the original mesh's normal buffer. A Free metronome requests Structure Synth regeneration periodically; compare a new mesh with a post-processing change.

The source mesh, texture and shaders are generated in the score, so no external file is needed. This uses native Model Display followed by ISF multiple render targets, not Qt Quick 3D.

[Download this example]({{ site.scores }}{{ page.score }})
