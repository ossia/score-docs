---
layout: default
title: Playing synths on MIDI channels 1 and 10
description: "Route a MIDI keyboard to Synthimi and a drum channel to Kaboom, with separate effect chains."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/midi-to-synths.html
score: /examples/devices/midi-to-synths.score
---

# Playing synths on MIDI channels 1 and 10

![Synthimi feeding parallel IronOxide5 and Vibrato effects above a separate Kaboom drum chain]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-midi-to-synths.png)

The MIDI input is split by port addresses rather than filter processes: Synthimi reads `MIDI In:/1`, and Kaboom reads `MIDI In:/10`. There is no internal sequencer, so starting the transport alone does not supply notes.

## Setup and sound

1. Stop playback, edit `MIDI In` in the Device explorer and select a connected keyboard or MIDI source. Configure score's audio output.
2. Start playback at a low volume. Send notes on channel 1 to play Synthimi's layered, detuned saw oscillators.
3. Send drum notes on channel 10 to play Kaboom. Note 36 is included in the saved learned device tree; other drum notes depend on Kaboom's note assignments.
4. Follow the lead's two parallel audio paths: IronOxide5 and Vibrato both feed ChorusEnsemble. Adjust their processing and the chorus Dry/Wet to compare the combined sound.
5. Follow the drum path through ZLowpass2 and Compresaturator. Both this output and ChorusEnsemble go to the parent mix at `audio:/out/main`.

Synthimi, Kaboom and Airwindows must be available in the build. No samples or external plug-in files are referenced. If the selected MIDI backend cannot see your device, choose a suitable API in Settings before selecting the input again. For note-on messages with zero velocity used as note-off, configure the MIDI device's corresponding option.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

