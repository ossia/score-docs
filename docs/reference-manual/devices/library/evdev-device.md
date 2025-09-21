---
layout: default

title: Evdev device
description: "Linux input device access"

parent: Devices
grand_parent: Reference

permalink: /devices/evdev-device.html
---
# Evdev device

![Evdev device]({{ site.img }}/reference/devices/evdev.png "Evdev device")

Access any Linux input device directly through the kernel's evdev interface. This gives you raw access to keyboards, mice, touchpads, graphics tablets, custom hardware, and any other input device recognized by Linux.

Perfect for custom hardware integration, low-latency input processing, or accessing specialized input devices that don't have dedicated *score* support.

## Setting up an evdev device

1. **Identify your device** - Check `/dev/input/event*` or use `evtest` to find your device
2. **Add device** in the [[Device explorer]] and choose "Evdev"  
3. **Select device file** - Choose the appropriate `/dev/input/eventX` file
4. **Set permissions** - Ensure *score* has read access to the device file
5. **Test input** - Interact with your device to see parameter updates

You may need to adjust permissions or run *score* with appropriate privileges to access input devices.

## Device capabilities

### Universal input support
**Any recognized device**: If Linux can see it as an input device, evdev can access it.

**Raw event access**: Get unprocessed input data directly from the kernel for minimal latency.

**Multiple devices**: Access several input devices simultaneously for complex control setups.

**Hot-plug support**: Automatically handle device connection and disconnection.

### Event types
**Key events**: Keyboard keys, mouse buttons, custom button inputs with press/release states.

**Relative motion**: Mouse movement, trackball input, scroll wheel data.

**Absolute positioning**: Graphics tablets, touchscreens, joystick axis positions.

**Touch events**: Multi-touch data from touchscreens and trackpads.

**Custom events**: Specialized input from custom hardware or unusual devices.

## Creative applications

**Custom controllers**: Build unique input devices and access them directly without needing custom drivers.

**Graphics tablets**: Use pressure-sensitive tablets for expressive control of audio effects, synthesis parameters, or visual processing.

**Touch interfaces**: Create multi-touch installations using touchscreens or touch-sensitive surfaces.

**Accessibility devices**: Integrate specialized accessibility hardware for inclusive interactive experiences.

**Industrial sensors**: Access industrial input devices, sensors, or control interfaces that appear as Linux input devices.

## Integration advantages

**Low latency**: Direct kernel access provides minimal input delay for time-critical applications.

**Full device access**: Get all the data your device provides, not just what higher-level drivers expose.

**Custom hardware**: Perfect for prototype devices, Arduino-based controllers, or custom-built interfaces.

**System integration**: Access the same devices that other Linux applications use without conflicts.

## Advanced features

**Event filtering**: Choose which types of events to monitor for efficient processing.

**Exclusive access**: Optionally grab devices exclusively to prevent other applications from receiving their input.

**Value scaling**: Automatic scaling of device-specific ranges to standard 0-1 ranges for *score*.

**State tracking**: Maintain state for buttons, keys, and other stateful inputs.

## Integration with score

Evdev works perfectly with [[Mapping Tool]] to shape raw input data into useful parameter ranges. The low-latency access makes it ideal for controlling [[Audio Effects]] that need precise timing, or [[DBAP]]/[[GBAP]] for spatial audio control.

**Real-time control**: Direct kernel access provides the low latency needed for musical performance and real-time interaction.

**Custom mappings**: Use [[Mapping Tool]] to create custom response curves for unusual input devices.

**Multi-device coordination**: Combine multiple evdev devices for complex, multi-dimensional control interfaces.

## Technical considerations

**Permissions**: Linux restricts access to input devices - you may need to add your user to the `input` group or set up appropriate udev rules.

**Device identification**: Input device numbers can change between reboots - use stable identifiers or udev rules for production installations.

**Event formats**: Different devices provide data in different formats - understanding Linux input event structures helps with complex devices.

**Performance**: Direct kernel access is efficient, but processing many high-frequency input devices can impact performance.

## Setup and permissions

**User permissions**: Add your user to the input group: `sudo usermod -a -G input $USER`

**Udev rules**: Create rules for consistent device naming and permissions in `/etc/udev/rules.d/`

**Testing**: Use `evtest` command-line tool to verify device access and understand event formats.

**Security**: Be aware that evdev access can potentially intercept sensitive input like passwords.

## Troubleshooting

**Permission denied**: Check that your user has access to `/dev/input/event*` files - usually requires being in the input group.

**Device not found**: Verify the device is recognized by Linux with `ls /dev/input/` or `cat /proc/bus/input/devices`.

**Wrong device**: Use `evtest` to identify which `/dev/input/eventX` corresponds to your specific device.

**Events not appearing**: Some devices may need to be configured or activated before they generate events.

## Related devices

Evdev provides low-level access that complements higher-level device protocols. Use alongside [[MIDI]] for musical devices, [[OSC]] for network communication, or [[Joystick]] device for standardized game controller access.