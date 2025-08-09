---
layout: default

title: Wiimote device
description: "Nintendo Wii Remote motion control"

parent: Devices
grand_parent: Reference

permalink: /devices/wiimote-device.html
---
# Wiimote device

![Wiimote device]({{ site.img }}/reference/devices/wiimote.png "Wiimote device")

Turn Nintendo Wii Remotes into expressive wireless controllers for your *score* projects. Get 3D motion sensing, IR pointing, button input, and extension support through Bluetooth connectivity.

Perfect for gestural control, spatial audio manipulation, interactive installations, or any project where you want natural, wireless interaction without complex sensor setups.

## Setting up a Wiimote device

1. **Put your Wiimote in pairing mode** - Press and hold the 1 and 2 buttons simultaneously until the LEDs flash
2. **Add device** in the [[Device explorer]] and choose "Wiimote"
3. **Wait for connection** - The device will automatically discover and pair with available Wiimotes
4. **Test the connection** - Press buttons and move the remote to see parameter updates

For IR pointer functionality, set up an IR sensor bar or use candles as IR reference points.

## Available inputs

### Motion sensing
**Accelerometer** - 3-axis tilt and motion detection  
**X, Y, Z axes** - Raw acceleration values for gesture recognition  
**Tilt angles** - Processed roll and pitch for precise orientation control  
**Shake detection** - Built-in gesture recognition for sudden movements

### Button interface
**D-pad** - Four-way directional control  
**A and B buttons** - Primary action buttons  
**1 and 2 buttons** - Secondary controls  
**Plus and Minus** - Menu/settings buttons  
**Home button** - Special function button

### IR camera
**IR pointing** - 10-point infrared tracking with sensor bar  
**X/Y coordinates** - Screen-relative pointing position  
**Distance sensing** - Rough distance estimation from IR sources  
**Multi-point tracking** - Track up to 4 IR sources simultaneously

### Extension support
**Nunchuk** - Additional analog stick and motion sensing  
**Classic Controller** - Traditional gamepad layout  
**Motion Plus** - Enhanced gyroscope for precise rotation  
**Other extensions** - Guitar Hero controllers, balance boards, etc.

## Creative applications

**Gestural composition**: Map Wiimote movements to musical parameters - tilt for pitch bend, shake for rhythm triggers, pointing for spatial audio control.

**3D spatial control**: Use accelerometer data for positioning sounds in 3D space with [[DBAP]] or [[GBAP]] spatialization.

**Interactive performances**: Wireless freedom lets performers move naturally while controlling audio, video, or lighting parameters.

**Installation interaction**: Provide intuitive, game-like interfaces for gallery visitors - everyone knows how to use a Wiimote.

**Multi-user systems**: Connect multiple Wiimotes for collaborative control or performance systems.

## Integration with score processes

**[[Mapping Tool]]**: Shape accelerometer data into musical curves - add dead zones for steady holding, create response curves for natural gesture feel.

**Spatial audio**: Connect motion data directly to [[DBAP]] positioning for sound that follows your movements through 3D space.

**[[Audio Effects]]**: Map tilt and rotation to effect parameters - shake the remote to add distortion, tilt for filter sweeps.

**[[Video]] processing**: Control visual effects with gesture - point to control projection mapping, shake for visual intensity.

## Advanced techniques

**Gesture recognition**: Combine multiple axis data to recognize complex gestures - figure-8 movements, specific pointing patterns, or choreographed sequences.

**Sensor fusion**: Use accelerometer and IR data together for more robust tracking and control.

**Distance-based interaction**: Use IR distance sensing for proximity-based effects - sounds that change as you approach or move away from reference points.

**Multi-controller orchestration**: Create ensemble pieces where multiple performers with Wiimotes contribute to a unified musical or visual experience.

## Technical considerations

**Bluetooth connectivity**: Wiimotes use Bluetooth HID protocol - ensure your system supports Bluetooth connections and proper pairing.

**Battery life**: Wiimotes use AA batteries - expect 30-60 hours of use depending on rumble and speaker usage. Consider rechargeable batteries for installation use.

**IR setup**: For pointer functionality, position IR sources (sensor bar, candles, IR LEDs) appropriately for your space and interaction design.

**Range limitations**: Bluetooth range is typically 10 meters - plan your performance or installation space accordingly.

## Troubleshooting

**Connection issues**: Try re-pairing by pressing 1+2 buttons, ensure Bluetooth is enabled and working, check that the Wiimote isn't paired to another device.

**Poor motion tracking**: Check battery levels, ensure the remote isn't in a case or cover that blocks sensors, recalibrate if necessary.

**IR problems**: Ensure IR sources are visible to the Wiimote camera, check for interference from other IR sources, verify sensor bar positioning.

**Lag or dropouts**: Move closer to reduce Bluetooth distance, minimize interference from other wireless devices, check for low battery conditions.

The Wiimote device works beautifully with [[OSC]] for networking gesture data, [[MIDI]] for musical applications, or [[Joystick]] devices for hybrid control setups that combine different input methods.

## Related devices

Combine with [[Joystick]] devices for comprehensive controller setups, use [[OSC]] to network Wiimote data to other systems, or integrate with [[Kinect]] for full-body plus handheld gesture control.