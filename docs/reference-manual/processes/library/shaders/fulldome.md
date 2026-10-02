---
layout: default

title: Fulldome shaders
description: "Shaders for fulldome / 360° workflows: cubemap, equirectangular and domemaster format conversions, bundled in the score user library."

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/fulldome.html
---
# Fulldome shaders

Shaders for fulldome / 360° workflows: cubemap, equirectangular and domemaster format conversions, bundled in the score user library.

| Preset | Description |
|---|---|
| [Video Mixer Dome]({{ site.baseurl }}/processes/shaders/fulldome/video-mixer-dome.html) | 8-channel video mixer with Aspect Ratio control |
| [Cubemap]({{ site.baseurl }}/processes/shaders/fulldome/cubemap.html) | Arranges six input cube face images into a selectable layout (Horizontal Strip, Vertical Cross, or Horizontal Cross). Each face can be individually rotated by 0, 90, 180, or 270 degrees clockwise. Defines standard cell mappings for each layout type. Empty cells in cross layouts are transparent black. Assumes input faces are standard 2D views. |
| [Cubemap To Equirectangular]({{ site.baseurl }}/processes/shaders/fulldome/cubemap-to-equirectangular.html) | Converts a cubemap atlas (strip or cross layout) to an equirectangular image. Requires knowing the layout and any rotations applied to faces in the atlas. |
| [Cubesides To Domemaster]({{ site.baseurl }}/processes/shaders/fulldome/cubesides-to-domemaster.html) | Generates a Domemaster output by projecting a rotated cubemap (6 input images). Rotations and output FOV are controllable. |
| [Domemaster Mask]({{ site.baseurl }}/processes/shaders/fulldome/domemaster-mask.html) | Applies a customizable Domemaster mask defined by a polar angle range, a color, and a feathered edge (softness). Assumes the input is a 210-degree FOV Domemaster projection. |
| [Equirectangular To Cubemap]({{ site.baseurl }}/processes/shaders/fulldome/equirectangular-to-cubemap.html) | Converts an equirectangular image to a cubemap atlas (strip or cross layout). Allows for applying rotations to each face. |
| [Equirectangular To Domemaster]({{ site.baseurl }}/processes/shaders/fulldome/equirectangular-to-domemaster.html) | Generates a Domemaster output by projecting a rotated equirectangular image. Rotations, output FOV, and horizontal flip are controllable. |
| [Half Cubesides To Domemaster]({{ site.baseurl }}/processes/shaders/fulldome/half-cubesides-to-domemaster.html) | Optimized single-pass Domemaster. Maps raw 2:1 images to top/bottom halves, rotating bottom 180. Includes API-level input flips. |
| [Hexagonal Faces To Domemaster]({{ site.baseurl }}/processes/shaders/fulldome/hexagonal-faces-to-domemaster.html) | Hexagonal Prism Domemaster. 6 side faces (split into top/bottom halves, bottom rotated 180) + 2 pole faces. Preserves transparency. |
| [Image To Equirectangular]({{ site.baseurl }}/processes/shaders/fulldome/image-to-equirectangular.html) | Overlays an image onto an equirectangular projection with true spherical distortion. Allows 3D positioning, rotation, and scaling of the overlay on the sphere. Surrounding space is transparent or shows a base equirectangular image. |
