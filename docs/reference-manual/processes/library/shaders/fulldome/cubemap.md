---
layout: default

title: Cubemap
description: "Arranges six input cube face images into a selectable layout (Horizontal Strip, Vertical Cross, or Horizontal Cross). Each face can be individually rotated by 0, 90, 180, or 270 degrees clockwise. Defines standard cell mappings for each layout type. Empty cells in cross layouts are transparent black. Assumes input faces are standard 2D views."

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/fulldome/cubemap.html
---
# Cubemap

<!-- TODO screenshot: ![Cubemap]({{ site.img }}/reference/processes/shaders/fulldome/cubemap.png "Cubemap") -->

Arranges six input cube face images into a selectable layout (Horizontal Strip, Vertical Cross, or Horizontal Cross). Each face can be individually rotated by 0, 90, 180, or 270 degrees clockwise. Defines standard cell mappings for each layout type. Empty cells in cross layouts are transparent black. Assumes input faces are standard 2D views.

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
| Output Layout | long | options: Horizontal Strip (6w x 1h), Vertical Cross (3w x 4h), Horizontal Cross (4w x 3h) |
| Rotate +X (Right) | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Rotate -X (Left) | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Rotate +Y (Top) | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Rotate -Y (Bottom) | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Rotate +Z (Front) | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |
| Rotate -Z (Back) | long | options: 0 deg, 90 deg CW, 180 deg, 270 deg CW |

## Credit

Edu Meneses + AI Assistant (Gemini)
