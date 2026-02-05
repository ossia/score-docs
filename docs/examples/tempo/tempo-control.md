---
layout: default

title: Tempo manipulation
description: "An example showing how to control and automate tempo"

parent: Tempo Examples
grand_parent: Examples

permalink: /examples/tempo/tempo-control.html
---

# Tempo Manipulation

This example demonstrates tempo control and musical timing features in ossia score.

## Overview

ossia score supports variable tempo throughout a composition, allowing accelerando, ritardando, and complex tempo changes.

## Tempo features

ossia score provides several tempo-related features:

| Feature | Description |
|---------|-------------|
| Tempo process | Sets a fixed tempo |
| Tempo automation | Gradual tempo changes |
| Time signatures | Beat groupings |
| Quantization | Snap to beats |
| Audio stretch | Tempo-synced audio |

## Variable tempo

Unlike most DAWs, ossia score supports:
- Different tempos in different sections
- Smooth transitions between tempos
- Modulated tempo (LFO, random, etc.)
- Independent timing for sub-scenarios

## Working with tempo

To change tempo in a project:

1. Add a Tempo process to an interval
2. Set the desired BPM
3. Audio files can time-stretch to match
4. MIDI notes quantize to the beat grid

## Musical applications

Variable tempo is useful for:
- Film scoring (following picture)
- Live performance (flexible timing)
- Experimental music (non-metric time)
- Interactive installations

## Try it

Open this example to hear tempo changes affecting audio playback!

[Download this example]({{ site.scores }}/examples/tempo/tempo.score)

## Learn more

- [[Tempo]] - Tempo process reference
- [[Musical metrics]] - Time signatures, quantization, polyrhythm
- [[Scenario]] - Timeline container and timing
