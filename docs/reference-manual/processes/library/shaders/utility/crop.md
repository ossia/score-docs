---
layout: default

title: Crop
description: "Crop a normalized rectangle from the input image and stretch it to the output. Two modes: Center+Size or Corners."

parent: Processes
grand_parent: Reference
nav_exclude: true

permalink: /processes/shaders/utility/crop.html
---
# Crop

<!-- TODO screenshot: ![Crop]({{ site.img }}/reference/processes/shaders/utility/crop.png "Crop") -->

Crop a normalized rectangle from the input image and stretch it to the output. Two modes: Center+Size or Corners.

_Utility shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| inputImage | image | input texture |
| Mode | long | options: Center/Size, Corners |
| center | point2D | 2D point |
| width | float | range 0.0–1.0, default 0.5 |
| height | float | range 0.0–1.0, default 0.5 |
| topLeft | point2D | 2D point |
| bottomRight | point2D | 2D point |
| bgColor | color | colour |

## Credit

Jean-Michaël Celerier
