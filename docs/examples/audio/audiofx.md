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

Granola and a Faust `StandardChurchBell` feed Airwindows Drive, a Faust lowpass and `smoothDelay`. The delay splits into two reverbs, BarrVerb and Airwindows kCathedral5, both routed to the parent mix at `audio:/out/main`.

## Prepare and listen

1. Open the ZIP directly in score. Granola uses the bundled `Audio/Grand Pianos 06 80 BPM.wav`, credited in the patch to [Signature Sounds](https://signaturesounds.org/).
2. Configure audio output and start at a low listening level. The installed build needs Granola, Faust, Airwindows and BarrVerb; this saved graph does not depend on a separately installed VST.
3. Start playback. A looping Piano roll feeds Midi filter, which extracts note-on pitch. Micromap computes `pow(2, (x - 69) / 12)` to drive Granola's pitch ratio.
4. Press the Faust bell's gate control to add a bell strike. Both sources enter the same effect chain.
5. Follow the sample-and-hold LFO into the delay-time inlet. Change feedback and compare the two reverb branches separately to hear how their tails differ.

The script button opens the embedded Faust source. The bell uses `pm.standardBell_ui`, while the delay uses `de.sdelay` to interpolate delay-time changes. External VST, VST3, LV2, CLAP and JSFX effects can be added from the process library, but they are not required to reproduce this archive's routing.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Audio plugins]] - Complete guide to VST, VST3, CLAP, LV2, JSFX plugins
- [[Faust]] - Writing and using Faust DSP code
- [[Audio Effects]] - Built-in audio effect processes
- [[Supported protocols and formats]] - All supported audio plugin formats
