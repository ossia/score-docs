---
layout: default

title: Free Metronome
description: "Periodic control impulses in seconds or on a musical grid"

parent: Processes
grand_parent: Reference

permalink: /processes/metronome.html
---
# Free Metronome

The **Free metronome** process produces periodic impulses at its **out** control port. Connect it to a trigger input, for example on [[ADSR]], to repeat an action without drawing each event on the timeline. It produces control impulses, not an audible click.

This page describes version 2. The name distinguishes it from metronomes that follow the parent interval's quantization settings; its own Period can still synchronize to tempo.

## Period

**Period** is the time between impulses: free range **0.001–60 seconds**, default **0.25 seconds**. A smaller value produces more frequent impulses; it is not a frequency in hertz.

Use the [time chooser]({{ site.baseurl }}/reference/time-chooser.html) to choose either:

- **Free time:** evenly spaced impulses measured in samples from the playback origin, independent of tempo.
- **Synchronized time:** impulses on the selected straight, dotted or triplet grid, aligned to the timeline's musical position. For example, `1/4` ticks once per quarter note.

The process runs while its interval executes. It emits no ticks when musical time is not advancing. It can emit multiple impulses within one audio buffer when the period calls for them.

## Older saved processes

**Free metronome (old)** remains registered with its earlier controls and identity. Loading an older score does not replace it with v2. Add a current Free metronome and reconnect its output when you want the new Period chooser.

For the other metronome processes, see [Control Utilities]({{ site.baseurl }}/processes/control-utilities.html).
