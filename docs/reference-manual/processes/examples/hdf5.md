---
layout: default
title: "HDF5 Numeric and Texture Playback"
description: "Scan recorded numbers and images together to explore data-driven visual timing."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/hdf5.html
score: "/reference/processes/hdf5.zip"
---

# HDF5 Numeric and Texture Playback

Turn stored data into a changing trace and image, with one control governing where both readers look. The read position is a control you can animate, not a fixed march through the file.

An LFO sweeps through the available data. **HDF5 Reader** sends a numeric dataset to a signal display, while **HDF5 Texture Reader** turns another dataset into an image in the Window output. Both receive the same relative position, so they move through their data together.

## Try it

Install the HDF5 add-on, then open the ZIP directly in score. It includes the data file used by both readers. Start playback and open the Window output to see the texture next to the moving trace.

Slow the LFO to inspect changes more closely. To hold one view still while the other continues, disconnect that reader's Percentage input and set its position manually.

When substituting your own HDF5 file, update each reader's file and dataset Path controls. The numeric and texture readers need compatible dataset shapes; changing the filename alone does not make arbitrary data displayable.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

