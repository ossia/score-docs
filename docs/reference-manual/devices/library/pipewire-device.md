---
layout: default
title: PipeWire video devices
description: "Connect score textures to Linux PipeWire video streams"
parent: Devices
grand_parent: Reference
permalink: /devices/pipewire-device.html
---

# PipeWire video devices

**PipeWire Video Input** and **PipeWire Video Output** connect textures to Linux PipeWire streams. They require a build with PipeWire video I/O enabled, a running PipeWire server and compatible producers or consumers. These are video devices, distinct from choosing PipeWire as score's audio driver.

## Receive video

Add **PipeWire Video Input**. **PipeWire Node** lists live sources; choose **(default source)** for automatic connection, a specific source, or **(unconnected: link it yourself)** for manual patching in a PipeWire routing tool.

**Width**, **Height**, **Frame Rate** and **Pixel Format** are negotiation preferences, not a demand that the producer change its stream. **Any** leaves the pixel-format choice open. The device advertises compatible alternatives and uses the format and dimensions actually agreed with the source. Selecting a live source can update the proposed settings from its advertised capabilities.

Assign the device to a texture inlet, then route the process's texture output to a window or other destination. This does not request desktop-capture permission: for a Wayland screen picker, use **Window Capture**, described on the [Camera device page]({{ site.baseurl }}/devices/camera-device.html#window-and-screen-capture).

## Publish video

Add **PipeWire Video Output**, choose **Width**, **Height**, **Rate** and **Pixel Format**, then assign the device as the destination of a texture outlet. **Target** lists live consumers, automatic connection, and the unconnected option for manual linking. The **PipeWire node** field supplies the path/target information used by this device.

Output format choices are the renderable subset, not all formats accepted on input. The normal path renders a texture, reads it back and publishes shared-memory buffers. Higher precision choices require a compatible consumer; selecting a float format alone does not establish an HDR display chain.

## DMA-BUF and fallback

**Zero-copy DMA-BUF** negotiates shared GPU buffers where possible:

- On input, it is enabled by default and shared memory remains offered. The producer chooses a compatible transport. Turn it off to isolate modifier or GPU-import problems.
- On output, it is optional. The current accelerated output is restricted to **RGBA**. Vulkan needs exportable DMA-BUF images and the relevant DRM-modifier/external-memory capabilities; OpenGL needs an EGL/GBM path. Other formats or unavailable export paths use CPU readback instead.
- DMA-BUF depends on both ends, their GPUs and supported modifiers. It is not guaranteed for every Linux session, cross-GPU route or pixel format. The accelerated output can still perform a GPU copy; “zero-copy” here does not mean no GPU work.
- If a negotiated DMA-BUF buffer cannot acquire a backing image, frames may be dropped with a diagnostic. Disable DMA-BUF and reconnect to use shared memory; not every late allocation failure can be repaired transparently.

The saved input path has the form `pipewire://node-name?width=1280&height=720&fps=30&format=rgba`; `dmabuf=off` disables GPU-buffer negotiation. Output paths use a node/target name with options such as `?format=rgba&dmabuf=on`. Prefer the dialog controls rather than constructing paths manually.

See [GStreamer]({{ site.baseurl }}/devices/gstreamer-device.html) for pipelines and audio/video together, [Window]({{ site.baseurl }}/devices/window-device.html) for display output, and [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html) for precision and color considerations.
