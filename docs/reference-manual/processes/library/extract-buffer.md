---
layout: default

title: Extract buffer
description: "Extract a single attribute buffer from a geometry"

parent: Processes
grand_parent: Reference

permalink: /processes/extract-buffer.html
---
# Extract buffer

<!-- TODO screenshot: ![Extract buffer]({{ site.img }}/reference/processes/extract-buffer.png "Extract buffer") -->

Pulls one attribute out of a geometry and exposes it as a standalone GPU buffer. This
lets you take, for instance, just the vertex positions or normals of a mesh and feed them
to another process for analysis or further processing.

## Geometry

The input geometry to read from.

## Attribute

Which attribute to extract (position, normal, colour, texture coordinates, …).

## Pad vec3 to vec4

When enabled, three-component attributes are padded to four components, which some GPU
consumers require for correct alignment.

## Output

A **GPU buffer** containing the selected attribute. See also
[Buffers to geometry](buffers-to-geometry.html) and [Repack attributes](repack-attributes.html).
