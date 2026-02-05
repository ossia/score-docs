---
layout: default

title: Audio-reactive visuals
description: "An example showing how to create visuals that respond to audio in real-time"

parent: Video Examples
grand_parent: Examples

permalink: /examples/video/audioreactive.html
---

# Audio-Reactive Visuals

This example demonstrates creating visuals that respond dynamically to audio input.

## Overview

Audio-reactive graphics are a staple of live performance and music visualization. This example shows how to analyze audio and use the results to drive visual effects.

## Tips for audio-reactive graphics

- **Smooth your signals**: Raw audio data is noisy
- **Map ranges**: Audio values may need scaling
- **Use multiple bands**: Separate bass, mid, treble
- **Lag different parameters**: Creates depth
- **Consider attack/release**: Different response times

## Live performance

This type of patch is ideal for:
- VJ performances
- Concert visuals
- Interactive installations
- Music videos

## Try it

Connect an audio source (microphone or music) and open this example to see real-time audio-reactive graphics!

[Download this example]({{ site.scores }}/examples/video/audioreactive.score)

## Learn more

- [[Analysis]] - Audio analysis processes (RMS, FFT, pitch, onset)
- [[ISF Shaders]] - Interactive Shader Format effects
- [[Smooth]] - Signal smoothing for fluid animations
- [[Graphics pipeline]] - How the rendering system works
