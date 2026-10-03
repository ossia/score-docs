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

Hold {% include shortcut.html content="Shift" %} while dragging a note to change
its velocity; stronger saturation indicates higher velocity.

## Selection and transposition

Select notes by clicking or drawing a selection rectangle. Hold
{% include shortcut.html content="Ctrl" %} when clicking to retain other selected
notes. With the piano roll focused, {% include shortcut.html content="Up" %} and
{% include shortcut.html content="Down" %} transpose selected notes by a semitone;
{% include shortcut.html content="Shift+Up" %} and
{% include shortcut.html content="Shift+Down" %} transpose by an octave.
Transposition remains within MIDI's 0–127 pitch range. In current development
builds, moving notes beyond the displayed pitch range expands that range.

Connect **MIDI Out** to an instrument process or a
[MIDI output device]({{ site.baseurl }}/devices/midiout-device.html). The piano roll
generates note messages, not audio.
