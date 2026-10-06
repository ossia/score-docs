---
layout: default
title: Weighted and time-based interpolation
description: "An example showing different ways to interpolate between values"
parent: Basics
grand_parent: Examples
permalink: /examples/basics/interpolation.html
score: /examples/basics/interpolation.score
---

# Weighted and time-based interpolation

![Nodes and LFO interpolation branches connected to a sequenced synthesizer and effects]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-interpolation.png)

This example demonstrates two approaches to interpolation: blending several signals and smoothing a change over time. Both can help turn simple control sources into more expressive musical gestures.

## Overview

Nodes supplies weights for blending a sine and a square LFO with Interpolator. Moving between the points changes their influence on the result. A separate example uses Easetanbul to ease the abrupt changes of a square LFO.

The controls affect a sequenced synthesizer and its effects, so you can hear the difference as well as inspect the signal plots.

## Try it

1. Configure audio output and start playback at a low level.
2. Compare the original waveforms with the blended signal. Disconnect PathGenerator from Object filter to move Nodes' Input Point manually, and compare its weighting modes.
3. Change Easetanbul's Delay and watch the transition between successive values. Listen to the corresponding changes in bitcrushing and delay feedback.
4. Try another waveform, or adjust a mapping to explore a different range of effect settings.

There are no sample files or external devices. The installed build must provide Nodes, PathGenerator, Object filter, FoMo, Faust and Airwindows in addition to the core control processes.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

