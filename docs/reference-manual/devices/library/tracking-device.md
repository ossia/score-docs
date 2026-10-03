---
layout: default
title: Tracking protocols
description: "Tracking protocol source inventory and current add-on availability"
parent: Devices
grand_parent: Reference
permalink: /devices/tracking-device.html
---

# Tracking protocols

Tracking data describes moving objects, performers, touch contacts or cameras. It can drive score parameters, but the presence of a protocol implementation in the source tree does not mean it is available in an installed build.

## Current availability

**The tracking-protocols add-on is disabled in the audited development checkout.** Its `CMakeLists.txt` returns before creating the plug-in. The protocols below therefore must not be expected in **Add device** in that build, and installing unrelated tracking hardware does not enable them.

The add-on's factory list contains **TUIO**, **PSN**, **RTTrP** and **OpenTrackIO**, plus **OpenXR** behind an additional build condition. This is the source inventory, not a claim of a currently shipped or hardware-tested integration. There are no additional tracking protocols implied by this list.

## Source-defined interfaces

These settings describe the existing source implementations and help identify which integration a tracker would require in a separately enabled build.

| Protocol | Data and connection | Source-defined settings |
|---|---|---|
| **TUIO** | Touch cursors, tangible objects and blobs over UDP. The selector distinguishes TUIO 1.1 and 2.0. | UDP port (3333 by default); fixed object, cursor and blob slot counts; protocol version. |
| **PSN (PosiStageNet)** | Tracker position and optional motion/orientation data over UDP multicast. | Multicast address (`236.10.10.10`), port (56565), tracker count, velocity, acceleration, orientation and target-position switches. |
| **RTTrP** | Trackable poses, LED markers and zone information over UDP. | Port (24002), trackable count, maximum LEDs and zones, quaternion/Euler, velocity, acceleration and zone switches. |
| **OpenTrackIO** | On-set camera/lens/timing metadata over UDP multicast, with an `OTrk` header and JSON or CBOR payload. | Multicast base (`239.135.1`), port (55555), minimum/maximum source numbers, camera/lens/timing/global-stage fields and accepted payload formats. One multicast group is selected per source number. |
| **OpenXR** | Tracking through an OpenXR runtime rather than an incoming UDP tracker stream. | Additionally conditional on OpenXR being found at build time and the `SCORE_HAS_OPENXR` registration gate. A compatible runtime and hardware are separate requirements. |

In slot-based trackers, a slot is not inherently a permanent performer identity. Check the sender's IDs and the enabled implementation's slot assignment before binding critical cues. Network port numbers alone do not make these protocols interchangeable with generic OSC.

For currently available alternatives, consult the [Devices reference]({{ site.baseurl }}/devices.html) and the [OSC device]({{ site.baseurl }}/devices/osc-device.html) if the tracking software can explicitly publish OSC addresses.
