---
layout: default

title: Gamepad control
description: "An example showing how to use a gamepad controller for triggering and controlling processes"

parent: Device Examples
grand_parent: Examples

permalink: /examples/devices/gamepad.html
score: /examples/devices/gamepad.zip
---

# Gamepad Control

![Gamepad Control Example]({{ site.img }}/examples/devices/gamepad.png "Gamepad controller setup in ossia score")

The gamepad's A and B buttons become MIDI notes, while its two sticks control a sampled drum sound's effects.

## Prepare the controller and samples

1. Open the ZIP directly in score. It includes `Data/Fairlight_CMI-iix_fullKit/drumkit.xml` and the associated samples.
2. Connect a gamepad. If `Gamepad` is disconnected in the Device explorer, right-click it and select the controller or choose Reconnect. Check that `/button/a`, `/button/b` and the stick axes change before starting playback.
3. Configure audio output and begin at a low level. This graph uses Deuterium, Faust and Airwindows as well as built-in audio utilities.

## Play the patch

Press A and B during playback. Two `Bool to pulse` JavaScript processes pass button-press values to Pulse to Midi, set to notes 36 and 38. Both feed Deuterium's Fairlight kit. MIDI to array and Value display show the A branch's MIDI messages.

Move the left stick: `Gamepad:/stick/left/x` controls Bitcrush's Rate, and `/stick/left/y` controls Crush. The sampler's audio passes through Bitcrush, then splits between the Compressor and Airwindows YLowpass → Faust smoothDelay → Compressor.

The right stick controls delay time and feedback through `/stick/right/x` and `/stick/right/y`. Keep feedback and listening level low when exploring the extremes. Compressor feeds the parent mix at `audio:/out/main`.

The saved patch uses standardized gamepad addresses; button labels on the physical controller may differ. It contains no rumble output mapping.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Joystick device]] - Gamepad and joystick device configuration
- [[MIDI utilities]] - Converting triggers to MIDI notes
- [[Working with devices]] - General device setup guide
