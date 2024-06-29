---
layout: default

title: Leapmotion device
description: "Using the Leapmotion in ossia score"

parent: Devices
grand_parent: Reference

permalink: /devices/leapmotion-device.html
---

![Device setup window]({{ site.img }}/reference/devices/leapmotion-device.png "score device setup")

ossia supports using the Leapmotion. Right now only one sensor at a time is supported, this limit will soon be lifted.
Every UltraLeap device recognized by the Gemini or Hyperion drivers are supported.

- On Windows and macOS the UltraLeap drivers (Gemini or Hyperion) must be installed : [https://leap2.ultraleap.com/downloads/haptics-development-kit/](https://leap2.ultraleap.com/downloads/haptics-development-kit/). Both AppleSilicon and Intel Macs are supported.

- On Linux, ossia will be looking for the following Ultraleap binaries: 

> /opt/ultraleap/LeapSDK/lib/libLeaC.so.5
> /opt/ultraleap/LeapSDK/lib/libLeaC.so.6
