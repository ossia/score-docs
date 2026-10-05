---
layout: default

title: Syphon devices
description: "Sending and receiving textures via Syphon"

parent: Devices
grand_parent: Reference

permalink: /devices/syphon-device.html
---

# Syphon

[Syphon](http://syphon.v002.info/) is a macOS-only protocol and library for sharing video textures across applications. 

# Syphon input device

This device allows receiving a video stream directly from a Syphon-compatible input.

Choose a published Syphon source and assign the device to a **texture inlet**. Connect the receiving process's texture outlet to a window or another destination.

# Syphon output device

This device allows to create a Syphon stream that other Syphon-compatible software will be able to display or modify.

Choose the output name, width, height and rendering rate, then assign the device as the destination of the final **texture outlet**. Select the published server in the other application.

## Backends and limitations

Syphon requires a macOS build with Syphon support. It has native **Metal** and **OpenGL** input/output paths; Metal does not require rendering the whole project through OpenGL. The available path follows the graphics backend and the installed Syphon framework.

Syphon carries textures, not the audio mix. The receiving application must support Syphon directly or through a compatible plug-in/bridge. For OBS workflows see [Livestreaming]({{ site.baseurl }}/common-practices/10-livestreaming.html); for color/HDR considerations see [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html).
