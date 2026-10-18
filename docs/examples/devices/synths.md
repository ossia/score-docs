---
layout: default
title: MIDI synth and drum effects patch
description: "Contrast a widened synth lead with filtered, saturated drums while preserving independent MIDI control of each part."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/synths.html
score: /examples/devices/synths.score
---

# MIDI synth and drum effects patch

![Parallel Synthimi effects feeding ChorusEnsemble above Kaboom's filter and saturator chain]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-synths.png)

Give a lead and a drum part different sonic spaces without changing the notes you play. The lead blends saturation and vibrato before a shared chorus; the drums pass through filtering and saturation of their own.

It is a companion to [Playing synths on MIDI channels 1 and 10]({{ site.baseurl }}/examples/devices/midi-to-synths.html), with a different saved Kaboom drum sound. Both use channel 1 for the lead and channel 10 for percussion.

## Play the patch

1. Stop playback and edit `MIDI In` to select your keyboard or software MIDI source. Set up the audio device and lower the output level before starting: the saved IronOxide5 input and output trims are boosted.
2. Start playback and send notes on channel 1 to hear Synthimi's detuned saw voices. No internal sequencer supplies notes.
3. Switch the source to channel 10 and send drum notes, beginning with note 36. Change Kaboom's Pitch or pitch envelope while repeating a hit: a deeper envelope makes the pitch sweep more during the attack.
4. Hold the lead notes steady and change ChorusEnsemble's Dry/Wet. Then keep the drum rhythm fixed and adjust ZLowpass2's frequency and Compresaturator's Drive. Try a restrained lead against aggressive drums, then reverse the contrast.

The lead's saturation and vibrato run in parallel, so neither is simply an effect on the other's output. Listen to each treatment separately before blending them, and keep the blend's level matched so it does not just sound louder.

The build needs Synthimi, Kaboom and Airwindows. No samples are required. If playback is silent, first check the selected MIDI port and channel: the transport alone supplies no notes.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

