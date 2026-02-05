---
layout: default

title: Device automation
description: "An example showing how to automate devices and processes over time"

parent: Automation
grand_parent: Examples

permalink: /examples/automation/automating.html
---

# Device Automation

This example demonstrates automating external devices and internal processes using various modulation sources.

## Overview

ossia score can control devices (lights, motors, software) over time using automations, LFOs, step sequencers, and other modulation sources.

## Automation sources

ossia score provides many automation sources:

| Source | Character |
|--------|-----------|
| Automation curve | Manual, precise |
| LFO | Periodic, rhythmic |
| Step Sequencer | Quantized, patterns |
| Perlin Noise | Organic, random |
| Envelope | Attack/decay shapes |
| Math expressions | Calculated values |

## Automating devices

To automate an external device:

1. Set up the device in the Device Explorer
2. Create an automation or modulation process
3. Connect the output to the device address
4. The timeline controls when automation plays

## Automating processes

Internal processes can also be automated:

1. Expose the parameter you want to control
2. Connect a modulation source
3. The parameter changes in real-time

## ArtNet integration

ArtNet is a protocol for controlling stage lighting:
- DMX over Ethernet
- Control LED fixtures, moving lights, etc.
- Each channel is an address

## Try it

If you have ArtNet-compatible lighting, connect it and open this example to see device automation in action!

[Download this example]({{ site.scores }}/examples/automation/automating.score)

## Learn more

- [[Automation]] - Automation curve process reference
- [[Automations]] - In-depth guide to automations
- [[LFO]] - Low-frequency oscillator
- [[Step sequencer]] - Step sequencer process
- [[Art-Net device]] - ArtNet/DMX lighting control
- [[Working with devices]] - General device setup
