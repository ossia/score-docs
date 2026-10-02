---
layout: default

title: Automation
description: "Send a value evolving along an editable curve over time"

parent: Processes
grand_parent: Reference

permalink: /processes/automation.html
---
# Automation

<!-- TODO screenshot: ![Automation]({{ site.img }}/reference/processes/automation.png "Automation") -->

The Automation is one of score's most fundamental processes. It outputs a single value that
evolves along an editable curve for the duration of its parent interval — the classic way
to animate a parameter over time.

## The curve

The curve is drawn in the process body and read from left (interval start) to right
(interval end):

* **Double-click** on the curve to add a point.
* **Drag** points to shape the envelope.
* **Drag a segment** to bend it; segments support several tween shapes (linear, power,
  sine, …) via the right-click menu.

The vertical axis is normalised between 0 and 1 and then remapped to the output range.

## Min / Max

The output range. The normalised curve value (0–1) is scaled so that 0 maps to **Min** and
1 maps to **Max**. Set these to match the range of the parameter you are driving.

## Address

Drag a parameter from a [device](https://ossia.io/score-docs/devices/devices.html) onto the
Automation, or onto the process, to bind the output directly to that address. The
Automation will then write its evolving value to that parameter as the interval plays.

## Output

The current curve value, which can also be connected to other processes through the port
on the process header.
