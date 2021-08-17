---
layout: default

title: Control utilities
description: "Useful processes for sending control messages"

parent: Processes
grand_parent: Reference

permalink: /processes/control-utilities.html
---

# Impulse metronome

![Impulse metronome]({{ site.img }}/reference/processes/impulse-metronome.png "Impulse metronome")

The simplest possible metronome, synchronized to its parent interval. Will send an impulse on each beat.

# Free metronome

![Free metronome]({{ site.img }}/reference/processes/free-metronome.png "Free metronome")

A desynchronized metronome. It can ignore the parent interval's tempo and will instead beat at its own unrelated speed, a bit like the `[metro]` objects in Pure Data or Max/MSP.

If "Quantify" is set on "Free", then the raw frequency in Hertz will be used as tempo source.
Else, the parent tempo is used. The rate can be chosen with the musical division selector.
