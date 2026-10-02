---
layout: default

title: Buffers to geometry
description: "Assemble GPU buffers into a renderable geometry"

parent: Processes
grand_parent: Reference

permalink: /processes/buffers-to-geometry.html
---
# Buffers to geometry

<!-- TODO screenshot: ![Buffers to geometry]({{ site.img }}/reference/processes/buffers-to-geometry.png "Buffers to geometry") -->

Assembles raw GPU buffers into a structured geometry that the renderer can draw. This is
the low-level counterpart to the mesh loaders: you provide the vertex/index data as
buffers and describe how to interpret them.

## Buffer inputs

Up to eight GPU buffer inputs can be connected (for example position, normal, colour,
texture-coordinate streams produced by other processes).

## Attribute specification

For each attribute you describe how to read it from the buffers:

* **Buffer** — which input buffer it comes from.
* **Offset** / **Stride** — byte layout inside the buffer.
* **Format** — component type and count.
* **Semantic** — what the attribute represents (position, normal, …).
* **Instanced** — whether the attribute advances per instance instead of per vertex.

## Index buffer

Optional index buffer configuration for indexed drawing.

## Topology / Cull

Primitive **topology** (triangles, lines, points, …) and face **culling** settings.

## Transform

Position, rotation and scale applied to the assembled geometry.

## Output

A **Geometry** port ready to be rendered or processed further.
