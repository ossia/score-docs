---
layout: default

title: Array to mesh
description: "Build a mesh geometry from an array of floating-point values"

parent: Processes
grand_parent: Reference

permalink: /processes/array-to-mesh.html
---
# Array to mesh

<!-- TODO screenshot: ![Array to mesh]({{ site.img }}/reference/processes/array-to-mesh.png "Array to mesh") -->

Converts a flat array of floating-point values into a 3D mesh geometry. This is useful
to turn computed or incoming numeric data (sensors, generative algorithms, audio
analysis, etc.) into renderable geometry that can be fed to the 3D pipeline.

## Input

The list of `float` values to interpret as mesh data.

## Triangulate

When enabled, the incoming points are triangulated into a filled surface. When disabled,
the data is kept as a raw point/line set.

## Position / Rotation / Scale

Standard transform controls applied to the resulting geometry before it is sent to the
output.

## Output

A **Geometry** port that can be connected to any 3D process expecting a mesh
(renderer, geometry filters, etc.).
