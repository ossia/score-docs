---
layout: default
title: MIDI Controller device
description: "Named MIDI device maps, raw channels and Mackie Control surfaces"
parent: Devices
grand_parent: Reference
permalink: /devices/midi-controller-device.html
---

# MIDI Controller device

**MIDI Controller** has two modes: a description-driven interface for controllers/instruments, and a **Mackie Control surface** interface for controlling score itself. These are modes of the same registered protocol, not separate processes.

The device-map workflow requires MIDI support in the build and the hardware's MIDI ports. Install the **MIDI device maps** package through the Package Manager for the library of named hardware descriptions; generic raw-channel entries do not require a hardware description.

## Controller or instrument (device map)

1. Choose **Add device → MIDI Controller** in the [Device explorer]({{ site.baseurl }}/panels/explorer.html).
2. Set **Controller** to **Controller or instrument (device map)**.
3. Select **MIDI input** for receiving hardware controls and **MIDI output** for sending to the hardware. Either can be **(none)** for a one-way setup.
4. Use **Search an instrument...** to find the manufacturer, model and configuration. Read the description's requirements, including any preset or mode that must be selected on the hardware.
5. Use **Add device** in the selected-devices list and set its **Channel** (1–16). Several devices may share one MIDI port, each assigned a distinct channel; repeated models can be added on different channels.
6. Review **Preview**, the projected address tree, and the **Own level** checkbox. A single device can place its controls directly under the score device root; several devices should each have a level to keep their controls separate.

The selected channel supplies the default for controls whose description does not specify a channel. It does not rewrite an explicitly channel-specific hardware description or change the instrument's own channel setting. Match the physical device configuration yourself.

## Named controls and values

A description supplies control names, grouping, ranges and MIDI messages. For example, an instrument with an own level can expose:

```text
Rig:/Instrument/Group/Control
Rig:/Instrument/Group/Control/choice
```

Actual names depend on the installed description and are visible in Preview. Mapped controls carry integer values in the range supplied by the map. Where a map names individual values, an additional string **`choice`** child offers those labels while the numeric parent remains usable. Note-name metadata is deliberately not expanded into one control node per named pitch.

The map format covers CC, 14-bit CC, NRPN, RPN, notes, pitch bend, channel/polyphonic aftertouch and program changes. The map's direction and the ports you opened jointly determine whether a control can receive, send or do both. Relative encoders maintain an accumulated value; an initial displayed value is not proof that score has read the hardware's current position.

This is a MIDI description, not an automatic device-discovery or universal editor protocol. Choosing a map does not automatically put hardware in the required preset or implement arbitrary SysEx editing. A missing description package can leave the affected mapped device unavailable when reopening a project.

## Raw channels alongside descriptions

For hardware without a suitable map, add **MIDI channel** or **MIDI channel, every note and control** to the selected-devices list. These expose message semantics rather than manufacturer-specific names:

| Address on channel 1 | Value |
|---|---|
| `Rig:/1/on` | `[note, velocity]`, both 0–127. |
| `Rig:/1/off` | `[note, release velocity]`, both 0–127. |
| `Rig:/1/control` | `[controller number, value]`, both 0–127. |
| `Rig:/1/program` | Program number, 0–127. |
| `Rig:/1/pitchbend` | 0–16383, centered on 8192. |

The expanded variant also provides addresses such as `Rig:/1/on/60` (velocity), `Rig:/1/control/7` (controller value) and `Rig:/1/program/3` (pulse). The device-map levels also support MIDI process-port routing on their associated channels; named value controls do not replace every raw MIDI message the hardware can send.

Use separate [MIDI Input]({{ site.baseurl }}/devices/midiin-device.html) and [MIDI Output]({{ site.baseurl }}/devices/midiout-device.html) devices when you want those raw-port workflows without the controller-description picker.

## Mackie Control surface

Set **Controller** to **Mackie Control surface**, put the hardware in its compatible MCU mode, and select **both MIDI input and MIDI output**. This mode uses score's remote-control interface rather than creating the description-driven address tree above. An empty parameter tree in this mode is therefore not evidence of a failed device map.

Supported interactions include transport play/stop/record, navigation, and groups of knobs, faders and buttons mapped by score's remote-control implementation. Control names and values can be sent back to the surface. Not every button or vendor extension is implemented: for example, the current MCU command handler does not implement rewind/forward. Hardware-specific compatibility still needs checking.

See [Remote Control]({{ site.baseurl }}/in-depth/remote.html) for controlling score, or [Mapper device]({{ site.baseurl }}/devices/mapper-device.html) for transforming values from described hardware.
