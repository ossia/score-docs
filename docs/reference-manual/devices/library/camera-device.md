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

The video input system uses FFMPEG, which itself leverages the operating system's video input decoding mechanism as far as possible.

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

### Spout, Syphon, PipeWire
Spout is supported as output on Windows. Syphon on Mac is not yet supported, neither is PipeWire on Linux.
Complete support for both systems is slated for a 3.x release of score.

