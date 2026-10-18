---
layout: default
title: "Procedural PBR material"
description: "Animate a cube's surface with procedural material maps and reveal it with a moving light."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/custom-pbr.html
score: /examples/3d/custom-pbr.score
---

# Procedural PBR material

![PBR Mesh texture inlets for base color, metallic roughness, normal and emissive maps, connected to Scene Preprocessor.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-custom-pbr.png)

A cube takes on a changing surface as animated textures alter its color, roughness, normals and emission.
The textures feed separate maps on PBR Mesh, while a moving light reveals their effect on shading. The native scene renderer produces the lit image; bloom then spreads its bright areas into a glow. Changing the material and adding glow are separate operations.

## Try it

Start playback and lower Roughness: highlights from the moving light become sharper. Raise Metallic to tint the reflections with the base color. Then adjust Emissive strength and Bloom threshold separately: one changes the material's brightness, while the other controls which highlights spread into the image.

Change the light modulation to see the same material under a different movement. The cube, textures and shader code are all generated or stored in the score; no external model or image is needed.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
