---
layout: default

title: Envelope Follower
description: "Audio envelope detection for CV-like control"

parent: Processes
grand_parent: Reference

permalink: /processes/envelope-follower.html
---
# Envelope Follower

![Envelope Follower]({{ site.img }}/reference/processes/envelope-follower.png "Audio Envelope Follower")

The Envelope Follower extracts the amplitude envelope from audio signals, converting them to control voltages suitable for modulating other parameters. Based on [Kevin Ferguson's algorithm](https://kferg.dev/posts/2020/audio-reactive-programming-envelope-followers/), it provides smooth, responsive envelope detection that stays in the audio domain for CV-like control.

## Overview

The Envelope Follower enables:
- Real-time envelope extraction from audio
- CV-style control signal generation
- Audio-reactive parameter modulation
- Smooth amplitude tracking
- Low-latency envelope detection

Perfect for:
- Audio-reactive visuals
- Sidechain-style effects
- Dynamic parameter control
- Live audio analysis
- Expressive instrument design


## Related Processes

- [Analysis](/processes/analysis.html) - Audio feature extraction
- [Gate](/processes/gate.html) - Amplitude gating
- [Compressor](/processes/audio-effects.html) - Dynamic range control
- [LFO](/processes/lfo.html) - Alternative modulation source