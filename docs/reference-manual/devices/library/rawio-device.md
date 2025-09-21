---
layout: default

title: Raw I/O device
description: "Controlling GPIOs, ADCs, etc."

parent: Devices
grand_parent: Reference

permalink: /devices/rawio-device.html
---

![Device setup window]({{ site.img }}/reference/devices/raw-device.png "score device setup")

The Raw I/O device allows to leverage the hardware features of an embedded Linux system directly:

 - GPIOs
 - ADCs
 - DACs
 - PWMs

and more to come!

This feature is only meaningful when running score on a Raspberry Pi or embedded board with accessible pin headers.
As such, it is only available on Linux.

Just like for the ArtNet devices, one adds the used GPIOs, ADCs, etc. : they will show up as accessible addresses.


## Configuring the operating system

Usually, on Linux, the raw devices aren't accessible to a non-root user.
It is necessary to perform the following steps: 

```
# 1. If the gpio group doesn't exist, add it
$ groupadd gpio

# 2. Add your username to the group gpio
$ usermod -a -G gpio $USER

# 3. Create an udev rules file to automatically set 
# gpio devices to the gpio group if they aren't already.
# To check that: 
# $ cd /dev; ls -l | grep gpio
# 
# The second column will indicate the group of the /dev/gpiochip0...N files
# which should be "gpio".
# 
# Create the file: /etc/udev/rules.d/99-com.rules
# With the following content:

SUBSYSTEM=="gpio", GROUP="gpio", MODE="0660"

# 4. Log-out and log-in again, gpio chips will now be available directly from ossia.
```
