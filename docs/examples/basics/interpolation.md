---
layout: default
title: Weighted and time-based interpolation
description: "Morph between control waveforms and soften abrupt changes while listening to their effect on a sequenced synthesizer."
parent: Basics
grand_parent: Examples
permalink: /examples/basics/interpolation.html
score: /examples/basics/interpolation.score
---

# Weighted and time-based interpolation

![Nodes and LFO interpolation branches connected to a sequenced synthesizer and effects]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-interpolation.png)

Hear a sequenced synthesizer move between different kinds of motion instead of merely switching from one setting to another. One branch blends a smooth and a stepped control waveform; another turns abrupt changes into transitions. The notes of the phrase never change.

## Overview

Nodes assigns weights to a sine and a square LFO, and Interpolator blends them. Moving the input point changes their influence on the result. Those values alter synthesizer ratios and delay time, so moving the point changes timbre and echo.

Easetanbul answers a different question: how should a control travel from its old value to its new one? It eases changes from a separate square LFO, shaping the bitcrushing and delay feedback. Signal plots help separate the shape of the control from its audible effect.

## Try it

1. Configure audio output and start playback at a low level.
2. Watch the blended signal next to the original waveforms. Disconnect PathGenerator from Object filter to move Nodes' **Input Point** manually. Move near each point, then between them, and switch weighting modes: each mode hands over from one waveform to the other differently.
3. Increase Easetanbul's **Delay**, then reduce it. Watch the transition between successive values and listen to how quickly the bitcrushing and delay feedback follow a change.
4. Replace one LFO waveform: the blend now mixes a different shape, while the musical sequence stays the same.

There are no sample files or external devices. The installed build must provide Nodes, PathGenerator, Object filter, FoMo, Faust and Airwindows in addition to the core control processes.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

