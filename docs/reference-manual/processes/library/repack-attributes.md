---
layout: default
title: Repack attributes
description: "Pack selected geometry attributes into a GPU buffer"
parent: Processes
grand_parent: Reference
permalink: /processes/repack-attributes.html
---

# Repack attributes

**Repack attributes** takes **Geometry** and creates a GPU **Buffer** containing selected vertex attributes. Use it when a compute or rendering consumer needs a different packing from the geometry loader's original layout.

## Controls and outputs

| Control | Available selections |
|---|---|
| Position | None, Vec3, Vec4 |
| Normal | None, Vec3, Vec4 |
| Color | None, Vec3, Vec4 |
| TexCoord | None, Vec2 |
| Tangent | None, Vec3, Vec4 |

**None** omits an attribute. Vec4 requests padding of a three-component attribute to a four-component record. These selectors are not merely on/off switches, nor do they generate missing normals, colors or UVs. Inspect the source with [[Geometry Info]] and select attributes that it actually contains.

Selected attributes are interleaved in this order: **Position, Normal, Color, TexCoord, Tangent**. The **Buffer** outlet carries the packed data; **Stride** reports the resulting byte distance between records. Use that reported stride rather than assuming every loader uses the same layout.

## Workflow

1. Connect a geometry producer to **Geometry**.
2. Select only the attributes your downstream process needs and the required padding.
3. Connect **Buffer** to the consumer and configure its layout using **Stride** and the selected attribute order.
4. If the consumer needs a geometry description rather than raw bytes, use [[Buffers to geometry]] to supply semantics and draw settings.

The result is a buffer, not a transformed or re-rendered geometry output. For one attribute or an unchanged whole source buffer, [[Extract buffer]] is the simpler tool. See [[Geometry and buffer utilities]] for the complete conversion workflow.
