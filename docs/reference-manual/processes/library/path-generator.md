---
layout: default

title: Path Generator
description: "Generate moving XY or XYZ positions along predefined paths"

parent: Processes
grand_parent: Reference

permalink: /processes/pathgenerator.html
---

# Path Generator

<img title="" src="{{ site.img }}/reference/processes/pathgenerator/pathgenerator_main.png" alt="Path Generator" width="682">

Path Generator moves positions along predefined curves. Each source has two handles: for Linear, they are the start and end points; for curved paths, the first is the center and the second determines the size and orientation.

## Editing trajectories

Click and drag in an empty area to create a source and separate its two handles. Drag an existing handle to move it. Right-click either handle to remove the source.

<img title="" src="{{ site.img }}/reference/processes/pathgenerator/pathgenerator_move.gif" alt="Moving a handle" width="521">

<img title="" src="{{ site.img }}/reference/processes/pathgenerator/pathgenerator_add.gif" alt="Adding a trajectory" width="521">

<img title="" src="{{ site.img }}/reference/processes/pathgenerator/pathgenerator_remove.gif" alt="Removing a trajectory" width="521">

## Controls

| Control | Purpose |
|---|---|
| Speed | Multiplies progress through the process; range 0–10, default 1 |
| Ping Pong | Reverses every other traversal instead of restarting at the beginning |
| Path | Linear, Circle, Spiral, Lissajous, Rose or Polygon |
| Position | Editable collection of source handles |
| Radius | XY scale factors applied to the handle-defined size; ignored by Linear |
| Ratio X / Ratio Y | Shape controls for Lissajous, Rose and Polygon |
| Phase | Rotation or phase offset for curved paths, from 0 to 1 |
| Output mode | XY, XY0 or XYZ |
| Z | Third coordinate in XYZ mode, from 0 to 1 |

Speed is relative to the process's time position, not a fixed duration in seconds. At Speed `1`, one traversal spans one unit of normalized process progress. With Ping Pong, the next traversal runs backward.

Circle uses the handle distance as its radius before applying the XY Radius factors. Spiral makes two outward turns. For Lissajous, Ratio X and Ratio Y are the horizontal and vertical frequency multipliers. For Rose, Ratio X controls the radial oscillation and Ratio Y the number of turns. For Polygon, Ratio X sets the side count, with a minimum of three.

## Output

Output is a list of positions, one per source:

- XY: two-component positions.
- XY0: three-component positions with Z equal to zero.
- XYZ: three-component positions with Z taken from the Z control.

The curves remain planar in XYZ mode. All sources share the process's path controls and Z value, but have their own handles.

## Connections

Connect the XY output directly to [[GBAP]]'s Input Multicursor. GBAP accepts a list of source positions.

[[DBAP]] accepts one position instead. For one trajectory, pass Output through Array Flattener to obtain its coordinate pair or triple. For several trajectories, extract the position for each DBAP instance rather than flattening every position into one list.

See [[Spatial audio techniques]] for a four-speaker audio patch using Path Generator and DBAP.
