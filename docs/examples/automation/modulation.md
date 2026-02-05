---
layout: default

title: Device modulation
description: "An example showing how to modulate devices and processes over time"

parent: Automation
grand_parent: Examples

permalink: /examples/automation/modulation.html
---

# Device Modulation

This example demonstrates automating external devices and internal processes using various modulation sources.

## Overview

ossia score can control devices (lights, motors, software) over time using automations, LFOs, step sequencers, and other modulation sources which evolve over time.

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

## Try it

Open this example to see modulation in action!

[Download this example]({{ site.scores }}/examples/automation/modulating.score)

## Learn more

- [[Automation]] - Automation curve process reference
- [[Automations]] - In-depth guide to automations
- [[LFO]] - Low-frequency oscillator
- [[Step sequencer]] - Step sequencer process
- [[Working with devices]] - General device setup
