---
layout: default
title: "Comparing native render pipelines"
description: "Switch one rotating model between PBR, retro-inspired shading and a wireframe overlay."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-rendering-pipelines.html
score: /examples/3d/scene-rendering-pipelines.zip
---

# Comparing native render pipelines

![Camera, duck asset and light feeding Scene Preprocessor and separate PBR and retro render pipelines, beside the mode-switching Scenario.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-scene-rendering-pipelines.png)

Give the same rotating duck three different visual identities: physically based shading, a PS1-inspired treatment and an N64-inspired treatment. A wireframe overlay can reveal the mesh beneath them.

The asset, camera and lights form a shared native scene. Separate render pipelines interpret that scene, and a mixer combines their images. Manual cues change both the image blend and lighting, so each look is a coordinated state, not just a shader swap.

## Try it

Open the ZIP directly in score; the duck model is included. Start playback and trigger the manual time-syncs labelled PBR mode, PS1 mode and N64 mode. Switch modes while the duck faces the same way to see how each one changes surface detail and lighting.

Adjust the fourth mixer alpha to bring the wireframe overlay in or out. The renderer shaders are embedded if you want to develop another treatment; the retro looks are illustrative, not hardware-accurate emulators.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
