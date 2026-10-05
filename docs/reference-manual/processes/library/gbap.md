---
layout: default

title: GBAP
description: "Grid-Based Amplitude Panning for spatial audio"

parent: Processes
grand_parent: Reference

permalink: /processes/gbap.html
---

# Grid-Based Amplitude Panning (GBAP)

<img title="" src="{{ site.img }}/reference/processes/gbap/gbap_main.png" alt="GBAP grid" width="682">

GBAP calculates weights for a rectangular grid of sinks. Cursor and sink sizes determine how a source overlaps the grid; RollOff shapes the distribution. The result is control data for processes such as [[Matrix Spatialization]], not an audio signal.

## Inputs and output

| Port | Value |
|---|---|
| Input Weights | List of incoming gains; System Number selects one entry |
| Input Multicursor | List of XY source positions |
| Output Weights | List of weight lists, one list per source |

When Input Multicursor contains positions, they replace the internal Position control. When it is empty, GBAP calculates one weight list from Position. Each list contains Sink X # multiplied by Sink Y # weights, with X varying first.

## Controls

| Control | Purpose |
|---|---|
| Gain | Overall multiplier, from 0 to 1 |
| RollOff | Shapes the weight distribution, from 0 to 24; default 6 |
| Normalize | Scales each source's largest weight to 1 before applying Gain and the selected input weight |
| Sink X # / Sink Y # | Grid dimensions, each from 1 to 12 |
| System Number | One-based index into Input Weights |
| Sink Size | XY size of each sink |
| Cursor Size | XY size of the source's overlap area |
| Position | Internal source position in the 0–1 XY area |

Normalize is peak normalization, not constant-power normalization. Gain and the selected input weight are applied afterward.

System Number must select an existing Input Weights entry. Otherwise the output is zero. For a standalone spatializer, send `[1]` to Input Weights and set System Number to `1`.

## Moving a source

Drag the cursor in the grid, click a new position, or automate Position.

<img title="" src="{{ site.img }}/reference/processes/gbap/gbap_move.gif" alt="Moving the source" width="682">

For external positions, connect [[Multi-Cursor Manager]] or [[Path Generator]] in XY output mode to Input Multicursor.

<img title="" src="{{ site.img }}/reference/processes/gbap/gbap_combine.png" alt="Connecting source positions" width="682">

## Applying weights to audio

For one source and four speakers:

1. Set Sink X # and Sink Y # to `2`.
2. Send `[1]` to Input Weights and set System Number to `1`.
3. Leave Input Multicursor empty and move the internal Position.
4. Connect Output Weights to Array Flattener, then connect the flattened result to [[Matrix Spatialization]]'s Weights inlet.
5. Connect a mono audio source to Matrix Spatialization's Input. Set Audio outs to `4` and Channel offset to `0`.
6. Route its audio output to the four loudspeaker channels.

For several sources, extract each nested weight list and send it to a separate Matrix Spatialization instance with the corresponding mono audio source. Flattening all source lists together does not create an audio mixing matrix.

## Related processes

[[DBAP]] supports irregular speaker layouts. [[Multi-Cursor Manager]] supplies editable positions; [[Path Generator]] supplies moving positions. See [[Spatial audio techniques]] for a complete DBAP patch.
