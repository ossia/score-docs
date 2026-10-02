---
layout: default

title: Image To Equirectangular
description: "Overlays an image onto an equirectangular projection with true spherical distortion. Allows 3D positioning, rotation, and scaling of the overlay on the sphere. Surrounding space is transparent or shows a base equirectangular image."

parent: Processes
grand_parent: Reference
nav_exclude: true

permalink: /processes/shaders/fulldome/image-to-equirectangular.html
---
# Image To Equirectangular

<!-- TODO screenshot: ![Image To Equirectangular]({{ site.img }}/reference/processes/shaders/fulldome/image-to-equirectangular.png "Image To Equirectangular") -->

Overlays an image onto an equirectangular projection with true spherical distortion. Allows 3D positioning, rotation, and scaling of the overlay on the sphere. Surrounding space is transparent or shows a base equirectangular image.

_Fulldome / 360° conversion shader from the score user library._

## Controls

| Control | Type | Details |
|---|---|---|
| Background Equirectangular (Optional) | image | input texture |
| Overlay Image | image | input texture |
| Center Longitude (deg) | float | range -180.0–180.0, default 0.0 |
| Center Latitude (deg) | float | range -90.0–90.0, default 0.0 |
| Overlay Width (deg) | float | range 0.1–360.0, default 90.0 |
| Overlay Height (deg) | float | range 0.1–180.0, default 90.0 |
| Rotation (deg) | float | range -360.0–360.0, default 0.0 |
| Overlay Alpha | float | range 0.0–1.0, default 1.0 |

## Credit

Edu Meneses + AI Assistant (Gemini)
