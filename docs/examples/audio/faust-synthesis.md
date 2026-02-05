---
layout: default

title: Faust Synthesis example
description: "An example demonstrating various synthesis in multiple patches with Faust"

parent: Audio
grand_parent: Examples

permalink: /examples/audio/faust-synthesis.html
---

# Faust Synthesis

![Faust Synthesis Example]({{ site.img }}/examples/audio/faust-synthesis.png "Sound Synthesis with Faust")

This example demonstrates a simple example of evolutive physical modeling synthesis using the [[Faust]] DSP language, integratee

## Overview

ossia score can load and use [[Faust]] synthesis DSP plug-ins. Faust is extremely efficient: it compiles DSP code
directly for your processor's architecture using LLVM's state-of-the-art compiler infrastructure.

## Try it

Open this example to hear the synthesis example.

[Download this example]({{ site.scores }}/examples/audio/faust-synthesis.score)

## Learn more

- [[Audio plugins]] - Complete guide to VST, VST3, CLAP, LV2, JSFX plugins
- [[Faust]] - Writing and using Faust DSP code
- [[Audio Effects]] - Built-in audio effect processes
- [[Supported protocols and formats]] - All supported audio plugin formats
