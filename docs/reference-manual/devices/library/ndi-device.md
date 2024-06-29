---
layout: default

title: NDI devices
description: "Sending and receiving textures via NDI"

parent: Devices
grand_parent: Reference

permalink: /devices/NDI-devices.html
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
