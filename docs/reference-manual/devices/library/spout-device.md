---
layout: default

title: Spout devices
description: "Sending and receiving textures via Spout"

parent: Devices
grand_parent: Reference

permalink: /devices/spout-device.html
---

# Spout

[Spout](https://spout.zeal.co/) is a Windows-only protocol and library for sharing video textures across applications. 

# Spout input device

This device allows receiving a video stream directly from a Spout-compatible input.

Choose the sending application in the input list and assign the device to a **texture inlet**. Route the receiving process's texture outlet to a window or another output.

# Spout output device

This device publishes a Spout stream for another application. Choose the output name, width, height and rendering rate, then assign it as the destination of the final **texture outlet**. Select this sender in the receiving application.

## Backends and limitations

Spout support must be included in the Windows build. It includes OpenGL, D3D11, D3D12 (through a D3D11 bridge) and Vulkan sharing paths; Vulkan additionally needs the appropriate build headers and external-memory capabilities. These are backend-specific interop paths, not a promise that every GPU/driver combination can exchange textures without copies.

Spout shares video, not score's audio mix. Route audio separately when streaming to OBS. See [Livestreaming]({{ site.baseurl }}/common-practices/10-livestreaming.html) and [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html).
