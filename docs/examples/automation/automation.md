---
layout: default

title: Automation
description: "Choose a movement for a parameter, or make incoming sensor data steadier and easier to map."

parent: Examples
has_children: true

permalink: /examples/automation
---

# Automation Examples

Parameter movement can give a static sound, light or image a sense of phrasing. Start by deciding whether you want to **generate movement** or **shape movement arriving from elsewhere**.

- [Device modulation]({{ site.baseurl }}/examples/automation/modulation.html) compares regular oscillation, repeating steps and wandering noise. Watch the curves and choose the kind of movement you could reuse for a pulse, a lighting sequence or a slowly changing texture. It also shows why sending individual changes differs from reading a parameter's current value.
- [Smoothing and filtering]({{ site.baseurl }}/examples/automation/smoothing.html) compares steadiness with responsiveness. Use generated noise to explore the trade-off before adapting the filters to a sensor, then calibrate the result to the range a destination needs.

Both examples work without external hardware and show their results in displays. To draw or recall a particular gesture instead, use [Process presets, cues and automations]({{ site.baseurl }}/examples/basics/process-cues-and-automations.html). To blend several influences into one control, explore [Weighted and time-based interpolation]({{ site.baseurl }}/examples/basics/interpolation.html).
