---
layout: default
title: MIDI notes, controls and timeline triggers
description: "An example showing how to play sounds and trigger events with a MIDI controller"
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/midi.html
score: /examples/devices/midi.zip
---

# MIDI notes, controls and timeline triggers

![Triggered synth interval surrounded by MIDI input and computer-keyboard setup annotations]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-midi.png)

This example demonstrates using MIDI both as a musical input and as a way to control a scenario. Notes can play a synthesizer, start and stop sections, or lead to different sounds according to a controller's position.

Open the ZIP directly in score; it includes the `Audio/` samples.

## Select an input

With playback stopped, edit `MIDI In` and choose a connected controller or the computer-keyboard MIDI input. Use Learn to expose controls that are not already in the tree. The saved device has velocity-zero-as-note-off disabled; enable it if your controller uses note-on velocity zero instead of note-off messages.

Start playback, then use `press me to start!` to activate Synthimi and play some notes. For the computer keyboard, the middle letter row plays white keys and the row above plays black keys; the lower-row octave controls let you reach the trigger notes.

## Trigger and branch

1. Send channel 1 note 38. Compare its normal trigger with the auto-retriggering version; the latter rearms for repeated activation.
2. Send channel 1 note 40, then release it. The paired examples use `MIDI In:/1/on/40` to start and `/1/off/40` to stop their intervals.
3. Send channel 1 note 36 to start the conditional sequence. At the next event, CC1 below 64 selects `Audio/002_2.wav`; CC1 at least 64 selects `Audio/000_inddistb1.wav`. The wheel is sampled when the condition is reached, not when the note was first pressed.
4. At a low volume, trigger `Harsh synth (start with volume low)`. Move CC1 and pitch bend to explore continuous changes in timbre and delay, then vary CC2 to change the delay's Dry/Wet. Unlike playing a keyboard melody, this section uses controller gestures to shape an already-running sound.

The expression branch runs without MIDI notes once triggered, unlike Synthimi. Stop its interval explicitly with its end trigger. Synthimi and Airwindows support are required; the two sound-file branches also need the archive's samples.

Try moving the modulation wheel after starting the conditional sequence but before it reaches its choice. This is useful for understanding how a live decision can affect the next section of a performance.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

