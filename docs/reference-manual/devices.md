---
layout: default
title: Devices

parent: Reference manual
has_children: true

permalink: /docs/reference-manual/devices.html
---

# Devices

## What are devices ?

Devices are pieces of software or hardware used in your project to be controlled from *score* or used as input for your *score* scenario.

*Score* currently support the following devices types:


| OSC                                                             | Utilities                                                   | Hardware                                                        | Web                                                               | Lights                                                          | Audio                                                   | Video
|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------||:----------------------------------------------------------------|:----------------------------------------------------------------|
| [OSCQuery]({{ site.baseurl }}/docs/reference-manual/devices-types/oscquery-device.html) | [Mapper]({{ site.baseurl }}/docs/reference-manual/devices-types/mapper-device.html) | [Midi in]({{ site.baseurl }}/docs/reference-manual/devices-types/midiin-device.html)    | [HTTP]({{ site.baseurl }}/docs/reference-manual/devices-types/http-device.html)| [Artnet]({{ site.baseurl }}/docs/reference-manual/devices-types/artnet-device.html)     | [Audio]({{ site.baseurl }}/docs/reference-manual/devices-types/audio-device.html)   | [Window]({{ site.baseurl }}/docs/reference-manual/devices-types/window-device.html)     |
| [OSC]({{ site.baseurl }}/docs/reference-manual/devices-types/osc-device.html)           | [Local]({{ site.baseurl }}/docs/reference-manual/devices-types/local-device.html)   | [Midi out]({{ site.baseurl }}/docs/reference-manual/devices-types/midiout-device.html)  | [WS]({{ site.baseurl }}/docs/reference-manual/devices-types/ws-device.html)               |||[Camera]({{ site.baseurl }}/docs/reference-manual/devices-types/camera-device.html)
| [Minuit]({{ site.baseurl }}/docs/reference-manual/devices-types/minuit-device.html)     |                                                             | [Serial]({{ site.baseurl }}/docs/reference-manual/devices-types/serial-device.html)     |                                                                   |
|                                                                 |                                                             | [Joystick]({{ site.baseurl }}/docs/reference-manual/devices-types/joystick-device.html) |                                                                   |
|                                                                 |                                                             | [Wiimote]({{ site.baseurl }}/docs/reference-manual/devices-types/wiimote-device.html)   |



## Setting up devices

From *score* main window, right-click in the `Device explorer` on the left of window and choose `Add device` from the `Device explorer` contextual menu. This brings *score*'s device setup window.

![Device setup window]({{ site.baseurl }}/assets/images/reference-manual/devices-types/add-device.gif "score device setup")

In the Device setup window, in the left column, select the desired device type.

Each device type has its setup panel depending of the used protocol. Please see the [Devices references page]({{ site.baseurl }}/docs/reference-manual/devices-references.html) to setup your device.

## Rate limiting


## Device explorer

### Shortcuts

- Show: {% include shortcut.html content="Ctrl+Shift+D" %}
- Esc: deselect node


## Other

- see [libossia protocol details](../site-libossia/features/oscquery.html)