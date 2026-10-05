---
layout: default
title: Combining lists and selecting routes
description: "Compare Combine and Spread with Mux and Demux using three visible LFO signals."
parent: Basics
grand_parent: Examples
permalink: /examples/basics/combine-spread-mux-demux.html
score: /examples/basics/combine-spread-mux-demux.score
---

# Combining lists and selecting routes

Three LFOs, including square and noise waveforms, each feed two branches. Mux inlets selects one of the three signals; Combine inlets keeps all three as a list. Signal displays show the selected signal, the combined list and the individual outputs downstream.

## Compare the branches

1. Start playback in nodal view. This example generates control values only: it needs no files, external devices or audible output.
2. Set Mux inlets' Current index to 0, 1 and 2. Its output display changes to the corresponding LFO waveform.
3. That selected signal also feeds Demux outlets. Change Demux's Current index: only the selected outlet receives new messages, visible in its connected display. The other displays can retain their previous history.
4. Follow Combine inlets into Spread array. Combine creates a three-element list; Spread sends its elements to three separate outlets. All three LFO waveforms are available simultaneously in this branch, with no selection index.

All four routing processes have their inlet or outlet count set to three. Keep those counts consistent when extending the patch with another signal.

[Download this example]({{ site.scores }}{{ page.score }})
