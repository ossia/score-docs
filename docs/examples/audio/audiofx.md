---
layout: default

title: Audio Effects Example
description: "Turn piano fragments and bell strikes into distorted, echoing spaces, and compare how two sound sources excite the same effects."

parent: Audio
grand_parent: Examples

permalink: /examples/audio/audiofx.html
score: /examples/audio/audiofx.zip
---

# Audio Effects

![Granular piano and a Faust bell feeding a shared delay and two reverbs]({{ site.img }}/examples/audio/audiofx.png "Audio effects chain in ossia score")

A piano fragment can become a pitched pattern, a distorted pulse or a wash of echoes. Here it shares an effects chain with a bell that you strike by hand. Compare their attacks and decays to hear how the source shapes the result, even when the processing stays the same.

## From gesture to space

MIDI notes change the granular piano's pitch; the bell adds an independent live gesture. Both pass through drive, a lowpass filter and a modulated delay before reaching two parallel reverbs. This is a useful layout for a performance in which sequenced material and live accents need to inhabit the same sonic space. Built-in effects, Airwindows and embedded Faust code work together; no separately installed VST is required.

## Try it

1. Open the ZIP directly in score. The piano recording is included and credited in the patch to [Signature Sounds](https://signaturesounds.org/). Use a build with Granola, Faust, Airwindows and BarrVerb; configure audio output at a low listening level.
2. Start playback, then press the Faust bell's gate control. Listen to the difference between the repeating piano and a single bell strike passing through the same chain.
3. Increase delay feedback cautiously to hear repeats persist. Slow the sample-and-hold LFO to separate the changes in delay time: modulation reshapes the echoes rather than the original notes.
4. Mute one reverb at a time to compare BarrVerb with Airwindows kCathedral5. Listen to the space around an attack and the tail after it, then decide which would suit a sparse passage.
5. Edit the piano-roll notes while leaving the effects unchanged. Compare a new phrase with a new treatment of the original phrase before adapting the chain to your own source.

ossia score can load effects from VST, VST3, LV2, CLAP and JSFX plug-ins as well as Faust. Once available in the process library, they can be used alongside the processors in this example.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Audio plugins]] - Complete guide to VST, VST3, CLAP, LV2, JSFX plugins
- [[Faust]] - Writing and using Faust DSP code
- [[Audio Effects]] - Built-in audio effect processes
- [[Supported protocols and formats]] - All supported audio plugin formats
