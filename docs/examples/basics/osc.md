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

This timeline sends state messages and automation values through one OSC device, then uses incoming messages and stored values for triggers and conditions. There are no audio or graphics processes.

## Network setup

The saved `OSC` device listens on UDP `0.0.0.0:9997` and sends to `127.0.0.1:9996`. Run an OSC monitor on port 9996 to see output, and send to the computer's port 9997 to drive the input examples. Change the remote host if your receiving application is on another computer.

The device tree contains `/my_float`, `/my_int`, `/my_impulse` and integer addresses `/instances/foo.1` through `/instances/foo.5`.

## Exercise the timeline

1. Start playback. The first states send `/my_float` values 0, 1 and 2 and several `/instances/foo.*` values. Observe them in the device tree or external monitor.
2. Follow `Tween`, which automates `/my_float` with Tween enabled, and the later `Automation` interval, which does not. Tween uses the current address value for its initial segment.
3. Send an OSC impulse at `/my_impulse` to release the waiting trigger. Its branch later waits until `/my_int` equals 5.
4. Trigger the separate conditional branch manually. When it reaches its next event, `/my_float < 0.5` selects `Fade In`; otherwise `Fade out` runs. Both automate `/instances/foo.1`.
5. Use the standalone `Set my_float to 0` and `Set my_float to 1` cues to influence the comparison before it is evaluated.

The final interval named `Patterns` contains an automation with no saved output address, so it sends nothing until you assign a destination. The example does not require an OSCQuery server; see [OSC device]({{ site.baseurl }}/devices/osc-device.html) for ordinary OSC configuration.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[OSC device]] - Full OSC device configuration reference
- [[OSCQuery device]] - OSCQuery protocol with automatic discovery
- [[Working with devices]] - General device setup guide
- [OSC specification](http://opensoundcontrol.org/) - Official OSC protocol documentation