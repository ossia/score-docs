---
layout: default
title: Devices
nav_order: 2
parent: References
has_children: true
permalink: /docs/references/devices-types.html

description: The various types of devices in *score*
tag: "Setup"
visible: true
---

# Devices

## What are devices ?

Devices are pieces of software or hardware used in your project to be controlled from *score* or used as input for your *score* scenario.

Score currently support the following devices types:


| OSC                                                             | Utilities                                                   | Hardware                                                        | Web                                                               | Lights                                                          | Audio                                                   | Video
|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------||:----------------------------------------------------------------|:----------------------------------------------------------------|
| [OSCQuery](/docs/references/devices-types/oscquery-device.html) | [Mapper](/docs/references/devices-types/mapper-device.html) | [Midi in](/docs/references/devices-types/midiin-device.html)    | [HTTP](/docs/references/devices-types/http-device.html)| [Artnet](/docs/references/devices-types/artnet-device.html)     | [Audio](/docs/references/devices-types/audio-device.html)   | [Window](/docs/references/devices-types/window-device.html)     |   
| [OSC](/docs/references/devices-types/osc-device.html)           | [Local](/docs/references/devices-types/local-device.html)   | [Midi out](/docs/references/devices-types/midiout-device.html)  | [WS](/docs/references/devices-types/ws-device.html)               |||[Camera](/docs/references/devices-types/camera-device.html)   
| [Minuit](/docs/references/devices-types/minuit-device.html)     |                                                             | [Serial](/docs/references/devices-types/serial-device.html)     |                                                                   |
|                                                                 |                                                             | [Joystick](/docs/references/devices-types/joystick-device.html) |                                                                   |
|                                                                 |                                                             | [Wiimote](/docs/references/devices-types/wiimote-device.html)   |



## Setting up devices

From *score* main window, right-click in the `Device explorer` on the left of window and choose `Add device` from the `Device explorer` contextual menu. This brings *score*'s device setup window.

![Device setup window](/score-docs/assets/images/references/devices-types/add-device.gif "score device setup")

In the Device setup window, in the left column, select the desired device type.

{: .toc}
