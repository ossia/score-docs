---
layout: default

title: "Working with devices"
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

Right click on the `Device explorer` panel and setup the desired communication protocol between *score* and your device.

![Adding a device to *score* project]({{ site.img }}/quick-start/working-with-devices/add-device.gif "Adding a device to *score* project")

> Remember you can at any time edit the settings of your device using right-click, then select `Edit` from the contextual menu

*Score* currently support the following devices types:

{% include devices-table.md %}

Detailed explanations on these various device types and corresponding setup options can be found in the [Reference pages]({{ site.baseurl }}/devices.html).

## Devices' namespace browsing

The `Device explorer` provides a unified view of your devices parameters as a tree-like structure. Devices are exposed as a number of nodes (some key parts of your device) and their related parameters.

From there you can freely browse your distant devices for monitoring or more importantly to select the parameters you want to control from *score*, as detailed in the next topic of this [Quick start]({{ site.baseurl }}/quick-start/saving-and-recalling-devices-state.html "Scenario authoring").

![Device's namespace browsing]({{ site.img }}/quick-start/working-with-devices/de-browsing.gif "Device's namespace browsing")

## Monitor & remote control of parameters

The `Device explorer` also provides detailed information about your device parameters. Clicking a parameter from the namespace brings a dedicated inspector at the bottom, displaying it s various attributes, such as its current value (assuming your device echoes back its parameters value to *score*).

You may also use this inspector to remotely change the value of a parameter (e.g. for testing purpose).

![Device's parameter inspector]({{ site.img }}/quick-start/working-with-devices/bi-directionnal.gif "Device's parameter inspector")