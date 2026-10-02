---
layout: default

title: Equirectangular To Domemaster
description: "Generates a Domemaster output by projecting a rotated equirectangular image. Rotations, output FOV, and horizontal flip are controllable."

parent: Processes
grand_parent: Reference
nav_exclude: true

permalink: /processes/shaders/fulldome/equirectangular-to-domemaster.html
---
# Equirectangular To Domemaster

<!-- TODO screenshot: ![Equirectangular To Domemaster]({{ site.img }}/reference/processes/shaders/fulldome/equirectangular-to-domemaster.png "Equirectangular To Domemaster") -->

Generates a Domemaster output by projecting a rotated equirectangular image. Rotations, output FOV, and horizontal flip are controllable.

_Fulldome / 360° conversion shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| Equirectangular Input | image | input texture |
| XYZrotate | point3D |  |
| Domemaster Output FOV (degrees) | float | range 1.0–360.0, default 180.0 |
| Flip Horizontally (Ext. Surface) | bool | default False |

## Credit

Edu Meneses + AI Assistant (Gemini)
