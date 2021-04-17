---
layout: default

title: Devices

parent: Reference
has_children: true

permalink: /devices.html
---

# Devices

## What are devices ?

Devices are pieces of software or hardware used in your project to be controlled from *score* or used as input for your *score* scenario.

*Score* currently support the following devices types:


| OSC                                                             | Utilities                                                   | Hardware                                                        | Web                                                               | Lights                                                          | Audio                                                   | Video
|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------|:------------------------------------------------------------|:----------------------------------------------------------------||:----------------------------------------------------------------|:----------------------------------------------------------------|
| [OSCQuery]({{ site.baseurl }}/devices/oscquery-device.html) | [Mapper]({{ site.baseurl }}/devices/mapper-device.html) | [Midi in]({{ site.baseurl }}/devices/midiin-device.html)    | [HTTP]({{ site.baseurl }}/devices/http-device.html)| [Artnet]({{ site.baseurl }}/devices/artnet-device.html)     | [Audio]({{ site.baseurl }}/devices/audio-device.html)   | [Window]({{ site.baseurl }}/devices/window-device.html)     |
| [OSC]({{ site.baseurl }}/devices/osc-device.html)           | [Local]({{ site.baseurl }}/devices/local-device.html)   | [Midi out]({{ site.baseurl }}/devices/midiout-device.html)  | [WS]({{ site.baseurl }}/devices/ws-device.html)               |||[Camera]({{ site.baseurl }}/devices/camera-device.html)
| [Minuit]({{ site.baseurl }}/devices/minuit-device.html)     |                                                             | [Serial]({{ site.baseurl }}/devices/serial-device.html)     |                                                                   |
|                                                                 |                                                             | [Joystick]({{ site.baseurl }}/devices/joystick-device.html) |                                                                   |
|                                                                 |                                                             | [Wiimote]({{ site.baseurl }}/devices/wiimote-device.html)   |



## Setting up devices

From *score* main window, right-click in the `Device explorer` on the left of window and choose `Add device` from the `Device explorer` contextual menu. This brings *score*'s device setup window.

![Device setup window]({{ site.baseurl }}/assets/images/reference/devices/add-device.gif "score device setup")

In the Device setup window, in the left column, select the desired device type.

Each device type has its setup panel depending of the used protocol. Please see the relevant device reference page to setup your device.

## Rate limiting

## Device explorer

### Shortcuts

- Show: {% include shortcut.html content="Ctrl+Shift+D" %}
- Esc: deselect node


## Other

- see [libossia protocol details](https://ossia.io/site-libossia/features/oscquery.html)