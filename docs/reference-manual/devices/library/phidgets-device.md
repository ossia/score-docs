---
layout: default

title: Phidgets device
description: "Optional Phidget22 hardware discovery, channel controls and integration limits"
parent: Devices
grand_parent: Reference
permalink: /devices/phidgets-device.html
---

# Phidgets device

[Phidgets](https://www.phidgets.com/) are hardware interfaces for sensors and physical outputs. score's optional **Phidget** protocol discovers hardware through the Phidget22 library and exposes its channels in the Device explorer.

## Availability and prerequisites

This is a source-based integration reference, not a guarantee that the protocol is present in every installer. Compilation and registration require `OSSIA_PROTOCOL_PHIDGETS`; libossia defaults this option to off and disables it when the Phidgets dependency is missing. The dependency lookup targets Phidget22 headers and libraries, with platform-specific lookup for macOS, Unix and Windows. On non-Apple Unix, libusb is also required. These build paths are not a tested-platform support matrix.

The audited development snapshot has an additional integration limitation: score's device implementation includes `ossia/network/phidgets/phidgets_protocol.hpp`, while its bundled libossia provides that header under `ossia/protocols/phidgets/`. A compatible enabled build must therefore be established before relying on this integration; conditional registration alone does not prove that it builds. No Phidgets hardware or enabled runtime session was exercised for this page.

For an enabled, compatible build, provide the Phidget22 runtime and any driver or device-access permissions required by your operating system, as well as the appropriate hardware, hub, cabling and power. Check the hardware with the manufacturer's tools before diagnosing score. Network-attached hardware additionally needs a reachable Phidgets server and working discovery; score does not provide a server configuration panel here.

## Adding and opening channels

1. Connect the hardware, then add a device in the [[Device explorer]] and choose **Phidget**, if that protocol is available in your build.
2. Set **Name**, the only connection setting. It names score's device root; it is not a hardware serial number or network hostname. The widget initializes it to `Phidgets`, while the factory's default device settings use `Phidget`, so use the name actually shown in your dialog.
3. Confirm the dialog and allow the discovered tree to populate. The backend opens a Phidget manager, handles attach/detach events and enables Phidgets network-server discovery. There is no manual host, port, password, serial-number filter or channel selector in this settings widget.
4. Expand the required channel and send `true` to its **`open`** child before using it. Channels begin closed. Opening waits up to one second for attachment; failure leaves `open` false and logs a Phidget open error. Send `false` to close the channel.
5. Use the channel's own value as a sensor source or, for a digital output, as a writable destination. Configure any exposed channel controls after opening it.

Opening the manager and discovering a channel are not the same as opening that channel. If names appear but values do not update, check `open`, hardware access and the channel's actual capabilities first.

## Device tree and addresses

The tree follows the hardware's parent hierarchy. Device labels or names become nodes; hubs have children such as `Port.0`, and channel names may receive a numeric suffix. Names are sanitized and made unique. Use the addresses discovered on your hardware rather than copying another installation's path.

For example, under a root you named `Phidgets`, a channel address has the form `Phidgets:/<discovered hardware path>/<channel>`. The angle-bracket portions here describe the hierarchy, not literal node names. Its activation control is the same address with `/open` appended.

Common channel children are:

| Child | Meaning |
|---|---|
| `open` | Boolean channel activation control and open state. |
| `channel` | Read-only hardware channel number. |
| `rate` | Where exposed, the Phidget data-interval control, not a score-wide polling frequency. Its limits depend on the channel. |
| `trigger` | Where exposed, the sensor's change-trigger threshold. |

Attachment creates nodes and detachment removes them, including empty parents. score advertises tree refresh but does not allow manually adding, removing or renaming these hardware nodes or editing their properties. The live namespace is not serialized as an editable device tree. Reconnect rebuilds the backend and its discovered namespace; plan to reopen channels as needed.

Discovery changes are processed from a queue, one command per 200 ms timer tick in the score wrapper. A larger tree can therefore appear progressively. This timer is not a promised sensor sampling rate.

## Input and output direction

Direction depends on the channel, not merely on the protocol:

- **Sensor and digital-input values flow from hardware into score.** The backend installs hardware change callbacks. Sending a value to a sensor does not turn it into a physical output, even though the generic parameter metadata may advertise bidirectional access.
- **Digital-output values flow from score to hardware.** The implemented output channel takes a Boolean value and calls the Phidget digital-output state setter. Open the channel before sending values, and verify the physical result safely.
- **Channel controls flow from score to the library.** `open`, and where present `rate` and `trigger`, configure the channel. `channel` is read-only metadata.

The channel dispatcher implements selected sensor families, including voltage and voltage-ratio inputs, digital input/output, motion sensors and several environmental sensors. It does not instantiate every channel class in the Phidget22 SDK. A device name or hardware identifier appearing in the SDK is not evidence that all of its functions are exposed in score. In particular, do not infer general motor, servo or analog-output control from the existence of this protocol.

## Troubleshooting and limits

- **No Phidget entry:** check the enabled build and dependencies; changing the device name cannot enable a missing protocol.
- **Empty or incomplete tree:** verify hardware discovery outside score, allow queued attachments to populate, and check whether the channel class has an implementation. Refresh cannot create an unsupported channel.
- **Channel cannot open:** inspect the logged Phidget error and check attachment, permissions and whether another application is holding the channel.
- **A value can be edited but the hardware does not change:** distinguish a real digital output or control from an input measurement. UI access metadata alone is insufficient.
- **Network hardware is absent:** the backend enables automatic server discovery, but this dialog cannot manually configure or authenticate a remote server. Do not assume that every Phidgets network deployment is usable through this integration.

## Source references

The score wrapper, settings and factory are in `src/plugins/score-plugin-protocols/Protocols/Phidgets/`; its build guard and registration are in that plugin's `CMakeLists.txt` and `score_plugin_protocols.cpp`. Discovery, tree construction, activation and channel behavior are defined in bundled libossia's `src/ossia/protocols/phidgets/phidgets_protocol.cpp`, `phidgets_node.cpp` and `phidgets_parameter.hpp`. Dependency detection is in libossia's `cmake/FindPhidgets.cmake` and `cmake/deps/phidgets.cmake`.
