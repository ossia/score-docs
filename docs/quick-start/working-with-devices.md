---
layout: default
title: "Working with devices"
parent: Quick start
nav_order: 2

permalink: /docs/quick-start/working-with-devices.html
category: "site-score"

description: "Working with devices"

tag: "Presentation"
visible: true
---

# Working with your devices

*score* is built from the ground up to be as interoperatible as possible with other devices involved in a creative project, whether they are software or hardware.

![score main window](/score-docs/assets/images/quick-start/working-with-devices/ecosystem.png "score main window")

When starting a project in *score* you will most likely want to start by setting up the devices *score* will be used with.

## Setting up your devices network

These devices can be freely added to your current score project from the `Device explorer` panel. Bring up the `Device explorer` panel using {% include shortcut.html content="Ctrl+Shift+D" %} shortcut or click on the bottom left icon.

![Device explorer icon](/score-docs/assets/images/quick-start/working-with-devices/de-button.png "Device explorer icon")

Right click on the `Device explorer` panel and setup the desired communication protocol between *score* and your device.

![Adding a device to *score* project](/score-docs/assets/images/quick-start/working-with-devices/add-device.gif "Adding a device to *score* project")

> Remember you can at any time edit the settings of your device using right-click, then select `Edit` from the contextual menu

*Score* currently support the following devices types:

| OSC                                                             | Utilities                                                   | Hardware                                                        | Web                                                               | Lights                                                          | Audio                                                   | Video
|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------||:----------------------------------------------------------------|:----------------------------------------------------------------|
| [OSCQuery](/score-docs/docs/reference-manual/devices-types/oscquery-device.html) | [Mapper](/score-docs/docs/reference-manual/devices-types/mapper-device.html) | [Midi in](/score-docs/docs/reference-manual/devices-types/midiin-device.html)    | [HTTP](/score-docs/docs/reference-manual/devices-types/http-device.html)| [Artnet](/score-docs/docs/reference-manual/devices-types/artnet-device.html)     | [Audio](/score-docs/docs/reference-manual/devices-types/audio-device.html)   | [Window](/score-docs/docs/reference-manual/devices-types/window-device.html)     |   
| [OSC](/score-docs/docs/reference-manual/devices-types/osc-device.html)           | [Local](/score-docs/docs/reference-manual/devices-types/local-device.html)   | [Midi out](/score-docs/docs/reference-manual/devices-types/midiout-device.html)  | [WS](/score-docs/docs/reference-manual/devices-types/ws-device.html)               |||[Camera](/score-docs/docs/reference-manual/devices-types/camera-device.html)   
| [Minuit](/score-docs/docs/reference-manual/devices-types/minuit-device.html)     |                                                             | [Serial](/score-docs/docs/reference-manual/devices-types/serial-device.html)     |                                                                   |
|                                                                 |                                                             | [Joystick](/score-docs/docs/reference-manual/devices-types/joystick-device.html) |                                                                   |
|                                                                 |                                                             | [Wiimote](/score-docs/docs/reference-manual/devices-types/wiimote-device.html)   |


Detailed explanations on these various device types and corresponding setup options can be found in the [References pages](/score-docs/docs/reference-manual/devices.html).

## Devices' namespace browsing

The `Device explorer` provides a unified view of your devices parameters as a tree-like structure. Devices are exposed as a number of nodes (some key parts of your device) and their related parameters.

From there you can freely browse your distant devices for monitoring or more importantly to select the parameters you want to control from *score*, as detailed in the next topic of this [Quick start](/score-docs/docs/quick-start/saving-and-recalling-devices-state.html "Scenario authoring").

![Device's namespace browsing](/score-docs/assets/images/quick-start/working-with-devices/de-browsing.gif "Device's namespace browsing")

## Monitor & remote control of parameters

The `Device explorer` also provides detailed informations about your device parameters. Clicking a parameter from the namespace brings a dedicated inspector at the bottom, displaying it s various attributes, such as its current value (assuming your device echoes back its parameters value to *score*).

You may also use this inspector to remotely change the value of a parameter (e.g. for testing purpose).

![Device's parameter inspector](/score-docs/assets/images/quick-start/working-with-devices/bi-directionnal.gif "Device's parameter inspector")