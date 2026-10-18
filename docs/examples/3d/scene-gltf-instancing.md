---
layout: default
title: "Orbiting glTF instances"
description: "Turn a single duck model into a moving swarm with GPU-generated instance positions."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-gltf-instancing.html
score: /examples/3d/scene-gltf-instancing.zip
---

# Orbiting glTF instances

Thousands of ducks form an orbiting swarm. Instancing draws one model many times; changing the generated positions reshapes the whole group.

A compute shader produces orbiting points, and Instancer places copies of the imported model on them. The native scene renderer lights those copies together; bloom and tone mapping turn its bright output into the final image.

## Try it

Open the ZIP directly in score; the duck model is included. The generator is set to 30,000 points, so lower its vertex count first if needed for your GPU. Start playback and change the Float control that drives orbit radius: the whole swarm changes its extent.

`orbitSpeed` changes how fast the ducks move; `spread` changes how they are scattered around the orbit. Use a compute-capable graphics backend. When adapting the PBR branch, retain floating-point render targets and tone-map before display; otherwise bright lighting can be clipped before it reaches the final image.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
