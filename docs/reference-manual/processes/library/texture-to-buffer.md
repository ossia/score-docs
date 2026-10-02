---
layout: default

title: Texture to buffer
description: "Read back a GPU texture into a buffer"

parent: Processes
grand_parent: Reference

permalink: /processes/texture-to-buffer.html
---
# Texture to buffer

<!-- TODO screenshot: ![Texture to buffer]({{ site.img }}/reference/processes/texture-to-buffer.png "Texture to buffer") -->

Copies the contents of a GPU texture into a GPU buffer, so that pixel data produced on the
graphics side can be consumed by processes that work on raw buffers. It is the inverse of
[Array to texture](array-to-texture.html).

## Texture

The input texture to read.

## Output

A **GPU buffer** holding the texture's data, connectable to buffer-consuming processes
(e.g. [Buffers to geometry](buffers-to-geometry.html)).
