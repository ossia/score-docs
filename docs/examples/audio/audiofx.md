---
layout: default

title: Audio Effects Example
description: "An example demonstrating various audio effect technologies supported by ossia score"

parent: Audio
grand_parent: Examples

permalink: /examples/audio/audiofx.html
score: /examples/audio/audiofx.zip
---

# Audio Effects

![Audio Effects Example]({{ site.img }}/examples/audio/audiofx.png "Audio effects chain in ossia score")

This example demonstrates how different audio effect technologies can work together in a single project.

## Overview

A granular piano and a synthesized bell provide two contrasting sounds for exploring distortion, filtering, delay and reverb. The example combines built-in effects, Airwindows processors and embedded Faust code; a separately installed VST is not required.

## Try it

1. Open the ZIP directly in score. It includes `Audio/Grand Pianos 06 80 BPM.wav`, credited in the patch to [Signature Sounds](https://signaturesounds.org/). Use a build with Granola, Faust, Airwindows and BarrVerb, and configure audio output at a low listening level.
2. Start playback and listen to the piano pattern. Press the Faust bell's gate control to hear how the same effects respond to a bell strike.
3. Change the delay feedback and listen to the repeating sound. The sample-and-hold LFO varies delay time: try a slower modulation to make each change easier to hear.
4. Listen to the two reverbs separately. Compare BarrVerb with Airwindows kCathedral5, especially the space and decay they add to each source.
5. Open a Faust process's script editor to explore its synthesis or effect code. You can also try replacing an effect with one of your own plug-ins.

ossia score can load effects from VST, VST3, LV2, CLAP and JSFX plug-ins as well as Faust. Once available in the process library, they can be used alongside the processors in this example.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Audio plugins]] - Complete guide to VST, VST3, CLAP, LV2, JSFX plugins
- [[Faust]] - Writing and using Faust DSP code
- [[Audio Effects]] - Built-in audio effect processes
- [[Supported protocols and formats]] - All supported audio plugin formats
