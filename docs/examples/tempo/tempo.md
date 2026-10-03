---
layout: default

title: Tempo Examples
description: "Examples demonstrating tempo and timing features in ossia score"

parent: Examples
has_children: true

permalink: /examples/tempo
---

# Tempo Examples

These examples demonstrate tempo control, time stretching, and musical timing in ossia score.

Start with [Tempo manipulation]({{ site.baseurl }}/examples/tempo/tempo-control.html) for a timeline-oriented example.

The [Tempo process]({{ site.baseurl }}/processes/tempo.html) controls musical speed. [Free Metronome]({{ site.baseurl }}/processes/metronome.html) generates timed impulses; it is not an external transport synchronizer. For each timing tool, check whether its time control follows musical divisions or an absolute duration rather than assuming that every value is in milliseconds.

For external equipment, see [MIDI Sync Out]({{ site.baseurl }}/processes/midi-sync.html) to send synchronization, [MIDI Sync In]({{ site.baseurl }}/processes/midi-timecode-input.html) to decode it, and [Timecode Synchronizer]({{ site.baseurl }}/processes/timecode-synchronizer.html) to follow a time position. These references explain distinct processes, not additional downloadable examples.
