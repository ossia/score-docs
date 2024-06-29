---
layout: default

title: BLE device
description: "Using the BLE protocol in ossia score"

parent: Devices
grand_parent: Reference

permalink: /devices/ble-device.html
---

![Device setup window]({{ site.img }}/reference/devices/ble-device.png "score device setup")

The BLE device enables ossia to communicate over [Bluetooth Low Energy](https://en.wikipedia.org/wiki/Bluetooth_Low_Energy), a protocol 
common across IoT sensors.

There are two ways to use the protocol: 

- If one simply selects the "BLE" protocol without selecting a specific Bluetooth identifier, then the device
will not connec to any specific device and will instead display all the [advertisments](https://novelbits.io/bluetooth-low-energy-advertisements-part-1/) of the surrounding devices.

![BLE Scan]({{ site.img }}/reference/devices/ble/ble-scan.png "BLE scan mode")

- If one selects a specific device, then a BLE connection will be established.
Note that this can often take on the order of 5 - 10 seconds depending on the BLE device performance and capabilities.
This will grant access to all the [GATT services](https://learn.adafruit.com/introduction-to-bluetooth-low-energy/gatt) provided by the device.

![BLE Connect mode]({{ site.img }}/reference/devices/ble/ble-connect.png "BLE connect mode")
