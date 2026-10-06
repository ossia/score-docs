---
layout: default

title: Faust Synthesis example
description: "An example demonstrating various synthesis in multiple patches with Faust"

parent: Audio
grand_parent: Examples

permalink: /examples/audio/faust-synthesis.html
score: /examples/audio/faust-synthesis.score
---

# Faust Synthesis

![Faust Synthesis Example]({{ site.img }}/examples/audio/faust-synthesis.png "Sound Synthesis with Faust")

This example demonstrates evolving physical-model synthesis using the [[Faust]] DSP language.

## Overview

Faust compiles DSP code for your processor, allowing synthesis and effects to run within a score. Here, bells, a Tibetan bowl and plucked-string models form a changing musical texture. The timeline organizes their entrances, while modulation and automation vary their sound.

The DSP code is embedded in the document: no external samples or MIDI controller are needed. Use a build with Faust support. Configure the root interval's audio output before listening; this document has no saved `audio:/out/main` binding on its root.

## Try it

1. Start at a low listening level. Listen to the bell and bowl section, then the sitar and guitar in `Buzz`. Compare the resonant percussion with the plucked-string sounds.
2. Change the sitar's resonance or the bowl's excitation setting. Listen for how a physical model's controls affect more than just pitch.
3. Explore the `Pitch` section, where automation and the `Noisify` expression vary the pitch shift. Change the automation shape to make the transformation more regular or more abrupt.
4. Trigger Buzz's end to return to the bowl section. Freeverb and Pitch have their own interactive ends: stop them separately, or use Stop to finish everything.
5. Open a Faust process's script editor to see the model or effect behind its controls.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Audio plugins]] - Complete guide to VST, VST3, CLAP, LV2, JSFX plugins
- [[Faust]] - Writing and using Faust DSP code
- [[Audio Effects]] - Built-in audio effect processes
- [[Supported protocols and formats]] - All supported audio plugin formats
