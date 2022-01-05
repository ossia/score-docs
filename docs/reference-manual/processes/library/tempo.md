---
layout: default

title: Tempo
description: "Adjust the tempo of an interval"

parent: Processes
grand_parent: Reference

permalink: /processes/tempo.html
---

# Tempo

This process allows to add a tempo curve to an interval, and to control its speed programmatically
through the dataflow system.

When a tempo process is assigned to an interval, its speed behaviour is taken out of the parent hierarchy:
the tempo is absolute and not impacted by the parent hierarchy's speed: a tempo of 120 will always mean 120 
in relation to the human referential.

All the child intervals of this interval will however use this interval's tempo, unless them theyselve get a tempo curve.
This allows to write poly-tempo scores.

If values are sent to the tempo process's input port, then the curve is not used and the port 
instead is used as source for the parent interval's tempo.

# Example

![Tempo]({{ site.img }}/reference/processes/tempo.gif "Tempo example")
