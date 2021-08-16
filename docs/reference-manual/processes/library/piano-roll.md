---
layout: default

title: Piano roll
description: "A way to put MIDI scores"

parent: Processes
grand_parent: Reference

permalink: /processes/piano-roll.html
---

# Piano roll

![Piano roll]({{ site.img }}/reference/processes/piano-roll.png "MIDI Piano roll")

The piano roll allows to output MIDI notes according to a score.

MIDI files can be loaded by drag'n'drop, either on a scenario, interval, or on the piano roll process directly.

Adding a note is done by double-clicking ; the note can be stretched with the mouse.

When dropping a MIDI file, if {% include shortcut.html content="Shift" %} is held, the tracks are put in sequence instead of in parallel.

Velocity of MIDI notes can now be changed with {% include shortcut.html content="Shift+Click" %} - the more saturated the note, the higher the velocity.
