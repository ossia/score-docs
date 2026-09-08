---
layout: default

title: Geometry Info
description: "Inspect the structure and metadata of a geometry"

parent: Processes
grand_parent: Reference

permalink: /processes/geometry-info.html
---
# Geometry Info

<!-- TODO screenshot: ![Geometry Info]({{ site.img }}/reference/processes/geometry-info.png "Geometry Info") -->

Reports metadata about an incoming geometry. Useful for debugging the 3D pipeline and for
driving other processes from the actual size/shape of a mesh.

## Geometry

The geometry to inspect.

## Outputs

* **Vertices** — number of vertices.
* **Indices** — number of indices.
* **Instances** — number of instances.
* **Attributes** — number of vertex attributes.
* **Bindings** — number of buffer bindings.
* **Inputs** — number of input buffers.
* **Readable** — a human-readable string summarising the geometry, handy for display in a
  [Text](text.html) process or a log.
