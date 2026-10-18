---
layout: default
title: Tracking protocols
description: "Receive tracking data from TUIO, PosiStageNet, RTTrP, OpenTrackIO and OpenXR sources"
parent: Devices
grand_parent: Reference
permalink: /devices/tracking-device.html
---

# Tracking protocols

Tracking data describes moving objects, performers, touch contacts or cameras. With the tracking devices, positions, orientations and
other tracking data become parameters of the device explorer: they can drive automations, mappings, shaders, 3D scenes or spatialization like any other address.

## Availability

The tracking protocols are included in the desktop builds of ossia score since **3.9.0** (Windows, macOS and Linux). They are not available in the
WebAssembly (browser) build.

Add them from **Add device**, in the **Tracking** category: **TUIO**, **PSN**, **RTTrP**, **OpenTrackIO** and **OpenXR**.

## Protocols

| Protocol | Data and connection | Settings |
|---|---|---|
| **TUIO** | Touch cursors, tangible objects and blobs over UDP, as sent by multitouch tables, reacTIVision and many computer vision tools. TUIO 1.1 and 2.0 are supported. | UDP port (3333 by default); number of object, cursor and blob slots; protocol version. |
| **PSN (PosiStageNet)** | Tracker positions, and optionally speed, acceleration, orientation and target positions, over UDP multicast, as sent by stage tracking systems and media servers. | Multicast address (`236.10.10.10`), port (56565), number of trackers, and switches for velocity, acceleration, orientation and target position. |
| **RTTrP** | Trackable poses, LED markers and zone information over UDP, as sent by BlackTrax and compatible systems. | Port (24002), number of trackables, maximum LEDs and zones, quaternion or Euler orientation, velocity, acceleration and zones. |
| **OpenTrackIO** | Camera, lens and timing metadata from virtual production and on-set tracking systems, over UDP multicast, with JSON or CBOR payloads. | Multicast base (`239.135.1`), port (55555), minimum and maximum source numbers (one multicast group per source), and the camera, lens, timing and global stage fields to receive. |
| **OpenXR** | Head and controller tracking from an OpenXR runtime, rather than from a network stream. | Requires an OpenXR runtime (for instance SteamVR or Monado) and compatible hardware. |

## Slots and identities

TUIO, PSN and RTTrP devices expose a fixed number of **slots** in the device tree. A slot is not necessarily a permanent identity for a performer or an object:
check how the sender assigns its IDs before binding critical cues to a given slot, and size the number of slots for the maximum number of simultaneous objects.

Network port numbers alone do not make these protocols interchangeable with generic OSC. If a tracking system can publish OSC directly,
the [OSC device]({{ site.baseurl }}/devices/osc-device.html) is an alternative.

## See also

- [Depth cameras]({{ site.baseurl }}/devices/depth-camera-device.html), for skeleton-free point clouds and depth images from Orbbec, Kinect, RealSense and OAK cameras.
- [Leap Motion]({{ site.baseurl }}/devices/leapmotion-device.html) for hand tracking.
- [Spatialization]({{ site.baseurl }}/common-practices/14-spatial-audio.html), which tracked positions often drive.
