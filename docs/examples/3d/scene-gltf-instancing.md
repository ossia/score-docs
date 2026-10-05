---
layout: default
title: "Orbiting glTF instances"
description: "Use GPU-generated particle positions to instance a glTF scene."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-gltf-instancing.html
score: /examples/3d/scene-gltf-instancing.zip
---

# Orbiting glTF instances

Asset Loader supplies a duck scene and OrbitParticles supplies geometry to Instancer's Points inlet. Scene Preprocessor combines the instances with Camera, Light and Environment. The classic PBR Render Pipeline feeds Bloom and ToneMapping, ending at `Window:/`.

## Try it

Open the ZIP directly in score; `Models/Duck.glb` is bundled. Start playback to see the orbiting instances. Change the Float control that drives orbit radius, then compare `orbitSpeed` and `spread`. The generator is configured for 30,000 points; lower that count if the scene is too costly on your GPU.

Keep floating-point render targets when working with the PBR branch, and tone-map before display so bright lighting is not clipped to an 8-bit range too early. The shaders are stored in the score. This is native scene instancing, not Qt Quick 3D.

[Download this example]({{ site.scores }}{{ page.score }})
