---
layout: default

title: Faust Synthesis example
description: "Move between ringing bowls, bells and plucked strings, using physical-model controls and interactive sections to shape a synthetic ensemble."

parent: Audio
grand_parent: Examples

permalink: /examples/audio/faust-synthesis.html
score: /examples/audio/faust-synthesis.score
---

# Faust Synthesis

![Faust instruments arranged in bowl, plucked-string and pitch-processing sections]({{ site.img }}/examples/audio/faust-synthesis.png "Sound Synthesis with Faust")

Ringing bells and bowls give way to buzzing, plucked strings in a small synthetic ensemble. The sounds come from physical models rather than recordings: changing how a model is excited can alter the character of a strike or pluck as well as its pitch.

## Compose with the models

The timeline brings the instruments in and out, while modulation changes their excitation and resonance. Reverb connects the sections, and a later pitch-shifting layer transforms the plucked sounds. You can use this structure for an evolving installation texture or a performed passage whose return is cued rather than fixed.

The [[Faust]] DSP code is embedded, so no samples or MIDI controller are needed. Use a build with Faust support and assign the root interval's audio output before listening; the saved root has no output destination.

## Try it

1. Start at a low listening level. Follow the bell and bowl section into `Buzz`, where sitar and guitar models take over. Listen for the difference between sustained resonance and the attack of a pluck.
2. Change the Step sequencer values driving the sitar's Resonance. This changes the repeating timbral gesture without changing its MIDI notes. The bowl's excitation is also modulated; adjust its LFO to hear a different pattern of excitation.
3. In `Pitch`, reshape the automation feeding `Noisify`. Compare a smooth contour with abrupt changes and listen to how the pitch-shifted layer moves against the source.
4. Trigger the end of `Buzz` to return to the bowl section. Try holding the plucked section longer before returning: the cue changes the form without rewriting the material. Freeverb and Pitch have independent end triggers; use Stop to finish everything.
5. Open a Faust process's script editor to connect the audible controls with its model or effect. Replacing a model is a possible adaptation; the saved score already supplies the timeline and modulation around it.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Audio plugins]] - Complete guide to VST, VST3, CLAP, LV2, JSFX plugins
- [[Faust]] - Writing and using Faust DSP code
- [[Audio Effects]] - Built-in audio effect processes
- [[Supported protocols and formats]] - All supported audio plugin formats
