---
layout: default

title: Joystick device
description: "Game controller and joystick support"

parent: Devices  
grand_parent: Reference

permalink: /devices/joystick-device.html
---
# Joystick device

![Joystick device]({{ site.img }}/reference/devices/joystick.png "Joystick device")

Connect game controllers and joysticks to *score* for tactile, real-time control of your projects. Perfect for performance situations where you need immediate, physical control over multiple parameters.

The Joystick device uses SDL2 to provide standardized support for PlayStation, Xbox, Nintendo Switch controllers, arcade sticks, flight simulation controls, and more.

## Setting up a joystick device

1. **Connect your controller** via USB, Bluetooth, or wireless dongle
2. **Add device** in the [[Device explorer]] and choose "Joystick"
3. **Select your controller** from the detected devices list
4. **Name your device** (e.g., "Performance Controller")

*score* automatically detects most gaming controllers and maps them to standard button and axis layouts.

## Available controls

### Standard gamepad layout

**Buttons**: A, B, X, Y, shoulder buttons (L1/R1), triggers (L2/R2), D-pad directions, Start, Select  
**Analog sticks**: Left and right sticks with X/Y axes plus clickable buttons  
**Triggers**: Pressure-sensitive L2/R2 triggers (0-1 range)  
**Special buttons**: Home/PS/Xbox button, Share/Capture buttons (controller dependent)

### Advanced features

**Dead zone compensation**: Built-in dead zone handling for precise control  
**Multiple controllers**: Connect several controllers simultaneously for complex setups  
**Hot-plugging**: Controllers can be connected/disconnected while *score* is running  
**Rumble/Haptics**: Force feedback support (where available)

## Creative applications

**Live performance control**: Map analog sticks to spatial audio parameters, use triggers for real-time effects intensity, assign buttons to scene changes or cue triggering.

**Expressive synthesis**: Use pressure-sensitive triggers and analog sticks for continuous controller data that feels natural and musical.

**Interactive installations**: Provide intuitive control interfaces for gallery visitors or participants - everyone knows how to use a game controller.

**Parameter automation**: Record controller movements to create complex automation curves that capture human gesture and timing.

**Multi-user control**: Use multiple controllers for collaborative performance or installation control.

## Integration with score processes

**[[Mapping Tool]]**: Shape controller response curves - make triggers feel more musical or create custom dead zones for analog sticks.

**[[DBAP]]/[[GBAP]]**: Map analog sticks directly to spatial audio positioning for real-time sound movement.

**[[Audio Effects]]**: Control effect parameters with analog precision - use triggers for gradual filter sweeps or reverb sends.

**[[Video]] processing**: Control visual parameters, color adjustments, or video playback speed with smooth analog control.

## Technical considerations

Controllers use the HID (Human Interface Device) standard over USB or Bluetooth. SDL2 maintains a database of controller mappings, so most popular controllers work immediately without configuration.

**Latency**: USB controllers typically have 1-8ms latency, Bluetooth adds 10-20ms. For critical timing applications, use wired connections.

**Battery management**: Wireless controllers may enter sleep mode - plan for this in long performances.

**Platform differences**: Controller support varies by operating system - test your specific setup before important performances.

## Troubleshooting

**Controller not detected**: Check that drivers are installed and the controller works in other applications. Try reconnecting or using a different USB port.

**Mapping issues**: Some controllers may need custom mapping if they're not in SDL2's database. Check SDL2 documentation for mapping strings.

**Drift problems**: Clean analog sticks if experiencing drift, or use [[Mapping Tool]] with deadzone settings to compensate.

Works perfectly with [[MIDI]] devices for hybrid control setups, or combine with [[OSC]] for network-based controller sharing between multiple *score* instances.

## Related devices

Combine with [[MIDI]] controllers for comprehensive control surfaces, use with [[OSC]] devices for network control, or integrate with sensor-based devices like [[Wiimote]] for motion control.