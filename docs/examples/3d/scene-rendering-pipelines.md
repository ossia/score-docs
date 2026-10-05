---
layout: default
title: "Comparing native render pipelines"
description: "Render one scene with PBR, retro and wireframe shaders."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/scene-rendering-pipelines.html
score: /examples/3d/scene-rendering-pipelines.zip
---

# Comparing native render pipelines

![Camera, duck asset and light feeding Scene Preprocessor and separate PBR and retro render pipelines, beside the mode-switching Scenario.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-scene-rendering-pipelines.png)

Asset Loader, Camera and Light feed one Scene Preprocessor. Its geometry goes to four Render Pipeline processes: classic PBR, retro_ps1, retro_n64 and wireframe. Video Mixer combines their textures at `Window:/`. An LFO rotates the duck through Micromap and Vec3f.

## Try it

Open the ZIP directly in score and start playback; `Models/Duck.glb` is bundled. The Scenario contains manual, retriggerable time-syncs labelled PBR mode, PS1 mode and N64 mode. Trigger them to set mixer alpha values and light intensity together. These states write to `score:/controls/Video Mixer/alpha1` through `alpha3` and `score:/controls/Light/intensity`; they are not network messages.

Adjust the fourth mixer alpha to compare the wireframe overlay. Inspect each renderer's shader to see that the look is implemented in the document rather than imposed by the application. The retro shaders are illustrative styles, not hardware-accurate emulators. All rendering is native; no Qt Quick 3D scene is involved.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
