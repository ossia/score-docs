---
layout: default

title: Cubesides To Domemaster
description: "Generates a Domemaster output by projecting a rotated cubemap (6 input images). Rotations and output FOV are controllable."

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/fulldome/cubesides-to-domemaster.html
---
# Cubesides To Domemaster

<!-- TODO screenshot: ![Cubesides To Domemaster]({{ site.img }}/reference/processes/shaders/fulldome/cubesides-to-domemaster.png "Cubesides To Domemaster") -->

Generates a Domemaster output by projecting a rotated cubemap (6 input images). Rotations and output FOV are controllable.

_Fulldome / 360° conversion shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| Face +X (Right) | image | input texture |
| Face -X (Left) | image | input texture |
| Face +Y (Top) | image | input texture |
| Face -Y (Bottom) | image | input texture |
| Face +Z (Front) | image | input texture |
| Face -Z (Back) | image | input texture |
| Rotate X (0-1, Yaw) | float | range 0.0–1.0, default 0.5 |
| Rotate Y (0-1, Pitch) | float | range 0.0–1.0, default 0.5 |
| Rotate Z (0-1, Roll) | float | range 0.0–1.0, default 0.5 |
| Domemaster Output FOV (degrees) | float | range 1.0–360.0, default 180.0 |

## Credit

Edu Meneses + AI Assistant (Gemini)
