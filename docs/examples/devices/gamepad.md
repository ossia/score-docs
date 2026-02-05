---
layout: default

title: Gamepad control
description: "An example showing how to use a gamepad controller for triggering and controlling processes"

parent: Device Examples
grand_parent: Examples

permalink: /examples/devices/gamepad.html
---

# Gamepad Control

This example demonstrates how to use a gamepad (Xbox controller, PlayStation controller, etc.) to control sounds and processes in ossia score.

## Overview

Gamepads provide an accessible and expressive control interface with buttons, triggers, and analog sticks. This example shows how to map gamepad inputs to musical triggers and parameters.

## Setting up a gamepad

To use this example:

1. Connect your gamepad
2. Open the device explorer and add the Gamepad device. It should appear automatically in the Device Explorer's Gamepad list.
3. Gamepad addresses use a standardized naming scheme: you can drag and drop any address from it to a port in the timeline.

## Supported controllers

ossia score supports most standard gamepad controllers, wired and Bluetooth, including:
- Xbox Series X/S controllers
- Xbox One controllers
- PlayStation DualShock/DualSense
- Generic USB/Bluetooth gamepads

It is also possible to control rumble.

## Try it

Connect a gamepad and open this example. Press buttons A and B to trigger drum sounds!

[Download this example]({{ site.scores }}/examples/devices/gamepad.score)

## Learn more

- [[Joystick device]] - Gamepad and joystick device configuration
- [[MIDI utilities]] - Converting triggers to MIDI notes
- [[Working with devices]] - General device setup guide
