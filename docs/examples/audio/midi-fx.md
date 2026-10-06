---
layout: default
title: MIDI effects and arpeggiation
description: "An example showing how to transform MIDI patterns with arpeggios and scales"
parent: Audio
grand_parent: Examples
permalink: /examples/audio/midi-fx.html
score: /examples/audio/midi-fx.score
---

# MIDI effects and arpeggiation

![Arpeggiator and Midi scale feeding Pluckies, with MIDI displays beneath the processing stages]({{ site.baseurl }}/assets/scores/thumbnails/examples-audio-midi-fx.png)

This example demonstrates how MIDI effects can turn one pattern into changing musical material. Arpeggiation changes the rhythm and ordering of notes, while scale mapping changes their pitch relationships.

Three MIDI displays let you compare the original pattern, the arpeggiated notes and the scale-mapped result as you listen. Synthimi's `Pluckies` preset provides the sound, with Airwindows effects for further shaping. Both must be available in the installed build; no external MIDI device or sample file is required.

## Try the transformations

1. Select your audio output, lower the listening level and start playback. Compare the three MIDI displays.
2. Change the Arpeggiator's Rate and Octave controls. Compare a fast, wide-ranging figure with a slower pattern in a narrow register.
3. Change Midi scale's Transpose to move the register without editing the source pattern. Then try another scale and compare the melodic character.
4. Listen to the changing scale root. An LFO advances a wrapping Counter that controls Base; slow the LFO to hear each root for longer.
5. Compare the synth with and without Drive. The remaining LFOs add small oscillator-pitch changes and modulate the amplitude-envelope decay.

Try editing the source pattern only after exploring the effects. This makes it easier to distinguish changes to the composition from changes to its interpretation.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

