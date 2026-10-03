---
layout: default
title: GPhoto2 DSLR device
description: "Camera live-view textures and configuration through libgphoto2"
parent: Devices
grand_parent: Reference
permalink: /devices/gphoto-device.html
---

# GPhoto2 DSLR device

**GPhoto2 DSLR** connects a camera supported by libgphoto2, exposing its live-view preview as a texture and its reported configuration as device parameters. It is distinct from a webcam/video-capture device.

## Availability

This describes the current development implementation in the graphics plug-in. It is registered in native builds, not the WebAssembly build. The integration dynamically loads **libgphoto2** and **libgphoto2_port**: the device entry alone does not establish that these libraries or a compatible camera driver are installed.

The loader has Linux, macOS and Windows library-name branches. Actual camera support, USB access and live-view capability depend on the installed libgphoto2 distribution and camera; this is not a guarantee that every supported still camera can provide a live preview on every platform. Close other applications holding the camera before connecting it to score.

## Connection

1. Connect the camera and enable the camera's appropriate remote-control/USB mode.
2. Open **Add device** in the [Device explorer]({{ site.baseurl }}/panels/explorer.html) and select **GPhoto2 DSLR**.
3. Choose a detected camera, or **Default DSLR** to resolve the first detected camera when connecting.
4. Review **Device Name**, **Camera Model** and **Port**. The port is a libgphoto2 camera port identifier, not an OSC or TCP port.
5. Expand the resulting device to inspect the controls the camera actually reports.

If no camera is detected, verify the runtime libraries, libgphoto2 camera support and operating-system device permissions. A default selection cannot provide an image when detection returns no camera.

## Texture and controls

The **device root carries the preview texture**. Select that address as the source for a compatible texture input in your graphics patch.

Configuration entries are children of the root, using the camera's reported configuration names. Their value types follow the camera widgets: toggles become booleans, ranges become floats, menu/radio choices and text become strings, and dates become integers. Available numeric ranges and menu choices are attached to the parameters. Changing a supported configuration parameter queues the corresponding camera-setting update.

The address names and available controls are camera-specific: do not assume that an aperture, ISO or shutter setting has a universal path. These controls are not a promise of continuous feedback for changes made directly on the camera.

## Limitations

This integration uses libgphoto2's **preview capture** path. It is not a documented still-photo download workflow, a full-resolution recording device, or a guarantee of a particular frame rate. A camera can connect successfully while refusing preview capture in its current mode. Test the actual camera configuration before relying on it in a performance.

See also [Camera device]({{ site.baseurl }}/devices/camera-device.html) for ordinary capture devices and [Working with devices]({{ site.baseurl }}/quick-start/working-with-devices.html).
