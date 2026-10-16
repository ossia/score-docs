---
layout: default
title: "Text to deformed mesh"
description: "Extrude a word into a coloured sculpture and warp its letterforms on the GPU."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/text-to-mesh.html
score: /examples/3d/text-to-mesh.score
---

# Text to deformed mesh

![The extruded word sierra rendered in bright triangular colours above the deformation and rendering patch.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-text-to-mesh.png)

Turn a word into a sculptural form that can twist and change colour, rather than remain a flat caption. The saved word, “sierra”, is extruded into geometry; deformation and per-vertex colour then give its letters a more abstract appearance.

Text to Mesh supplies the shape to the native scene pipeline. After scene preprocessing, compute shaders deform and colour the geometry before rendering. Typeface and extrusion change the starting form; the deformation changes what happens to that form.

## Try it

Replace Text with a short word and start playback. Vary Height to compare thin lettering with a deep extrusion. Then bring Deform's amount toward zero to recover the original outlines, and change its radius to compare how the warp reaches across the word.

No external model is needed. Font availability can affect glyph shapes, and the saved deformation and colour shaders require a graphics backend with compute support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
