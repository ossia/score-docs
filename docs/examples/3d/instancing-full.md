---
layout: default
title: "Native instancing gallery"
description: "An example comparing moving swarms and regular arrangements of repeated 3D objects."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/instancing-full.html
score: /examples/3d/instancing-full.score
---

# Native instancing gallery

![Four rendered instancing views showing orbiting helmets, a helmet grid, a duck grid and a red box lattice.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-instancing-full.png)

This example demonstrates several ways of arranging repeated 3D objects.

## Overview

Four views compare orbiting helmets, regular grids of helmets and ducks, and an animated lattice of boxes. The same idea of instancing supports both free-moving swarms and orderly structures: change the positions or spacing to reshape the whole composition.

Each view has its own native scene rendering and tone mapping, so the arrangements can be compared side by side. The box lattice changes its dimensions over time, using smoothing to soften the sequenced changes. This example does not use Qt Quick 3D.

## Files and controls

This download is a loose score. Supply `Models/DamagedHelmet.glb`, `Models/Duck.glb` and `Models/Box.glb` relative to the project, or select your copies in the Asset file controls. The shaders are stored in the document.

Start playback after resolving the model paths. Change the orbit radius or grid spacing and compare their effects across the four views. For the box branch, edit the sequencer values rather than a grid-count control that is already being driven.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
