---
layout: default

title: Bitfocus Companion Device
description: "Integration with Bitfocus Companion for streaming and broadcast control"

parent: Devices
grand_parent: Reference

permalink: /devices/companion-device.html
---
# Bitfocus Companion Device

![Companion Device]({{ site.img }}/reference/devices/bitfocus/companion-device.png "Bitfocus Companion Integration")

Bitfocus Companion is a professional application for controlling streaming, broadcast, and AV equipment through hardware controllers like Stream Deck. ossia score's Companion integration enables seamless interaction between your interactive scores and Companion-compatible devices.

## Overview

This integration allows ossia score to:

- Control and receive feedback from any device supported by Bitfocus Companion
- Synchronize show states with broadcast equipment
- Integrate with professional streaming workflows

For instance, this integration makes it possible to send messages to Slack and Discord directly from score, automate Micrrosoft PowerPoint, control Barco and Panasonic projectors, Behringer mixing consoles, GrandMA lighting desks, access APIs such as Birddog Cloud, Q-SYS, VDO.Ninja or BrightSign, or even do a SpeedTest right from the score and use the result to select different behaviours :-)

## Requirements

### Software
- ossia score with Companion package installed from the package manager in the settings
- Compatible software or hardware controllers you want to use.

### Package Installation
1. Open the Package Manager from the settings
2. Search for "Bitfocus" in the remote packages list
3. Install the Bitfocus Companion Modules package (it will take some times as it is roughly a 1 gigabyte download).
4. Restart ossia score

![Bitfocus Example]({{ site.img }}/reference/devices/bitfocus/bitfocus.png "Installed Bitfocus package")

## Device Setup

### 1. Add Companion Device in score

1. Right-click in **Device Explorer**
2. Select **Add Device**
3. Choose **Bitfocus** from protocols
4. Select the actual device or protocol in the list that appears. If you do not see nay device, the package may not be installed correctly.
4. Configure the actual Companion-compatible protocol you choose.

![Bitfocus Example]({{ site.img }}/reference/devices/bitfocus/christie.png "Setting up a Companion-compatible device")


## Available Controls

Each device will present different controls, organized in the same categories.

## Related Documentation

- [OSC Device]({{ site.baseurl }}/devices/osc-device.html) - Direct OSC communication
- [Control Surface]({{ site.baseurl }}/processes/controlsurface.html) - UI control surfaces to control specific modules in the timeline.
- [Remote Control]({{ site.baseurl }}/in-depth/remote.html) - score remote control
