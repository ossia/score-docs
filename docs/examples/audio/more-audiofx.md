---
layout: default
title: Sequencing audio effects
description: "An example showing how to sequence audio effects on the timeline"
parent: Audio
grand_parent: Examples
permalink: /examples/audio/more-audiofx.html
score: /examples/audio/more-audiofx.score
---

# Sequencing audio effects

![Jungle drum pattern routed to successive effect intervals across the timeline]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-more-audiofx.png)

This example demonstrates arranging audio effects over time. A repeating drum part takes on a different character in each section, without changing the underlying rhythm.

## Overview

The timeline moves from unprocessed drums through bitcrushing, echo, reverb, distortion and other effects. Instead of keeping every effect active throughout the piece, each interval introduces a new treatment. This is useful for building contrasts and transitions within an arrangement.

The last interval returns to the RingModulator section through a zero-duration interval. The drum interval has an interactive end, so its nominal 68-second position is not an automatic stop.

## Listen and edit

Use a build with Kaboom, BarrVerb and Airwindows available. No samples or external device are required. Configure audio output, start playback at a low volume and watch the active effect interval change. Listen for which treatments preserve the drum attacks and which blur or transform them.

Try changing Echo's feedback or Bitcrush's sample rate, then restart that section to compare. Move an interval boundary to change when the sound switches without changing the drum pattern. Trigger the end of `Drums` to stop the source, or stop the transport to finish the example.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

