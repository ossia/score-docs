---
layout: default

title: Raw I/O device
description: "Using the raw I/O protocol in ossia score"

parent: Devices
grand_parent: Reference

permalink: /devices/rawio-device.html
---

![Device setup window]({{ site.img }}/reference/devices/raw-device.png "score device setup")

The Raw I/O device allows to leverage the hardware features of an embedded Linux system directly:

 - GPIOs
 - ADCs
 - DACs
 - PWMs

and more to come!

This feature is only meaningful when running score on a Raspberry Pi or embedded board with accessible pin headers.
As such, it is only available on Linux.

Just like for the ArtNet devices, one adds the used GPIOs, ADCs, etc. : they will show up as accessible addresses.

