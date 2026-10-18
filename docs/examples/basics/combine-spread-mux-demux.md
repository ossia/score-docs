---
layout: default
title: Combining lists and selecting routes
description: "Keep several control signals together in a list, or choose one source or destination at a time."
parent: Basics
grand_parent: Examples
permalink: /examples/basics/combine-spread-mux-demux.html
score: /examples/basics/combine-spread-mux-demux.score
---

# Combining lists and selecting routes

![Three LFOs feeding parallel Mux and Demux routing and Combine and Spread branches]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-combine-spread-mux-demux.png)

Should several signals travel together, or should only one control a destination at a time? Three moving waveforms make the difference visible.

## Overview

Combine packs the three values into a list; Spread separates them again. None of the signals needs to be chosen over the others. Mux instead selects one input, and Demux sends its input to one selected output. The displays show these operations locally, without media or external devices.

## Try it

Start playback in nodal view and watch the Signal displays.

- Change Mux's **Current index** between 0, 1 and 2. The output follows the chosen waveform; the sources themselves do not change.
- Change Demux's **Current index** while a waveform is moving. Watch new values arrive at a different display. Unselected displays may retain their history, but receive no new messages.
- Follow the Combine and Spread branch. Change one LFO and find its corresponding output after the list is separated: all three signals remain available together.
- Add another signal and adjust the inlet and outlet counts to match. Decide whether the new signal should be another selectable source or another component of the group.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

