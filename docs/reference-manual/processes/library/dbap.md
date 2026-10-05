---
layout: default

title: DBAP
description: "Distance-Based Amplitude Panning for spatial audio"

parent: Processes
grand_parent: Reference

permalink: /processes/dbap.html
---

# Distance-Based Amplitude Panning (DBAP)

DBAP calculates loudspeaker gains from the distances between one source and a list of speakers. It produces control data, not audio. Use [[Matrix Spatialization]] to apply the gains to a mono sound source.

Two processes are available: DBAP (2D) takes XY coordinates; DBAP (3D) takes XYZ coordinates.

## Inputs and output

| Port | Value |
|---|---|
| Source | One XY or XYZ position |
| Speakers | List of speaker positions, in output-channel order |
| Blur | Additional distance term that broadens the gain distribution |
| Roll-off | Relative-distance exponent control, from 0 to 100; default 6 |
| Output | Flat list of gains, one per speaker |

Source is the first inlet; Speakers is the second. Use the same coordinate system for both.

## Gain calculation

For each speaker, the distance is the Euclidean source-to-speaker distance with Blur squared added under the square root. A small offset avoids division by zero. The gain is the inverse of this distance raised to `Roll-off × 0.166096`.

The gains are then normalized so their squared sum is one. Increasing Roll-off concentrates the distribution on nearby speakers; increasing Blur makes it broader. This normalization does not provide overall distance attenuation when a source moves away from the array.

## Connecting a source

1. Send speaker positions from [[Multi-Cursor Manager]] to Speakers for a 2D layout.
2. Send the source position to Source. [[Path Generator]] produces a list of positions: with one trajectory, use Array Flattener to turn its output into a coordinate pair or triple.
3. Connect Output to Matrix Spatialization's Weights.
4. Connect a mono audio source to Matrix Spatialization's Input, set Audio outs to the speaker count and Channel offset to zero.
5. Route the resulting audio channels to the loudspeakers.

Use a separate DBAP instance for each independently moving source. For a regular grid, see [[GBAP]].
