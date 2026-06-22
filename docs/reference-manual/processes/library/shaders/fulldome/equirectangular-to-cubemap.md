---
layout: default

title: Equirectangular To Cubemap
description: "Converts an equirectangular image to a cubemap atlas (strip or cross layout). Allows for applying rotations to each face."

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/fulldome/equirectangular-to-cubemap.html
---
# Equirectangular To Cubemap

<!-- TODO screenshot: ![Equirectangular To Cubemap]({{ site.img }}/reference/processes/shaders/fulldome/equirectangular-to-cubemap.png "Equirectangular To Cubemap") -->

Converts an equirectangular image to a cubemap atlas (strip or cross layout). Allows for applying rotations to each face.

_Fulldome / 360° conversion shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| Equirectangular Image | image | input texture |
| Output Atlas Layout | long | options: Horizontal Strip (6w x 1h), Vertical Cross (3w x 4h), Horizontal Cross (4w x 3h) |
| Apply Rotation to +X Face | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Apply Rotation to -X Face | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Apply Rotation to +Y Face | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Apply Rotation to -Y Face | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Apply Rotation to +Z Face | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Apply Rotation to -Z Face | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |

## Credit

Edu Meneses + AI Assistant (Gemini)
