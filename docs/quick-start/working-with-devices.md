---
layout: default

title: Working with devices
description: "Working with devices"

parent: Quick start
nav_order: 2

permalink: /quick-start/working-with-devices.html
---

# Working with your devices

*score* is built from the ground up to be as interoperable as possible with other devices involved in a creative project, whether they are software or hardware.

![score main window]({{ site.img }}/quick-start/working-with-devices/ecosystem.png "score main window")

When starting a project in *score* you will most likely want to start by setting up the devices *score* will be used with.

## Setting up your devices network

These devices can be freely added to your current score project from the [[Device explorer]] panel. Bring up the `Device explorer` panel using {% include shortcut.html content="Ctrl+Shift+D" %} shortcut or click on the bottom left icon.

![Device explorer icon]({{ site.img }}/quick-start/working-with-devices/de-button.png "Device explorer icon")

Right-click on the `Device explorer` panel and choose **Add device** (or use {% include shortcut.html content="Ctrl+B" %} while the panel is active). Select the communication protocol, choose a discovered device or library definition if offered, and review its connection settings before accepting.

![Adding a device to *score* project]({{ site.img }}/quick-start/working-with-devices/add-device.gif "Adding a device to *score* project")

> To edit an existing device's settings, stop playback, then right-click its root and choose **Edit**. In the current development build, adding or importing a new device is allowed during playback, but removal and edits to existing device structures remain restricted.

### Find the right device

The development dialog separates **Protocols** from saved **Presets**, with filter fields for finding a protocol, hardware device or preset. A preset is a `.device` definition from the library's packages, not a guarantee that the hardware or required add-on is installed.

Some protocols offer a **Default** entry. Its meaning depends on the protocol; for example, a default joystick picks available hardware instead of fixing the project to one controller. Use a named selection where a show depends on a particular unit.

The available protocol list depends on the build, platform and installed dependencies. For current development capabilities, see [CAN]({{ site.baseurl }}/devices/can-device.html), [Companion modules]({{ site.baseurl }}/devices/companion-device.html) and [GPhoto2 DSLR]({{ site.baseurl }}/devices/gphoto-device.html). The [tracking protocols reference]({{ site.baseurl }}/devices/tracking-device.html) explicitly distinguishes source implementations from an add-on that is currently disabled.

*Score* currently supports the following devices types:

{% include devices-table.md %}

Detailed explanations on these various device types and corresponding setup options can be found in the [Reference pages]({{ site.baseurl }}/devices.html).

## Devices' namespace browsing

The `Device explorer` provides a unified view of your device's parameters as a tree-like structure. Devices are exposed as a number of nodes (some key parts of your device) and their related parameters.

From there you can freely browse your distant devices for monitoring or more importantly to select the parameters you want to control from *score*, as detailed in the next topic of this [Quick start]({{ site.baseurl }}/quick-start/saving-and-recalling-devices-state.html "Scenario authoring").

![Device's namespace browsing]({{ site.img }}/quick-start/working-with-devices/de-browsing.gif "Device's namespace browsing")

## Monitor & remote control of parameters

The `Device explorer` also provides detailed information about your device parameters. Clicking a parameter from the namespace brings a dedicated inspector at the bottom displaying it's various attributes, such as its current value (assuming your device echoes back its parameters value to *score*).

You may also use this inspector to remotely change the value of a parameter (e.g. for testing purpose).

![Device's parameter inspector]({{ site.img }}/quick-start/working-with-devices/bi-directionnal.gif "Device's parameter inspector")

## Reuse a device setup

Select the device root, then choose **Export device** to save a `.device` file. In another project, right-click empty explorer space and choose **Import device**. Review names, ports and paths after importing; external packages, scripts, databases and hardware still need to be available.

This saves a device definition, not a timeline cue. Continue with [Saving and recalling devices' state]({{ site.baseurl }}/quick-start/saving-and-recalling-devices-state.html) to record parameter values for playback. The [Device explorer reference]({{ site.baseurl }}/panels/explorer.html) explains filters, presets, monitoring and connection actions.