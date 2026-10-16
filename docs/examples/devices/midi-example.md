---
layout: default
title: MIDI notes, controls and timeline triggers
description: "Use a MIDI keyboard to play sound, hold a section open, and make live choices about what the timeline plays next."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/midi.html
score: /examples/devices/midi.zip
---

# MIDI notes, controls and timeline triggers

![Triggered synth interval surrounded by MIDI input and computer-keyboard setup annotations]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-midi.png)

A MIDI keyboard can be both an instrument and a set of stage cues. Here, notes play a synthesizer, trigger sections or hold them open, while the modulation wheel decides which recorded sound a sequence will play next. The useful distinction is between performing inside a section and controlling the structure around it.

Open the ZIP directly in score to keep its bundled samples available. Configure the audio output and start at a low listening level; Synthimi and Airwindows support are required.

## Select an input

With playback stopped, edit `MIDI In` and choose a connected controller or the computer-keyboard MIDI input. Use Learn to expose controls that are not already in the tree. The saved device has velocity-zero-as-note-off disabled; enable it if your controller uses note-on velocity zero instead of note-off messages.

Start playback, then use `press me to start!` to activate Synthimi and play some notes. For the computer keyboard, the middle letter row plays white keys and the row above plays black keys; the lower-row octave controls let you reach the trigger notes.

## Trigger and branch

1. Send channel 1 note 38 several times. Compare the normal trigger with the auto-retriggering version: the latter rearms, making repeated gestures useful for repeated activations.
2. Send channel 1 note 40 and hold it, then release it. The paired examples use `MIDI In:/1/on/40` to start and `/1/off/40` to stop. This gives a section the duration of a physical gesture rather than a fixed timeline length.
3. Send channel 1 note 36 to start the conditional sequence. Before it reaches the choice, move CC1 across its midpoint: values below 64 select one sample, and values of 64 or more select the other. The decision uses the wheel's position at the event, not its position when you first pressed the key.
4. Lower the volume before triggering `Harsh synth (start with volume low)`. Move CC1 and pitch bend to shape timbre and delay, then use CC2 for the delay's Dry/Wet. Here, the controllers transform an already-running sound rather than accompany a melody.

The harsh expression-based synth continues without MIDI notes once triggered. Use its explicit end trigger to stop it; releasing a key is not its stop gesture.

Repeat the conditional sequence with the same starting gesture but a different wheel movement during the wait. This is a useful way to design a performance in which the next section remains undecided until the performer commits to it.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

