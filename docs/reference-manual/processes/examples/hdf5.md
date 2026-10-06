---
layout: default
title: "HDF5 Numeric and Texture Playback"
description: "Explore changing numbers and images stored in an HDF5 file."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/hdf5.html
score: "/reference/processes/hdf5.score"
---

# HDF5 Numeric and Texture Playback

This example explores two views of time-varying data: a numeric trace and a texture. An LFO scans both datasets together, letting you compare how they change.

**HDF5 Reader** provides the trace and **HDF5 Texture Reader** displays the image in `Window:/`. Both read the external file `<LIBRARY>:packages/mockup_for_JM.h5`.

The numeric dataset is `/risk_metrics_vars/agg_risk_over_time`; the texture dataset is `/highlevel_NN_vars/param_projections_over_time`. These are paths inside the HDF5 file, not filesystem paths or OSC addresses.

## Requirements and use

Install the HDF5 add-on and supply the external `mockup_for_JM.h5` file, which is not included in this loose score. Update both HDF5 file controls to its location. A different file also requires compatible dataset paths and shapes; merely renaming an arbitrary HDF5 file is not sufficient.

Start playback to scan both datasets together. The expected result is a changing numeric trace and a changing texture. Disconnect the LFO from a Percentage input to inspect a fixed position manually. Without the external data this remains a reader-routing example, not a self-contained visualization.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

