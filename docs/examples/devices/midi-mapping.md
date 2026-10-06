---
layout: default
title: MIDI controls for a shader
description: "An example showing how to control visual effects with MIDI"
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/midi-mapping.html
score: /examples/devices/midi-mapping.score
---

# MIDI controls for a shader

![MIDI note filtering and smoothing connected to Triangle Square Twist over its generated line pattern]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-midi-mapping.png)

This example demonstrates playing a visual instrument with a MIDI controller. Wheels and notes change the size, rotation and shape of a generated line pattern, making familiar musical gestures useful for live visuals.

The image comes from the native ISF shader `Triangle Square Twist`, not a Qt Quick 3D scene. No video or model file is needed, and the example produces visuals only.

## Connect and play

1. With playback stopped, right-click `MIDI In`, choose Edit and select your actual MIDI input. The saved default port may not exist on your machine.
2. Use Learn on that device and move your controls if their addresses are not present. Confirm values change in the Device explorer before starting playback.
3. Start playback and send channel 1 CC1: `MIDI In:/1/control/1` controls zoom. Channel 1 pitch bend controls both rotate and amplitude.
4. Send note 36 on channel 10. Its note-on velocity at `MIDI In:/10/on/36` controls `triside1`; this is a different channel from the wheel mappings.
5. Play a run of notes and watch the twist change smoothly rather than jump between values. The notes are converted to a normalized control value and passed through Exp Smoothing.

## Try it

Play alternating low and high notes, then change Exp Smoothing's Alpha from its saved 0.01. Compare a slow visual transition with a more immediate response. Try using pitch bend and the modulation wheel together to combine rotation with zoom.

To use another control, drag its learned address onto the shader inlet or edit that inlet's address. The wheel mappings use device parameter domains directly; the note-to-twist mapping shows how an explicit conversion and smoothing can give a different kind of response.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

