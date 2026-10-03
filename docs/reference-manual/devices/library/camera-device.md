---
layout: default

title: Camera device
description: "Using a camera as source for visuals in ossia score"

parent: Devices
grand_parent: Reference

permalink: /devices/camera-device.html
---

![Device setup window]({{ site.img }}/reference/devices/camera-device.png "score device setup")

Score supports using camera inputs in its VFX graph.
The camera can be used as the input of a texture port.

## Example: showing the raw camera feed

In this example, we perform the following steps:
1. Add the camera input through the device explorer.
2. Likewise, add a window device in which the camera is going to be rendered.
3. Add a "passthrough" video effect, to connect the camera input to the window output.
4. Set up the passthrough ports.
5. Press play and enjoy !

The passthrough effect can be found in the [[library|user library]], in the folder `Presets/GLSL_Shaders/utility`.

<video controls>
    <source src="{{ site.img }}/reference/devices/camera-example.mp4" type="video/mp4">
</video>

## Technical information

Camera capture uses the platform's available input mechanisms and FFmpeg conversion/decoding paths. Supported camera modes depend on the device, driver and score build; camera access may require operating-system permission.

The device chooser includes **Default Camera**, which selects an available camera and suitable mode when connected. Select a specific enumerated camera/mode when repeatable resolution, frame rate or device identity matters. “Default” is a convenience selection, not a guarantee that the same physical camera is present on another machine.

Texture outlet inspectors can preview the rendered result. Some capture-specific dialogs, notably Window Capture and NDI, also offer a live preview; this does not mean every camera settings dialog has identical preview controls.

## Window and screen capture

Current development builds with capture support register **Window Capture** as a separate video input. Its **Mode** choices are **Window**, **All Screens**, **Single Screen** and **Region**, with unsupported modes disabled by the current backend. Select the window or screen, or set **Region X**, **Region Y**, **Region Width** and **Region Height**. **Refresh** updates the available sources; **Frame Rate** and **Preview** help configure the feed.

On Wayland a system picker appears when capture starts, and portal permission governs the selection. On macOS, grant **Screen Recording** permission in System Settings → Privacy & Security, then refresh. Windows and X11 use their own capture backends. Do not assume that a window identifier or capture mode is portable across these systems.

Route Window Capture to a texture inlet just like a camera; it is not the [Window output device]({{ site.baseurl }}/devices/window-device.html).

## GPhoto2 DSLR

Builds with GPhoto2 support expose **GPhoto2 DSLR** for compatible cameras. **Camera Model** and **Port** identify the camera; its live-preview images feed the texture graph and camera-reported configuration entries become typed device parameters. This needs the libgphoto2 runtime and a camera with supported preview/configuration operations, not merely USB connectivity.

See [[GPhoto2 DSLR device]] for discovery, runtime libraries and the configuration tree.

## V4L2 support

V4L2 is the Linux video subsystem API.

The `v4l2loopback` kernel module allows for a lot of useful things.

### Grabbing the screen with v4l2loopback

```bash
$ sudo modprobe v4l2loopback
$ ffmpeg -f x11grab -framerate 60 -video_size 3840x2160 -i :0.0+0,0 -f v4l2 /dev/video0
```

### Forwarding an external video file to score through v4l2loopback

```bash
$ sudo modprobe v4l2loopback
$ while 1 ; do ffmpeg -re -i ./test.mp4 -f v4l2 /dev/video0 ; done
```

## Special camera support

### Microsoft Kinect
Support for Kinect cameras has been implemented through the Freenect library.
However, the support is still experimental and requires building `score` from source with the Freenect libraries.

### Shared video sources

Use the dedicated [Spout]({{ site.baseurl }}/devices/spout-device.html) devices on Windows, [Syphon]({{ site.baseurl }}/devices/syphon-device.html) on macOS, or [PipeWire video]({{ site.baseurl }}/devices/pipewire-device.html) on Linux. These are available input/output paths in compatible builds, not camera-driver modes. [GStreamer]({{ site.baseurl }}/devices/gstreamer-device.html) and [Libav]({{ site.baseurl }}/devices/libav-device.html) provide additional streaming inputs.

