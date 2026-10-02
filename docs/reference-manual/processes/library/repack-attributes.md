---
layout: default

title: Repack attributes
description: "Repack geometry attributes into a single interleaved buffer"

parent: Processes
grand_parent: Reference

permalink: /processes/repack-attributes.html
---
# Repack attributes

<!-- TODO screenshot: ![Repack attributes]({{ site.img }}/reference/processes/repack-attributes.png "Repack attributes") -->

Takes a geometry and repacks the chosen attributes into a single, interleaved GPU buffer
with a predictable layout. This is useful when feeding geometry data to a custom shader or
compute pass that expects a specific vertex layout.

## Geometry

The input geometry whose attributes will be repacked.

## Attribute selection

Choose which attributes to include in the packed buffer:

* **Position**
* **Normal**
* **Color**
* **TexCoord**
* **Tangent**

Only the selected attributes are written, in order, into the output buffer.

## Outputs

* **Buffer** — the interleaved GPU buffer.
* **Stride** — the byte stride of one vertex in the packed buffer, needed to read it back.

See also [Extract buffer](extract-buffer.html) and [Buffers to geometry](buffers-to-geometry.html).
