---
layout: default

title: Art-Net device
description: "Controlling ArtNet and DMX peripherals in ossia score"

nav_order: 13
parent: Devices
grand_parent: Reference

permalink: /devices/artnet-device.html
---

# Art-Net device

![Device setup window]({{ site.baseurl }}/assets/images/reference/devices/artnet/artnet-1.png "score device setup")

It is possible to communicate through DMX with ossia score, in order to control and automate light fixtures.

The [user library]({{ site.baseurl }}/in-depth/library.html) contains a built-in fixture library that can be added:

![Device setup window]({{ site.baseurl }}/assets/images/reference/devices/artnet/artnet-2.png "score device setup")

If no fixtures are added, then the device will instead provide the 512 raw DMX channels.

Else, each fixture will appear as a node of the device.