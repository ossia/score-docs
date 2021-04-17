---
layout: default
title: Control utilities

parent: Processes
grand_parent: Reference manual

permalink: /docs/reference-manual/processes/control-utilities.html
---

# Impulse metronome

- A metronome synchronized to its parent interval. Will send an impulse on each beat.

# Free metronome

- A desynchronized metronome. That is, it can ignore the parent interval's tempo and will instead have its own unrelated tempo.
It Will send an impulse on each beat (depending on the duration setting).

If "Quantify" is set on "Free", then the raw frequency in Hertz will be used as tempo source.
Else, the parent tempo is used. The rate can be chosen with the musical division selector.

-