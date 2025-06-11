---
layout: default
title: Puara Gestures
parent: Processes
grand_parent: Reference


nav_order: 60
---

# Puara Gestures

This section describes the processes ported from the [Puara-gestures](https://github.com/Puara/puara-gestures/) library. This library provides a powerful toolkit for creating and managing high-level gestural descriptors from sensor data.

---

## Leaky Integrator

The **Leaky Integrator** process applies a smoothing algorithm to an input signal. It's particularly useful for reducing jitter from noisy sensors or creating smooth transitions in parameter values. The amount of smoothing can be controlled in real-time by adjusting the leak factor and the update frequency.

### Parameters

| Parameter               | Description                                                                                                                              |
| :---------------------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
| **Inputs**              |                                                                                                                                          |
| `Input`                 | The incoming signal to be smoothed.                                                                                                      |
| `Leak Factor`           | A `float` from 0.0 to 1.0 that controls the amount of smoothing. A value of `0.0` means the output immediately jumps to the new input (no smoothing), while a value of `1.0` means the output does not change (full smoothing). Default is `0.5`. |
| `Leak Frequency (Hz)`   | A `float` from 0.0 to 200.0 Hz that sets the rate at which the integrator updates its value. The control uses a logarithmic mapping for more intuitive musical control. Default is `100.0`. |
| **Outputs**             |                                                                                                                                          |
| `Output`                | The smoothed output signal.                                                                                                              |