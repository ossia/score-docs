---
layout: default
title: Buffers to geometry
description: "Describe geometry attributes and draw settings over GPU buffers"
parent: Processes
grand_parent: Reference
permalink: /processes/buffers-to-geometry.html
---

# Buffers to geometry

**Buffers to geometry** wraps GPU buffers in a geometry description. It does not infer a mesh layout from the bytes: formats, offsets, strides and draw settings must agree with the upstream producer. The output is **Geometry**, not a scene hierarchy.

## Buffer and attribute setup

Connect buffers to **Buffer 0–7**. Each of the eight attribute slots has these controls:

| Control | Meaning |
|---|---|
| AttrN buffer | Input buffer number, 0–7. `-1` disables the attribute. |
| AttrN offset | Byte offset from the beginning of the connected buffer view. |
| AttrN stride | Byte distance between records. `0` uses the selected format's tightly packed size. |
| AttrN format | Component representation: Float, Half, unsigned/signed integer, short or normalized byte formats with the available component counts. |
| AttrN semantic | Attribute meaning, such as `position`, `normal`, `texcoord0` or `color0`. Custom attribute names are preserved for consumers that understand them. |
| AttrN instanced | Advance this attribute per instance rather than per vertex. |

Several attributes can refer to the same interleaved buffer. Their offsets differ but their record strides must match.

## Draw settings

| Control | Meaning |
|---|---|
| Index Buffer | Buffer 0–7 containing indices, or `-1` for no index buffer. |
| Index Format | UInt16 or UInt32. |
| Index Offset | Byte offset into the connected index-buffer view. |
| Vertices | Geometry draw count. Set it to match the intended draw; the process does not derive it from buffer size. |
| Instances | Number of instances, starting at 1. Supply enough records for instanced attributes. |
| Topology | Triangles, TriangleStrip, TriangleFan, Lines, LineStrip or Points. |
| Cull Mode | None, Front or Back. |
| Front Face | CounterClockwise or Clockwise winding. |
| Position, Rotation, Scale | XYZ translation, Euler rotation in degrees and per-axis scale. |

## Example: tightly packed XYZ positions

1. Use **Array to buffer** from [[Geometry and buffer utilities]] to convert `[0, 0, 0, 1, 0, 0, 0, 1, 0]` to Float32.
2. Connect its output to **Buffer 0**.
3. Set **Attr0 buffer** to `0`, **Attr0 format** to Float3, **Attr0 semantic** to `position`, **Attr0 offset** to `0` and **Attr0 stride** to `12` bytes.
4. Leave other attributes and **Index Buffer** at `-1`. Set **Vertices** to `3`, **Instances** to `1`, **Topology** to Triangles and **Cull Mode** to None.
5. Inspect **Geometry** with [[Geometry Info]] before connecting it to the [[Render Pipeline]].

For interleaved Float3 positions followed by Float3 normals, use a 24-byte stride for both attributes and offsets of 0 and 12 bytes respectively. The data format describes the existing bytes; selecting another format does not convert them.

## Distinct library entries

**Buffers to geometry (v1)** is a separate registered process using numeric attribute locations. This page describes the current named-semantic version; use it for new patches unless an existing layout specifically requires v1. For extracting or reorganizing existing geometry, see [[Extract buffer]] and [[Repack attributes]].
