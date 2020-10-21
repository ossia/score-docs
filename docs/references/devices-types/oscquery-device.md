---
layout: default
title: OSCQuery device
nav_order: 1
parent: Devices
grand_parent: References
has_children: false
permalink: /docs/references/devices-types/oscquery-device.html
---

# OSCQuery device

*score* can communicate with devices using the OSCQuery protocole.

## What is OSCQuery ?

As presented by the Vidvox Cie, The [OSC Query Protocol](https://github.com/vidvox/oscqueryproposal) is an agreed upon specification that extends the base functionality of OSC to make it easier to construct impromptu or improvisational interfaces between different systems.

> The OSCQuery Protocol builds on top of OSC to provide a standardized way for systems to publish descriptions of their OSC Address Spaces in such a way that other environments can automatically interface with them with little or no setup.
Within OSCQuery, a **server** is a host that provides a JSON data blob that describes the hierarchy of an OSC Address Space in a format that is both easy for humans and machine to interpret. Descriptions can include the type of data that is expected, the range of values that are accepted and other information about each container and method within the address space.
Within OSCQuery, a **client** refers to a piece of software that browses and interacts with a remote server's OSC address space.
See [Vidvox's detailed article](https://vdmx.vidvox.net/blog/oscquery) to read more about OSCQuery.

## Adding OSCQuery device

Once opened a new score project, right-click in the Device explorer on the left of score window and choose `Add device` from the Device explorer contextual menu. This brings score’s device setup window.

From the Protocols column, choose `OSCQuery`. You should see in the `Devices` column all OSCQuery compatibles devices available on the network.

![Device setup window](/score-docs/assets/images/references/devices-types/oscquery-device.png "score device setup")

Select the desired one from the list and click `Add`.

*score* will then query the selected device and receive its full namespace. All nodes and parameters of the device should now appear in the `Device explorer`.

