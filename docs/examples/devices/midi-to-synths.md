---
layout: default
title: Playing synths on MIDI channels 1 and 10
description: "An example showing how to play synthesizers and drums on separate MIDI channels"
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/midi-to-synths.html
score: /examples/devices/midi-to-synths.score
---

# Playing synths on MIDI channels 1 and 10

![Synthimi feeding parallel IronOxide5 and Vibrato effects above a separate Kaboom drum chain]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-midi-to-synths.png)

This example demonstrates playing a synthesizer and drums independently through one MIDI device. Channel 1 plays Synthimi, while channel 10 plays Kaboom, leaving each instrument with its own sound and effects.

Select the channel on your MIDI source to choose the instrument. There is no internal sequencer: starting the transport alone does not supply notes.

## Setup and sound

1. Stop playback, edit `MIDI In` in the Device explorer and select a connected keyboard or MIDI source. Configure score's audio output.
2. Start playback at a low volume. Send notes on channel 1 to play Synthimi's layered, detuned saw oscillators.
3. Send drum notes on channel 10 to play Kaboom. Note 36 is included in the saved learned device tree; other drum notes depend on Kaboom's note assignments.
4. Hold a lead note and compare IronOxide5's coloration with Vibrato's pitch movement. They are processed in parallel before the shared chorus, so each contributes a different treatment of the original sound.
5. Play a drum pattern and change ZLowpass2's cutoff, then Compresaturator's Drive. Compare a darker, softer accompaniment with a brighter, more saturated one.

Synthimi, Kaboom and Airwindows must be available in the build. No samples or external plug-in files are referenced. If the selected MIDI backend cannot see your device, choose a suitable API in Settings before selecting the input again. For note-on messages with zero velocity used as note-off, configure the MIDI device's corresponding option.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

