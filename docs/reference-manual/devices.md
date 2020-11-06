---
layout: default
title: Devices
nav_order: 2
parent: Reference manual
has_children:
permalink: /score-docs/docs/reference-manual/devices.html

description: The various types of devices in *score*
tag: "Setup"
visible: true
---

# Devices

## What are devices ?

Devices are pieces of software or hardware used in your project to be controlled from *score* or used as input for your *score* scenario.

*Score* currently support the following devices types:


| OSC                                                             | Utilities                                                   | Hardware                                                        | Web                                                               | Lights                                                          | Audio                                                   | Video
|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------||:----------------------------------------------------------------|:----------------------------------------------------------------|
| [OSCQuery](/score-docs/docs/reference-manual/devices-types/oscquery-device.html) | [Mapper](/score-docs/docs/reference-manual/devices-types/mapper-device.html) | [Midi in](/score-docs/docs/reference-manual/devices-types/midiin-device.html)    | [HTTP](/score-docs/docs/reference-manual/devices-types/http-device.html)| [Artnet](/score-docs/docs/reference-manual/devices-types/artnet-device.html)     | [Audio](/score-docs/docs/reference-manual/devices-types/audio-device.html)   | [Window](/score-docs/docs/reference-manual/devices-types/window-device.html)     |   
| [OSC](/score-docs/docs/reference-manual/devices-types/osc-device.html)           | [Local](/score-docs/docs/reference-manual/devices-types/local-device.html)   | [Midi out](/score-docs/docs/reference-manual/devices-types/midiout-device.html)  | [WS](/score-docs/docs/reference-manual/devices-types/ws-device.html)               |||[Camera](/score-docs/docs/reference-manual/devices-types/camera-device.html)   
| [Minuit](/score-docs/docs/reference-manual/devices-types/minuit-device.html)     |                                                             | [Serial](/score-docs/docs/reference-manual/devices-types/serial-device.html)     |                                                                   |
|                                                                 |                                                             | [Joystick](/score-docs/docs/reference-manual/devices-types/joystick-device.html) |                                                                   |
|                                                                 |                                                             | [Wiimote](/score-docs/docs/reference-manual/devices-types/wiimote-device.html)   |



## Setting up devices

From *score* main window, right-click in the `Device explorer` on the left of window and choose `Add device` from the `Device explorer` contextual menu. This brings *score*'s device setup window.

![Device setup window](/score-docs/assets/images/reference-manual/devices-types/add-device.gif "score device setup")

In the Device setup window, in the left column, select the desired device type.

Each device type has its setup panel depending of the used protocol. Please see the [Devices references page](/score-docs/docs/reference-manual/devices-references.html) to setup your device.