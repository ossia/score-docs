---
layout: default
title: Local device
nav_order: 5
parent: Devices
grand_parent: Reference manual
has_children: false
permalink: /devices/local-device.html
---


While *score* can synchronise and automate your media softwares and hardware, it can also be remote controlled, should you need to control your scenario execution using some hyper advanced next generation IA software, a custom sensor interface or whatever fits your needs.

# Using score OSCQuery device

score exposes its scenario execution parameters through OSCQuery protocol so they can be monitored and controlled locally or from any device on the network. For example, using score's own Device explorer, you will see when browsing available OSCQuery devices the score application and its address and port.

![score OSCQuery device]({{ site.baseurl }}/assets/images/reference/devices/score_local_device.png "score local OSCQuery device")

Exposed parameters include:

- 'exit': close current scenario
- 'global_play': play score's current scenario
- 'play': play score's current scenario
- 'reconnect': reconnect a device
- 'reinit': stop score execution and recall init state
- 'running': report whether score is playing
- 'stop': stop scenario execution
- 'transport': set scenario main playhead at a particular point (in ms.)

Below is a simple Max patcher provided in [ossia-max package](https://ossia.io/site-libossia/download.html#max-binding) illustrating remote control of score's transport.

![Remote transport]({{ site.baseurl }}/assets/images/reference/devices/remote_transport.png "Remote transport")
