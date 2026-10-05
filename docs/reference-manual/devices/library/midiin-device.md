---
layout: default

title: MIDI input device
description: "Read MIDI data from an external hardware"

parent: Devices
grand_parent: Reference

permalink: /devices/midiin-device.html
---

# MIDI input device

To receive MIDI, select **MIDI Input** in the Protocols column of the **Add device** window.

![Device setup window]({{ site.img }}/reference/devices/midiin-device.png "score device setup")

In the **Devices** column, select the desired input. The list
separates hardware, software and network inputs and includes **Default MIDI In**.
The default selector resolves to the first available input reported by the backend;
it is not a guarantee that a particular keyboard will be selected. Choose a named
port for a performance setup.

Optionally, you can set a custom name (or use the default one).

On platform that support it (macOS and Linux), you can create a virtual MIDI device.

## Create whole tree option

The **Create whole tree** setting creates the complete MIDI namespace where available.
In the current input settings widget this checkbox is disabled for editing; use
**Learn** to build the namespace interactively. A whole-tree namespace uses addresses
of the following form:

	<device name>/<channel number>/<message type>/message number>

![Midi in whole tree]({{ site.img }}/reference/devices/midiin/midi-whole-tree.png "Midi in whole tree")

Should you want not to automatically create a whole Midi namespace (i.e. and use Midi learn instead), just leave the option unset.

## Use Midi learn

You can use the learn function to build your Midi input namespace with only the needed Midi message (rather than setting up the whole Midi namespace). To do so, once added the Midi device with the `Create whole tree` option off, in the `Device explorer`, right-click on your Midi input device name and select `Learn` from the contextual menu.

![Usig Midi learn]({{ site.img }}/reference/devices/midiin/midi-learn-1.png "Using Midi learn")

This opens *score*  Midi learn window. From then, *score* will monitor any incoming Midi message and store it under an address following the pattern mentioned above.

When you are done sending the needed Midi message, click `Done` on the Midi learn window.

All received Midi messages should now appear under your Midi input device name in the `Device explorer`.

## Note-on with zero velocity

**Velocity = 0 -> Note Off** interprets incoming zero-velocity note-on messages as
note-offs. It is off by default in newly created settings. Enable it for a controller
that uses this MIDI convention, particularly when driving note-lifetime tracking.
This is an input policy, separate from the output device's inverse conversion and
the [MIDI Filter]({{ site.baseurl }}/processes/midi-filter.html) controls.

## Reopening on another machine

Saved MIDI ports are matched against available ports when reopening a document,
including name-based recovery when backend identifiers change. A missing backend
or device can still leave the connection unavailable: edit the device and select
the actual input instead of assuming the saved mapping is portable.

For named controls from a manufacturer/model description, use
[MIDI Controller]({{ site.baseurl }}/devices/midi-controller-device.html)
rather than this raw MIDI Input protocol. Device maps describe controls; they do
not install a driver or make an absent hardware port available.