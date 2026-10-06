---
layout: default
title: Combining lists and selecting routes
description: "An example showing how to combine, separate and switch between control signals"
parent: Basics
grand_parent: Examples
permalink: /examples/basics/combine-spread-mux-demux.html
score: /examples/basics/combine-spread-mux-demux.score
---

# Combining lists and selecting routes

![Three LFOs feeding parallel Mux and Demux routing and Combine and Spread branches]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-combine-spread-mux-demux.png)

This example demonstrates two ways to organize control signals: keeping several values together, or choosing which signal to use.

## Overview

Combine and Spread pack values into a list and separate them again. Mux and Demux instead select an input or output, making them useful for switching between controllers or destinations. Three LFOs provide visible signals so you can compare these operations without external devices or media.

## Try it

Start playback in nodal view and watch the Signal displays.

- Change Mux's Current index between 0, 1 and 2 to choose a waveform.
- Change Demux's Current index to send that waveform to a different display. The other displays may retain their previous history, but receive no new messages.
- Compare this with Combine and Spread: all three signals remain available together, without a selection index.
- Add another signal and adjust the inlet and outlet counts to match.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

