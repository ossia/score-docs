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
It requires the NDI add-on and an available NDI runtime. The device supports several raw RGB/YUV receive and send formats; the runtime, source and receiver determine which are usable. NDI HX additionally depends on the appropriate HX decoding runtime.

# NDI input device

This device allows receiving a video stream directly from a NDI-compatible input.

Choose the wanted **Source**, use the input dialog's **Preview**, and assign the device to a **texture inlet**. Route the receiving process to a window or other texture output.

**Color space** selects the assumed conversion matrix. An NDI received frame does not reliably communicate the matrix used by the sender, so match both ends when colors disagree.

**Receive format** offers **8-bit (SDK de-interlaces)** and **Best available (16-bit, fields)**. The latter can receive 16-bit sources (including P216 and alpha-bearing PA16), but interlaced sources may then arrive as individual fields. **Deinterlace** chooses **Weave** (more vertical detail, possible motion combing) or **Bob** (less vertical detail, smooth field-rate motion). It applies to separate fields, not already-woven full frames.

# NDI output device

This device allows to create a NDI stream that other NDI-compatible software will be able to display or modify.

Choose the output name, width, height, rate, **Format** and **Color space**, then assign the device as the destination of the final **texture outlet**. The format choices include RGBA, RGBX, BGRA, BGRX, UYVY, P216, NV12, I420 and YV12.

Use **RGBA** or **BGRA** when sending transparency; RGBX/BGRX and the listed YUV output formats do not carry alpha. Receiving alpha-bearing formats and choosing an alpha-preserving output are distinct requirements. The downstream application must also retain/composite alpha.

NDI video availability does not imply audio routing through these texture ports. Test the complete sender/receiver chain, including range and matrix choices. See [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html).

# PTZ support

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
