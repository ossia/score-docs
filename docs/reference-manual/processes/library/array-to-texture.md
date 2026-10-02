---
layout: default

title: Array to texture
description: "Pack an array of floating-point values into a GPU texture"

parent: Processes
grand_parent: Reference

permalink: /processes/array-to-texture.html
---
# Array to texture

<!-- TODO screenshot: ![Array to texture]({{ site.img }}/reference/processes/array-to-texture.png "Array to texture") -->

Packs a flat array of floating-point values into a GPU texture. This lets numeric data
be uploaded to the graphics pipeline so it can be sampled by shaders, used as a
displacement/lookup map, or visualised directly.

## Input

The list of `float` values to write into the texture.

## Size

The width and height (in pixels) of the generated texture. The input array is laid out
to fill these dimensions.

## Format

The pixel format used to store the data (e.g. single-channel float, RGBA float, …).
Choose the format that matches how the downstream shader will read the texture.

## Output

A **Texture** port connectable to any process consuming a texture (renderers, shaders,
texture utilities).
