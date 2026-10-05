---
layout: default

title: Device Examples
description: "Examples demonstrating device integration in ossia score"

parent: Examples
has_children: true

permalink: /examples/devices
---

# Device Examples

These examples demonstrate how to connect and use various input/output devices in ossia score.

## Controller and network examples

- [Gamepad control]({{ site.baseurl }}/examples/devices/gamepad.html): convert buttons to drum notes and sticks to effect controls.
- [MIDI notes, controls and timeline triggers]({{ site.baseurl }}/examples/devices/midi.html): play a synth and choose sample branches.
- [MIDI controls for a shader]({{ site.baseurl }}/examples/devices/midi-mapping.html): map wheels and notes to a visual generator.
- [Playing synths on channels 1 and 10]({{ site.baseurl }}/examples/devices/midi-to-synths.html): split lead and drum input.
- [MIDI synth and drum effects patch]({{ site.baseurl }}/examples/devices/synths.html): a related patch with a different drum preset.
- [Soundfonts, drum kits and a single-file sampler]({{ site.baseurl }}/examples/devices/samplers.html): combine external and sequenced MIDI sources.
- [OSC values controlling a native 3D scene]({{ site.baseurl }}/examples/devices/osc.html): map rotation and indexed touch messages.
- [Sensors2OSC phone control]({{ site.baseurl }}/examples/devices/sensors2osc.html): connect Android sensors and inspect the mapped touch values.
- [HTTP chat API and rendered text]({{ site.baseurl }}/examples/devices/http-llm.html): display a response from a compatible language-model server.
- [Slack messages through Companion]({{ site.baseurl }}/examples/devices/slack.html): send webhook notifications from states.

The [Devices reference]({{ site.baseurl }}/devices.html) lists setup guides for network control, MIDI, hardware and video I/O. Check each example's device selection, port settings and required files before playback; saved hardware selections are not portable between computers.

The reference includes more protocols than these downloadable examples cover. Check [Supported protocols and formats]({{ site.baseurl }}/reference/protocols-and-formats.html) for build, platform and external-library requirements.
