---
layout: default

title: NDI devices
description: "Sending and receiving textures via NDI"

parent: Devices
grand_parent: Reference

permalink: /devices/ndi-device.html
---

# NDI

[NDI](https://ndi.video/) is a network protocol for sharing video frames across applications. 
ossia score supports both RGBA and UYVY NDI frames, and is compatible with NDI 5 and 6.

# NDI input device

This device allows receiving a video stream directly from a NDI-compatible input.

Simply choose the wanted input in the list, and put the output at the end of the video chain.

# NDI output device

This device allows to create a NDI stream that other NDI-compatible software will be able to display or modify.

Simply choose the viewport options, a rendering rate, and a name for the output. You can then use the device as input to video filters.

# PTZ support

A camera exposing PTZ controls will be able to get controlled by ossia. 
The following parameters are available if the camera provides access to them: 

```
/ptz/zoom (float)
/ptz/pan (float)
/ptz/tilt (float)
/ptz/pan/speed (float)
/ptz/tilt/speed (float)
/ptz/preset/store (int)
/ptz/preset/recall (int)
/ptz/focus/auto (impulse)
/ptz/focus/manual (float)
/ptz/focus/speed (float)
/ptz/wb/auto (impulse)
/ptz/wb/indoor (impulse)
/ptz/wb/outdoor (impulse)
/ptz/wb/oneshot (impulse)
/ptz/wb/manual (rgb)
/ptz/exposure/auto (impulse)
/ptz/exposure/manual (float)
```
