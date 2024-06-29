---
layout: default

title: CoAP device
description: "Using the CoAP protocol in ossia score"

parent: Devices
grand_parent: Reference

permalink: /devices/coap-device.html
---

![Device setup window]({{ site.img }}/reference/devices/coap-device.png "score device setup")

[CoAP](https://en.wikipedia.org/wiki/Constrained_Application_Protocol) is a communication protocol tailored for IoT and low-power devices.
It is a [standard internet protocol](https://datatracker.ietf.org/doc/html/rfc7252) closely related to HTTP in behaviour and operations, 
but with much more efficient communication. 

It usually defaults to port 5683.

ossia score supports connecting to an existing CoAP server through TCP, UDP or WebSockets: for instance, one can try with the public CoAP tester, coap.me: 


![CoAP.me crawling]({{ site.img }}/reference/devices/coap/example.png "CoAP example")