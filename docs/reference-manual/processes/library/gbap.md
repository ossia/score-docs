---
layout: default

title: GBAP
description: "Grid-Based Amplitude Panning process"

parent: Processes
grand_parent: Reference

permalink: /processes/gbap.html
---

# Grid-Based Amplitude Panning (GBAP)

<img title="" src="{{ site.img }}/reference/processes/gbap/gbap_main.png" alt="" width="682">

The GBAP process is used to perform audio panning based on a 2D grid of “sinks” (virtual or real loudspeakers) in a spatialized space. It determines the weights (amplitudes) to be applied to each loudspeaker to spatialize a sound according to the position of a cursor.

## Moving cursor

- The cursor can be dragged in 2D space using the mouse. It is also possible to click on an empty area to move the cursor.

<img title="" src="{{ site.img }}/reference/processes/gbap/gbap_move.gif" alt="" width="682">

## Parameters

- **Gain :** Gain parameter adjusts the maximum volume of the various sinks.

- **Roll Off :** Roll Off parameter shapes how the amplitude decays across the grid. A higher roll-off value emphasizes the closest sinks while reducing the influence of distant ones.

- **Normalize :** When enabled, the volume values are normalized so that the highest value equals 1. This ensures the panning keeps consistent energy regardless of the number of affected sinks.

- **Sink (X or Y) # :** Defines how many sinks (speakers/outputs) are placed horizontally (`X`) and vertically (`Y`) in the 2D grid.

- **Sinks Size :** Sets the size (width and height) of each sink’s influence zone in the grid. Larger sizes make sinks cover more area.

- **Cursor Size :** Represents the area of influence (e.g., a sound source) within the grid. Bigger cursors affect more sinks, resulting in broader spatial panning.

## How to add a multicursor or an path

To allow even more creative possibilities in sound spacialization, it is possible to integrate multiple sources and automatic trajectories thanks to MultiCursor and PathGenerator.

To do this, when your Multicursor and Pathgenerator are set up, connect its output array to the second GBAP input.

<img title="" src="{{ site.img }}/reference/processes/gbap/gbap_combine.png" alt="" width="682">

**NOTE :** When an external panel is connected to the GBAP. The array integrated in the gbap is no longer taken into account and therefore has no effect on the final result.
