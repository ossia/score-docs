---
layout: default

title: Transform
description: "2D image transform with translate, rotate, scale, pivot, tiling, and edge extend modes."

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/utility/transform.html
---
# Transform

<!-- TODO screenshot: ![Transform]({{ site.img }}/reference/processes/shaders/utility/transform.png "Transform") -->

2D image transform with translate, rotate, scale, pivot, tiling, and edge extend modes.

_Utility shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| inputImage | image | input texture |
| Transform Order | long | options: SRT, STR, RST, RTS, TSR, TRS |
| Translate | point2D | 2D point |
| Rotate | float | range -360.0–360.0, default 0.0 |
| Scale | point2D | 2D point |
| Grow / Shrink (px) | point2D | 2D point |
| Pivot | point2D | 2D point |
| Background Color | color | colour |
| Pre-Multiply RGB by Alpha | bool | default False |
| Comp Over Background | bool | default False |
| Extend Mode | long | options: Hold, Zero, Repeat, Mirror |
| Limit Tiles | bool | default False |
| Tile U (Left, Right) | point2D | 2D point |
| Tile V (Bottom, Top) | point2D | 2D point |

## Credit

ossia score
