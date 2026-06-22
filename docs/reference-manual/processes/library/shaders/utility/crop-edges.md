---
layout: default

title: Crop Edges
description: "Crop an image by its left, right, bottom, and top edges. The cropped region is remapped to fill the output"

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/utility/crop-edges.html
---
# Crop Edges

<!-- TODO screenshot: ![Crop Edges]({{ site.img }}/reference/processes/shaders/utility/crop-edges.png "Crop Edges") -->

Crop an image by its left, right, bottom, and top edges. The cropped region is remapped to fill the output

_Utility shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| inputImage | image | input texture |
| Crop Left | float | range -0.5–1.5, default 0.0 |
| Crop Right | float | range -0.5–1.5, default 1.0 |
| Crop Bottom | float | range -0.5–1.5, default 0.0 |
| Crop Top | float | range -0.5–1.5, default 1.0 |
| Extend | long | options: Hold, Zero, Repeat, Mirror |

## Credit

ossia score
