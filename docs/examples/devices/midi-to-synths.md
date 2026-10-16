---
layout: default
title: Playing synths on MIDI channels 1 and 10
description: "Play lead and drums through one MIDI connection, using separate channels and effects to give each instrument its own role."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/midi-to-synths.html
score: /examples/devices/midi-to-synths.score
---

# Playing synths on MIDI channels 1 and 10

![Synthimi feeding parallel IronOxide5 and Vibrato effects above a separate Kaboom drum chain]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-midi-to-synths.png)

One MIDI connection carries two independent parts: channel 1 plays a layered synth lead, while channel 10 plays drums. Keeping the channels separate lets you address either instrument without making every note trigger both, and gives each part its own treatment in the mix.

Choose the channel on your keyboard or software MIDI source. Starting score's transport does not generate notes: this patch is an instrument for incoming performances, not a sequenced piece.

## Setup and sound

1. Stop playback, edit `MIDI In` in the Device explorer and select a connected keyboard or MIDI source. Configure score's audio output.
2. Start playback at a low volume. Send notes on channel 1 to play Synthimi's layered, detuned saw oscillators.
3. Send drum notes on channel 10 to play Kaboom. Begin with note 36; other notes follow Kaboom's drum assignments. Alternate between channels to confirm which instrument receives each gesture.
4. Hold a lead note and compare IronOxide5's coloration with Vibrato's pitch movement. These are parallel treatments of the original synth, combined before a shared chorus, not two effects applied one after another.
5. Keep a drum pattern steady and lower ZLowpass2's cutoff, then change Compresaturator's Drive. Listen for the difference between removing brightness and adding saturation; both can change the drums' apparent weight without changing the rhythm.

Try a sustained channel-1 phrase against short channel-10 attacks. Adjust the drum filtering while keeping the lead unchanged to explore how separate routing gives each performer gesture a distinct place in the arrangement.

The build needs Synthimi, Kaboom and Airwindows; no sample files or external plug-ins are required. If your MIDI device is not listed, select a suitable API in Settings and choose the input again. Enable the MIDI device's velocity-zero-as-note-off option if your controller uses that convention.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

