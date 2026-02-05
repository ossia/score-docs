---
layout: default

title: Basic OSC example
description: "A basic example that presents the OSC objects"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/osc.html
---

# Basic OSC Example

![OSC]({{ site.img }}/examples/basics/osc.png "Composing OSC messages in ossia score")

This example demonstrates setting up OSC (Open Sound Control) communication in *score*.

## Overview

OSC is a protocol for communication between multimedia devices, software, and instruments. 
*score* provides native OSC support for sending and receiving messages.

## Setting up an OSC device

To use OSC in *score*:

1. Open the **Device Explorer** panel
2. Click **Add Device**
3. Select **OSC** from the protocol list
4. Configure the connection:
   - **Host**: IP address of the remote device (or localhost)
   - **Input port**: Port to receive messages (from the device to *score*)
   - **Output port**: Port to send messages (from *score* to the device)

## OSC addresses

OSC uses a hierarchical address system similar to file paths:

```
/synth/filter/cutoff
/lights/fixture1/red
/robot/motor/speed
```

## Sending OSC messages

To send OSC from *score*:

1. Create an automation or process that outputs values
2. Connect it to an OSC address in the Device Explorer
3. During playback, values are sent as OSC messages

## Receiving OSC messages

To receive OSC in *score*:

1. Configure the input port on your [[OSC device]]
2. Addresses received appear in the Device Explorer
3. Use them as triggers or parameter sources

## Common OSC applications

OSC is used to communicate with:
- Software synthesizers (SuperCollider, Max, Pd)
- VJ software (Resolume, VDMX, TouchDesigner)
- Lighting controllers
- Motion tracking systems
- Custom hardware (Arduino, Raspberry Pi)
- Mobile apps (TouchOSC, Lemur)

## OSCQuery

ossia score also supports [[OSCQuery]], an extension that allows:
- Automatic parameter discovery
- Type information
- Value ranges
- Bidirectional sync

## Try it

[Download this example]({{ site.scores }}/examples/basics/osc.score)

## Learn more

- [[OSC device]] - Full OSC device configuration reference
- [[OSCQuery device]] - OSCQuery protocol with automatic discovery
- [[Working with devices]] - General device setup guide
- [OSC specification](http://opensoundcontrol.org/) - Official OSC protocol documentation