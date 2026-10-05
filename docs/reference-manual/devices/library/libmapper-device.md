---
layout: default

title: Libmapper client
description: "Availability and scope of the optional Libmapper client integration"
parent: Devices
grand_parent: Reference
permalink: /devices/libmapper-device.html
---

# Libmapper client

[libmapper](https://libmapper.github.io/) connects named signals between applications and devices. score's source contains an optional **LibmapperClient** protocol, distinct from the [[Mapper device]], which builds a device tree using QML.

## Availability

Compilation and registration require `OSSIA_PROTOCOL_LIBMAPPER` and the linked `mapper` dependency.

The integration has an interface mismatch: its factory header declares `getEnumerators`, while the implementation defines `getEnumerator`. This mismatch must be resolved for a libmapper-enabled build to work; enabling the build option alone is insufficient.

## Intended device model

The source describes a client for a discovered libmapper device:

- The enumerator observes libmapper devices joining or leaving the graph.
- Selecting a discovered device supplies its identifier; the client uses that identifier to obtain its signal tree.
- The settings widget exposes a local **Name**, not a manually editable remote identifier or host/port pair. Merely typing a name into an empty configuration does not provide the required discovery identifier.
- The device advertises tree refresh, but not adding, removing or renaming remote nodes or editing their properties from score.

The underlying client builds parameters for remote input signals, intended for sending values from score. Its `observe` operation returns false; do not infer support for subscribing to remote output signals or bidirectional device synchronization.

This does not make the QML Mapper device a libmapper client. For a script-defined namespace and mappings inside score, use [[Mapper device]] instead.

## Source references

The build guard and registration are in `score-plugin-protocols/CMakeLists.txt` and `score_plugin_protocols.cpp`. The factory, discovery and client behavior are in `Protocols/Libmapper/LibmapperClientDevice.hpp` and `.cpp`.
