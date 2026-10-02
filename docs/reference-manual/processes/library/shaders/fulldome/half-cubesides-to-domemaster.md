---
layout: default

title: Half Cubesides To Domemaster
description: "Optimized single-pass Domemaster. Maps raw 2:1 images to top/bottom halves, rotating bottom 180. Includes API-level input flips."

parent: Processes
grand_parent: Reference
nav_exclude: true

permalink: /processes/shaders/fulldome/half-cubesides-to-domemaster.html
---
# Half Cubesides To Domemaster

<!-- TODO screenshot: ![Half Cubesides To Domemaster]({{ site.img }}/reference/processes/shaders/fulldome/half-cubesides-to-domemaster.png "Half Cubesides To Domemaster") -->

Optimized single-pass Domemaster. Maps raw 2:1 images to top/bottom halves, rotating bottom 180. Includes API-level input flips.

_Fulldome / 360° conversion shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| +X Side (Top Image) | image | input texture |
| +X Side (Bottom Image - 180 Rot) | image | input texture |
| -X Side (Top Image) | image | input texture |
| -X Side (Bottom Image - 180 Rot) | image | input texture |
| +Z Side (Front Top) | image | input texture |
| +Z Side (Front Bottom - 180 Rot) | image | input texture |
| -Z Side (Back Top) | image | input texture |
| -Z Side (Back Bottom - 180 Rot) | image | input texture |
| +Y Pole (Zenith/Ceiling) | image | input texture |
| -Y Pole (Nadir/Floor) | image | input texture |
| Alpha (Top Imgs) | float | range 0.0–1.0, default 1.0 |
| Alpha (Bottom Imgs) | float | range 0.0–1.0, default 1.0 |
| Rotate X (0-1, Yaw) | float | range 0.0–1.0, default 0.5 |
| Rotate Y (0-1, Pitch) | float | range 0.0–1.0, default 0.5 |
| Rotate Z (0-1, Roll) | float | range 0.0–1.0, default 0.5 |
| Domemaster Output FOV | float | range 1.0–360.0, default 180.0 |
| Flip Inputs Horizontally | bool | default False |
| Flip Inputs Vertically (GL/VK) | bool | default False |

## Credit

Edu Meneses + AI Assistant (Gemini)
