---
layout: default
title: Midi output device
nav_order: 7
parent: Devices
grand_parent: Reference manual
has_children: false
permalink: /docs/reference-manual/devices-types/midiout-device.html
---

# Midi output device

To setup a device using Midi output, select `Midi output` in the Protocols column of the `Add device` window.

![Device setup window](/score-docs/assets/images/reference-manual/devices-types/midiout/midiout-device.png "score device setup")

In the `Devices` middle column, you can select your desired Midi input device.

> If you plugged in your Midi device after launching *score*, you may need to restart *score* so your it appears in the Devices column.

Optionally, you can set a custom name (or use the default one).

## Create whole tree option

Under the name of your Midi output device, you can toggle on the `Create whole tree` option. This option will create all possible Midi messages as parameters of the device as illustrated below. Addresses in the namespace will be created using the following format:

	<device name>/<channel number>/<message type>/message number>

![Midi output whole tree](/score-docs/assets/images/reference-manual/devices-types/midiin/midi-whole-tree.png "Midi output whole tree")

Should you want not to automatically create a whole Midi namespace (i.e. and use Midi learn instead), just leave the option unset.

## Use Midi learn

You can use the learn function to build your Midi output namespace with only the needed Midi message (rather than setting up the whole Midi namespace). To do so, once added the Midi device (with the `Create whole tree` option off), in the `Device explorer`, right-click on your Midi output device name and select `Learn` from the contextual menu.

![Usig Midi learn](/score-docs/assets/images/reference-manual/devices-types/midiin/midi-learn-1.png "Using Midi learn")

This opens *score*  Midi learn window. From then, *score* will monitor any incoming Midi message and store it under an address following the pattern mentioned above.

When you are done sending the needed Midi message, click `Done` on the Midi learn window.

All received Midi messages should now appear under your Midi output device name in the `Device explorer`.