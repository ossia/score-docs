---
layout: default

title: Hexagonal Faces To Domemaster
description: "Hexagonal Prism Domemaster. 6 side faces (split into top/bottom halves, bottom rotated 180) + 2 pole faces. Preserves transparency."

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/fulldome/hexagonal-faces-to-domemaster.html
---
# Hexagonal Faces To Domemaster

<!-- TODO screenshot: ![Hexagonal Faces To Domemaster]({{ site.img }}/reference/processes/shaders/fulldome/hexagonal-faces-to-domemaster.png "Hexagonal Faces To Domemaster") -->

Hexagonal Prism Domemaster. 6 side faces (split into top/bottom halves, bottom rotated 180) + 2 pole faces. Preserves transparency.

_Fulldome / 360° conversion shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| Side 1 Top (0°) | image | input texture |
| Side 1 Bot (0° - 180 Rot) | image | input texture |
| Side 2 Top (60°) | image | input texture |
| Side 2 Bot (60° - 180 Rot) | image | input texture |
| Side 3 Top (120°) | image | input texture |
| Side 3 Bot (120° - 180 Rot) | image | input texture |
| Side 4 Top (180°) | image | input texture |
| Side 4 Bot (180° - 180 Rot) | image | input texture |
| Side 5 Top (240°) | image | input texture |
| Side 5 Bot (240° - 180 Rot) | image | input texture |
| Side 6 Top (300°) | image | input texture |
| Side 6 Bot (300° - 180 Rot) | image | input texture |
| Top Pole (+Y Zenith) | image | input texture |
| Bottom Pole (-Y Nadir) | image | input texture |
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
