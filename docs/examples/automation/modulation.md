---
layout: default

title: Device modulation
description: "An example showing how to modulate devices and processes over time"

parent: Automation
grand_parent: Examples

permalink: /examples/automation/modulation.html
score: /examples/automation/automating.score
---

# Device Modulation

<video controls>
    <source src="{{ site.img }}/examples/automation/automating.mp4" type="video/mp4">
</video>

This example demonstrates automating external devices and internal processes using different modulation sources.

## Overview

LFOs create periodic movement, step sequences produce repeating patterns, and noise expressions introduce less predictable variation. These are useful alternatives to drawing every change by hand, whether you are controlling a sound parameter, a light or another application.

Two displays compare a directly connected process with an OSC device parameter. The distinction matters for sparse messages: a cable carries individual emissions, while an address-bound inlet reads the device's stored value each tick.

## Try it

1. Start playback and watch the LFOs in the `Display` interval. Change a rate or waveform to explore different kinds of periodic movement.
2. Trigger the LFO interval's end to switch to `Step`. Edit a few step values and compare the displays, especially between emissions.
3. Trigger again to reach `Math expression`. Change a noise parameter and compare its irregular motion with the repeating LFO and step patterns. The two generators have slightly different saved parameters, so their curves need not match.
4. Trigger the expression interval's end to return to LFO. Try choosing a source for a particular use: a regular pulse, a sequence of lighting levels or a slowly wandering control.

The `Display` interval has its own end trigger; keep it running while comparing the source branches. The example makes no audio and needs no media files.

The saved OSC device listens on UDP `0.0.0.0:9997` and sends `/some_address` to `127.0.0.1:9996`. An external receiver on 9996 can monitor the outgoing messages, but is not required for the internal display comparison. Change the remote host and port before using a different application or computer.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Automation]] - Automation curve process reference
- [[Automations]] - In-depth guide to automations
- [[LFO]] - Low-frequency oscillator
- [[Step sequencer]] - Step sequencer process
- [[Working with devices]] - General device setup
