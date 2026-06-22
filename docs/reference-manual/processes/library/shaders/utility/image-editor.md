---
layout: default

title: image_editor
description: "Transforms an input image: scale, rotate (positive angle for CW image rotation), flip, and position."

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/utility/image-editor.html
---
# image_editor

<!-- TODO screenshot: ![image_editor]({{ site.img }}/reference/processes/shaders/utility/image-editor.png "image_editor") -->

Transforms an input image: scale, rotate (positive angle for CW image rotation), flip, and position.

_Utility shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| inputImage | image | input texture |
| Rotation Angle (Degrees) | float | range -360.0–360.0, default 0.0 |
| Scale Factor | float | range 0.01–10.0, default 1.0 |
| Flip Horizontal | bool | default False |
| Flip Vertical | bool | default False |
| XYposition | point2D | 2D point |

## Credit

Edu Meneses + AI Assistant (Gemini)
