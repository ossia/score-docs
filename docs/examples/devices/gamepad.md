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

This example demonstrates how to use a gamepad to control sounds and processes in ossia score.

## Overview

Gamepads provide an accessible and expressive control interface with buttons and analog sticks. Here, the buttons play drum sounds while the sticks transform them with bitcrushing and delay. Discrete gestures and continuous movement become two complementary ways to perform the same instrument.

## Prepare the controller and samples

1. Open the ZIP directly in score. It includes `Data/Fairlight_CMI-iix_fullKit/drumkit.xml` and the associated samples.
2. Connect a gamepad. If `Gamepad` is disconnected in the Device explorer, right-click it and select the controller or choose Reconnect. Check that `/button/a`, `/button/b` and the stick axes change before starting playback.
3. Configure audio output and begin at a low level. This graph uses Deuterium, Faust and Airwindows as well as built-in audio utilities.

## Play the patch

Press A and B during playback to play two sounds from the Fairlight drum kit. Try alternating the buttons to make a rhythm, then hold the rhythm while changing the effects.

Move the left stick horizontally to change Bitcrush's Rate and vertically to change Crush. Compare a clean-sounding hit with a heavily reduced, rougher texture.

The right stick changes delay time and feedback. Try short repeats, then a longer echo that continues between button presses. Keep feedback and listening level low when exploring the extremes.

The saved patch uses standardized gamepad addresses; button labels on the physical controller may differ. It contains no rumble output mapping.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Joystick device]] - Gamepad and joystick device configuration
- [[MIDI utilities]] - Converting triggers to MIDI notes
- [[Working with devices]] - General device setup guide
