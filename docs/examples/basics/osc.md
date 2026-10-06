---
layout: default

title: Basic OSC example
description: "A basic example that presents the OSC objects"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/osc.html
score: /examples/basics/osc.score
---

# Basic OSC Example

![OSC]({{ site.img }}/examples/basics/osc.png "Composing OSC messages in ossia score")

This example demonstrates setting up OSC (Open Sound Control) communication in *score*.

## Overview

OSC is a protocol for communication between multimedia devices, software, and instruments. *score* can send cues and automation to another application, and receive messages that influence a performance's timing or select a branch.

Use this example as a starting point for controlling a synthesizer, visual application or lighting system. It works with ordinary OSC; an OSCQuery server is not required. There is no audio or graphics output inside this score.

## Network setup

The saved `OSC` device listens on UDP `0.0.0.0:9997` and sends to `127.0.0.1:9996`. Run an OSC monitor on port 9996 to see output, and send to the computer's port 9997 to drive the input examples. Change the remote host if your receiving application is on another computer.

The device tree contains example float, integer and impulse addresses. OSC addresses are hierarchical paths: you can replace these with the parameters of the application you want to control.

## Exercise the timeline

1. Start playback and watch the state messages in the device tree or external monitor. Cues set individual values; automations change them over time.
2. Compare `Tween` with `Automation`. Tween starts from the current address value rather than jumping to the curve's initial value.
3. Send an OSC impulse to `/my_impulse` to release the waiting trigger, then set `/my_int` to 5 to continue the branch.
4. Try the standalone float cues before triggering the conditional branch. Its comparison selects either a fade in or a fade out, showing how an external value can influence the composition.

The final interval named `Patterns` contains an automation with no saved output address, so it sends nothing until you assign a destination. The example does not require an OSCQuery server; see [OSC device]({{ site.baseurl }}/devices/osc-device.html) for ordinary OSC configuration.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[OSC device]] - Full OSC device configuration reference
- [[OSCQuery device]] - OSCQuery protocol with automatic discovery
- [[Working with devices]] - General device setup guide
- [OSC specification](http://opensoundcontrol.org/) - Official OSC protocol documentation