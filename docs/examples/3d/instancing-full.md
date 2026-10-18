---
layout: default
title: "Native instancing gallery"
description: "Build orbiting swarms, regular grids and a sequenced lattice made from repeated models."
parent: 3D Graphics
grand_parent: Examples
permalink: /examples/3d/instancing-full.html
score: /examples/3d/instancing-full.zip
---

# Native instancing gallery

![Four rendered instancing views showing orbiting helmets, a helmet grid, a duck grid and a red box lattice.]({{ site.baseurl }}/assets/scores/thumbnails/examples-3d-instancing-full.png)

Four views repeat models in different arrangements: orbiting helmets, a helmet grid, a duck grid and a changing box lattice.

Each branch separates a model from the points that place its instances. The branches have their own native scene rendering and tone mapping, then meet in a four-way display. In the box lattice, step sequencers drive the grid's dimensions through smoothing, giving its changes a different rhythm from the orbiting swarm.

## Try it

Open the ZIP directly in score; the required models are included. Start playback and change the orbit radius, then a grid's spacing. One expands a moving arrangement, while the other changes the intervals between repeated objects.

For the box lattice, edit the sequencer values, not the grid-count controls they already drive. Raise smoothing Alpha for abrupt changes of dimension, or lower it to soften them. The shaders are embedded and the point generators require compute-shader support.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
