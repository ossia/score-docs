---
layout: default

title: Audio Effects Example
description: "An example demonstrating various audio effect technologies supported by ossia score"

parent: Audio
grand_parent: Examples

permalink: /examples/audio/audiofx.html
---

# Audio Effects

This example demonstrates the diverse audio effect technologies supported by ossia score.

## Overview

ossia score can load and use audio effects from multiple plugin formats, allowing you to combine tools from different ecosystems in a single project.

## Using external plugins

To use VST/VST3/LV2 plugins:

1. Set your plugin search paths in Settings
2. Plugins appear in the process library
3. Drag them onto the timeline or into the nodal view

## Built-in effects

ossia score includes many built-in effects:
- Filters (lowpass, highpass, bandpass)
- Dynamics (compressor, limiter)
- Delays and reverbs
- Distortion and bitcrush
- Granular processing

## Faust integration

Faust code can be:
- Written directly in ossia score
- Loaded from external .dsp files
- Compiled to efficient native code

## Try it

Open this example to hear how different effect technologies work together. Try swapping in your own VST plugins!

[Download this example]({{ site.scores }}/examples/audio/audiofx.score)

## Learn more

- [[Audio plugins]] - Complete guide to VST, VST3, CLAP, LV2, JSFX plugins
- [[Faust]] - Writing and using Faust DSP code
- [[Audio Effects]] - Built-in audio effect processes
- [[Supported protocols and formats]] - All supported audio plugin formats
