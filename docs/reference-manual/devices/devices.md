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

Devices connect the timeline and processes to external parameters and media streams. Choose a device by what it carries: control values, audio / MIDI, textures, or a display output. The following references describe available backends; individual entries depend on the operating system, build options, installed add-ons and external runtimes.

{% include devices-table.md %}

Current development builds add further media and hardware backends; this table is not a guarantee that every entry is present in an older release. See [Supported protocols and formats]({{ site.baseurl }}/reference/protocols-and-formats.html) for platform and format constraints.

### Availability references

Not every integration visible in the source tree is a usable device. [Tracking protocols]({{ site.baseurl }}/devices/tracking-device.html) documents a currently disabled add-on, while [Libmapper client]({{ site.baseurl }}/devices/libmapper-device.html) documents an optional integration with a build-interface mismatch. These are kept separate from the setup table above.

For custom script-defined network namespaces, see [QML protocols]({{ site.baseurl }}/in-depth/qml-protocols.html).

## Setting up devices

From *score* main window, right-click in the `Device explorer` on the left of window and choose `Add device` from the `Device explorer` contextual menu. This brings *score*'s device setup window.

![Device setup window]({{ site.img }}/reference/devices/add-device.gif "score device setup")

In the Device setup window, in the left column, select the desired device type.

Each device type has its setup panel depending of the used protocol. Please see the relevant device reference page to setup your device.

<!--
## Rate limiting

## Device explorer

### Shortcuts

- Show: {% include shortcut.html content="Ctrl+Shift+D" %}
- Esc: deselect node


## Other

- see [libossia protocol details](https://ossia.io/site-libossia/features/oscquery.html)

-->