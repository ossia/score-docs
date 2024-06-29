---
layout: default

title: GPS device
description: "Using the GPS protocol in ossia score"

parent: Devices
grand_parent: Reference

permalink: /devices/gps-device.html
---

![Device setup window]({{ site.img }}/reference/devices/gps-device.png "score device setup")

ossia supports reading GPS data from [gpsd](https://gpsd.gitlab.io/gpsd/) servers. This can be used 
for instance to easily read the data of a GPS chip such as a BN-220 connected to a Raspberry Pi's UART port.

When connected to a GPSD instance, ossia will report latitude, longitude, number of satellites and GPS time.
