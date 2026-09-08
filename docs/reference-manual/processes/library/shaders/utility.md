---
layout: default

title: Utility shaders
description: "Helper GLSL shaders for compositing, cropping, masking and routing video, bundled in the score user library."

parent: Processes
grand_parent: Reference

permalink: /processes/shaders/utility.html
---
# Utility shaders

Helper GLSL shaders for compositing, cropping, masking and routing video, bundled in the score user library.

| Preset | Description |
|---|---|
| [Crop Edges]({{ site.baseurl }}/processes/shaders/utility/crop-edges.html) | Crop an image by its left, right, bottom, and top edges. The cropped region is remapped to fill the output |
| [Crop]({{ site.baseurl }}/processes/shaders/utility/crop.html) | Crop a normalized rectangle from the input image and stretch it to the output. Two modes: Center+Size or Corners. |
| [Grid]({{ site.baseurl }}/processes/shaders/utility/grid.html) | Display up to 16 image inputs in a mosaic grid for previsualization. The grid layout adapts automatically to the number of active inputs. |
| [Layer]({{ site.baseurl }}/processes/shaders/utility/layer.html) | Layer videos on top of each other. First texture is at the bottom. |
| [Mask]({{ site.baseurl }}/processes/shaders/utility/mask.html) | Apply a mask |
| [Passthrough]({{ site.baseurl }}/processes/shaders/utility/passthrough.html) | Copy the input texture without changes |
| [Tiny Date Time Overlay]({{ site.baseurl }}/processes/shaders/utility/tiny-date-time-overlay.html) | Draws a small (80x48 pixel) time / date stamp. |
| [Transform]({{ site.baseurl }}/processes/shaders/utility/transform.html) | 2D image transform with translate, rotate, scale, pivot, tiling, and edge extend modes. |
| [Video Mapper]({{ site.baseurl }}/processes/shaders/utility/video-mapper.html) | Moves the vertex points to the specified locations without correction |
| [Video Mixer]({{ site.baseurl }}/processes/shaders/utility/video-mixer.html) | 8-channel video mixer (Optimized) |
| [Video Switcher 16]({{ site.baseurl }}/processes/shaders/utility/video-switcher-16.html) | Video switcher |
| [Video Switcher 4]({{ site.baseurl }}/processes/shaders/utility/video-switcher-4.html) | Video switcher |
| [Video Switcher 8]({{ site.baseurl }}/processes/shaders/utility/video-switcher-8.html) | Video switcher |
| [image_editor]({{ site.baseurl }}/processes/shaders/utility/image-editor.html) | Transforms an input image: scale, rotate (positive angle for CW image rotation), flip, and position. |
