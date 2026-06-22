---
layout: default

title: Cubemap To Equirectangular
description: "Converts a cubemap atlas (strip or cross layout) to an equirectangular image. Requires knowing the layout and any rotations applied to faces in the atlas."

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/fulldome/cubemap-to-equirectangular.html
---
# Cubemap To Equirectangular

<!-- TODO screenshot: ![Cubemap To Equirectangular]({{ site.img }}/reference/processes/shaders/fulldome/cubemap-to-equirectangular.png "Cubemap To Equirectangular") -->

Converts a cubemap atlas (strip or cross layout) to an equirectangular image. Requires knowing the layout and any rotations applied to faces in the atlas.

_Fulldome / 360° conversion shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| Cubemap Atlas Texture | image | input texture |
| Input Atlas Layout | long | options: Horizontal Strip (6w x 1h), Vertical Cross (3w x 4h), Horizontal Cross (4w x 3h) |
| Atlas +X Original Rotation | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Atlas -X Original Rotation | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Atlas +Y Original Rotation | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Atlas -Y Original Rotation | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Atlas +Z Original Rotation | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Atlas -Z Original Rotation | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |

## Credit

Edu Meneses + AI Assistant (Gemini)
