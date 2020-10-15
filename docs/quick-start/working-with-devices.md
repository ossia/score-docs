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

*Score* provides advanced tools to ease the authoring of time exigeant projects involving medias: flexible score for a live performance, interactive scenario for an intermedia installation, game-like state machine scenarios, etc. 

While *score 3.0.0* itself offers a number of way to work with audio or video medias right from the app, it does not aim at being the next "All in one super software. On the contrary, *score* was built from the ground up to be **as interoperable as possible**. Users remain thus free to use their tools of choice, be it their favorite VJing software, custom audio synthesis app or any specialized toolset, leaving score as the central hub of their project. 

It thus provides a unified place to write automations for the parameters of any of the devices involved in the project, to author efficient mappings from device A to device B, to modulate some devices parameters using generative processes and so on.

![score main window](/assets/images/quick-start/working-with-devices/ecosystem.png "score main window")

## Setting up your devices network

These devices, whether they are software or hardware can be freely added to your current score project from the `Device explorer` pane. Bring up the `Device explorer` pane using {% include shortcut.html content="Ctrl+Shift+D" %} shortcut or click on the bottom left icon.

> ![Device explorer icon](/assets/images/quick-start/working-with-devices/de-button.png "Device explorer icon")

Right click on the `Device explorer` pane and setup the desired communication protocole between *score* and your device.

![Adding a device to *score* project](/assets/images/quick-start/working-with-devices/add-device.gif "Adding a device to *score* project")

Score curently support the following devices types:
- [OSCQuery](/docs/references/devices-types/oscquery-device.html)
- [OSC](/docs/references/devices-types/osc-device.html)
- [Minuit](/docs/references/devices-types/minuit-device.html)
- [Mapper](/docs/references/devices-types/mapper-device.html)
- [Local](/docs/references/devices-types/local-device.html)
- [Midi in](/docs/references/devices-types/midiin-device.html)
- [Midi out](/docs/references/devices-types/midiout-device.html)
- [Serial](/docs/references/devices-types/serial-device.html)
- [Joystick](/docs/references/devices-types/joystick-device.html)
- [Wiimote](/docs/references/devices-types/wiimote-device.html)
- [HTTP](/docs/references/devices-types/http-device.html)
- [WS](/docs/references/devices-types/ws-device.html)
- [Artnet](/docs/references/devices-types/artnet-device.html)
- [Audio](/docs/references/devices-types/audio-device.html)
- [Window](/docs/references/devices-types/window-device.html)
- [Camera input](/docs/references/devices-types/camera-device.html)

Detailed explanations on these various device types and corresponding setup options can be found in the [References pages](/docs/references/devices-types).

> Remember you can at any time edit the settings of your device using right-click, then select `Edit` from the conextual menu

## Embeded devices browsing
