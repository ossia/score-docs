---
layout: default

title: Domemaster Mask
description: "Applies a customizable Domemaster mask defined by a polar angle range, a color, and a feathered edge (softness). Assumes the input is a 210-degree FOV Domemaster projection."

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/fulldome/domemaster-mask.html
---
# Domemaster Mask

<!-- TODO screenshot: ![Domemaster Mask]({{ site.img }}/reference/processes/shaders/fulldome/domemaster-mask.png "Domemaster Mask") -->

Applies a customizable Domemaster mask defined by a polar angle range, a color, and a feathered edge (softness). Assumes the input is a 210-degree FOV Domemaster projection.

_Fulldome / 360° conversion shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| Domemaster Input | image | input texture |
| Keep 1:1 Input Aspect | bool | default True |
| Mask Polar Angle Degrees (0 to 60) | float | range 0.0–60.0, default 14.0 |
| Mask Softness (Feathering Degrees) | float | range 0.0–30.0, default 1.0 |
| Mask Color (incl. Alpha) | color | colour |

## Credit

AI Assistant (Gemini)
