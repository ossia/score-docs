---
layout: default
title: CAN device
description: "Receive CAN signals through a DBC database and Linux SocketCAN"
parent: Devices
grand_parent: Reference
permalink: /devices/can-device.html
---

# CAN device

The **CAN** device receives CAN bus frames and decodes their signals using a `.dbc` database. It is useful for bringing sensor or machine telemetry into a score without writing a packet decoder.

This describes the current development implementation. It requires a build with CAN support and a **Linux SocketCAN** interface. It is **receive-only**: writing an address does not transmit a CAN frame, configure a sensor, or implement CANopen control services.

## Set up the bus

1. Connect a supported CAN adapter and configure its SocketCAN interface outside score, including the bitrate appropriate to your hardware. The device dialog does not configure the bus bitrate.
2. Choose **Add device → CAN** in the [Device explorer]({{ site.baseurl }}/panels/explorer.html).
3. Select the **Interface** and a **DBC file** describing the incoming messages. The interface list contains the interfaces present on this machine; you can also type a name when preparing a document before connecting its adapter.
4. Check the database summary: it reports message and signal counts, the effective hexadecimal message identifiers, and parser warnings.
5. Expand the device and use its signal addresses as inputs to your score.

DBC files in the library can also appear in the CAN device picker. Selecting a database does not create or bring up a CAN interface. A virtual SocketCAN interface such as `vcan0` can be used instead of physical hardware for development.

## Settings

| Setting | Meaning |
|---|---|
| **Name** | Device name used in score addresses. |
| **Interface** | SocketCAN interface, for example `can0` or `vcan0`. There is no assumed `can0` when none is detected. |
| **DBC file** | Database used to construct the signal tree and decode frames. Keep this file available when moving the project. |
| **Node id offset** | Added to each database message identifier. For a database describing CANopen node 1 with identifiers `0x181`, `0x281`, an offset of `1` targets `0x182`, `0x282`. This changes frame matching, not the hardware's node ID. |
| **32-bit ints are floats** | Workaround for vendor databases that describe IEEE 754 float payloads as 32-bit integers. Leave disabled unless the database is known to require it; explicit float/double declarations are unaffected. |
| **CAN FD** | Allows payloads larger than eight bytes; classic frames remain supported. The interface and bus must also support the traffic being received. |
| **Filter to database** | Enabled by default. Requests per-socket kernel filtering to the database's message identifiers. |

Several score devices can share an interface with different databases or node-ID offsets. This is useful for several identical sensors on one bus.

## Address mapping

A DBC message becomes a container; each signal becomes a parameter beneath it:

```text
CAN:/MessageName/SignalName
```

The decoder uses the database's byte order, signedness, scaling, offsets and multiplexing information. Scaled and floating-point signals become float parameters; suitable unscaled integers remain integers, and a single unscaled bit becomes a boolean. Descriptions and domains come from the database where available. Only unambiguous supported DBC unit strings receive score units; an arbitrary vendor unit is not automatically converted.

Standard and extended identifiers are distinguished even when their numeric values match. Unsupported or malformed database content is reported through warnings; the presence of a tree is not proof that every vendor-specific DBC extension was understood. If values do not change, check the interface state, actual frame IDs, node offset, frame format and database before changing signal scaling.

See also [Working with devices]({{ site.baseurl }}/quick-start/working-with-devices.html) and [Mapper device]({{ site.baseurl }}/devices/mapper-device.html) for combining decoded signals.
