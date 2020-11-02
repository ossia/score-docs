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

*Score* provides advanced tools to ease the authoring of time exigent projects involving medias: flexible score for a live performance, interactive scenario for an intermedia installation, game-like state machine scenarios, etc. 

While *score 3.0.0* itself offers a number of way to work with audio or video medias right from the app, it does not aim at being the next "All in one" super software. On the contrary, *score* was built from the ground up to be **as interoperable as possible**. Users remain thus free to use their tools of choice, be it their favorite VJing software, custom audio synthesis app or any specialized toolset, leaving score as the central hub of their project. 

It thus provides a unified place to write automations for the parameters of any of the devices involved in the project, provides means to author efficient mappings from device A to device B or to modulate some devices parameters using generative processes and so on.

![score main window](/score-docs/assets/images/quick-start/working-with-devices/ecosystem.png "score main window")

## Setting up your devices network

These devices, whether they are software or hardware can be freely added to your current score project from the `Device explorer` panel. Bring up the `Device explorer` panel using {% include shortcut.html content="Ctrl+Shift+D" %} shortcut or click on the bottom left icon.

![Device explorer icon](/score-docs/assets/images/quick-start/working-with-devices/de-button.png "Device explorer icon")

Right click on the `Device explorer` panel and setup the desired communication protocol between *score* and your device.

![Adding a device to *score* project](/score-docs/assets/images/quick-start/working-with-devices/add-device.gif "Adding a device to *score* project")

> Remember you can at any time edit the settings of your device using right-click, then select `Edit` from the contextual menu

*Score* currently support the following devices types:

| OSC                                                             | Utilities                                                   | Hardware                                                        | Web                                                               | Lights                                                          | Audio                                                   | Video
|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------||:----------------------------------------------------------------|:----------------------------------------------------------------|
| [OSCQuery](/docs/references/devices-types/oscquery-device.html) | [Mapper](/docs/references/devices-types/mapper-device.html) | [Midi in](/docs/references/devices-types/midiin-device.html)    | [HTTP](/docs/references/devices-types/http-device.html)| [Artnet](/docs/references/devices-types/artnet-device.html)     | [Audio](/docs/references/devices-types/audio-device.html)   | [Window](/docs/references/devices-types/window-device.html)     |   
| [OSC](/docs/references/devices-types/osc-device.html)           | [Local](/docs/references/devices-types/local-device.html)   | [Midi out](/docs/references/devices-types/midiout-device.html)  | [WS](/docs/references/devices-types/ws-device.html)               |||[Camera](/docs/references/devices-types/camera-device.html)   
| [Minuit](/docs/references/devices-types/minuit-device.html)     |                                                             | [Serial](/docs/references/devices-types/serial-device.html)     |                                                                   |
|                                                                 |                                                             | [Joystick](/docs/references/devices-types/joystick-device.html) |                                                                   |
|                                                                 |                                                             | [Wiimote](/docs/references/devices-types/wiimote-device.html)   |


Detailed explanations on these various device types and corresponding setup options can be found in the [References pages](/docs/references/devices-types).

## Devices' namespace browsing

The `Device explorer` provides a unified view of your devices parameters as a tree-like structure. Devices are exposed as a number of nodes (some key parts of your device) and their related parameters.

From there you can freely browse your distant devices for monitoring or more importantly to select the parameters you want to control from *score*, as detailed in the next topic of this [Quick start](/docs/quick-start/scenario-authoring.html "Scenario authoring").

![Device's namespace browsing](/score-docs/assets/images/quick-start/working-with-devices/de-browsing.gif "Device's namespace browsing")

## Monitor & remote control of parameters

The `Device explorer` also provides detailed informations about your device parameters. Clicking a parameter from the namespace brings a dedicated inspector at the bottom, displaying it s various attributes, such as its current value (assuming your device echoes back its parameters value to *score*).

You may also use this inspector to remotely change the value of a parameter (e.g. for testing purpose).

![Device's parameter inspector](/score-docs/assets/images/quick-start/working-with-devices/bi-directionnal.gif "Device's parameter inspector")