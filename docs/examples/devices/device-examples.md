---
layout: default

title: Device Examples
description: "Choose how to perform a score: play notes, shape visuals with gestures, send network controls, or connect a service to timeline cues."

parent: Examples
has_children: true

permalink: /examples/devices
---

# Device Examples

A controller does more than supply numbers: it determines what a performer can do deliberately, continuously or at a particular moment. Start with the kind of relationship you want between an action and its result.

## Play and shape sound

- [Gamepad control]({{ site.baseurl }}/examples/devices/gamepad.html) pairs button-triggered drums with stick-controlled degradation and echoes. Start here for a compact instrument with both discrete and continuous gestures.
- [MIDI notes, controls and timeline triggers]({{ site.baseurl }}/examples/devices/midi.html) moves beyond playing notes: use a keyboard to start, stop and choose sections of a scenario.
- [Playing synths on channels 1 and 10]({{ site.baseurl }}/examples/devices/midi-to-synths.html) separates lead and drums so one MIDI source can address two instruments.
- [MIDI synth and drum effects patch]({{ site.baseurl }}/examples/devices/synths.html) explores contrasting treatments of those instruments, with a different saved drum sound.
- [Soundfonts, drum kits and a single-file sampler]({{ site.baseurl }}/examples/devices/samplers.html) compares playing an instrument live with sequencing and layering recorded sounds.

## Perform visuals

- [MIDI controls for a shader]({{ site.baseurl }}/examples/devices/midi-mapping.html) turns wheels and notes into changes of scale, rotation and shape.
- [Sensors2OSC phone control]({{ site.baseurl }}/examples/devices/sensors2osc.html) uses phone rotation and touch to move a cube and distort its image.
- [OSC values controlling a native 3D scene]({{ site.baseurl }}/examples/devices/osc.html) offers the same kind of interaction for any sender that can produce the required OSC messages.

## Connect a service to a cue

- [HTTP chat API and rendered text]({{ site.baseurl }}/examples/devices/http-llm.html) turns a server's response into animated text, separating the conversation from its presentation.
- [Slack messages through Companion]({{ site.baseurl }}/examples/devices/slack.html) sends notifications at manual cues or when a monitored condition becomes true.

The [Devices reference]({{ site.baseurl }}/devices.html) lists setup guides for network control, MIDI, hardware and video I/O. Check each example's device selection, port settings and required files before playback; saved hardware selections are not portable between computers.

The reference includes more protocols than these downloadable examples cover. Check [Supported protocols and formats]({{ site.baseurl }}/reference/protocols-and-formats.html) for build, platform and external-library requirements.
