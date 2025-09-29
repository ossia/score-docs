---
layout: default

title: Musical metrics
description: "How to use the musical features of ossia score"

parent: In depth

permalink: /in-depth/musical.html
---

# Musical metrics

Processes and elements of a score can be quantized on musical metrics, and have independent
tempo curves, & time signatures.

Musical metrics are propagated hierarchically:
  * The tempo, and musical position in an interval is either relative to this interval
    (if the 4/4 button in the inspector is pressed)
    or it's taking the musical information from its closest parent (recursively).
  * Processes take the quantization and metrics information from their parent.

This means that polyrhythmic scores are possible: the root can be in 4/4 with a child interval in 3/4, 7/8.

There are three "musical" controls available: time signatures, tempo curves, and quantization.

# Musical signatures
They are set on intervals and are used to delimit the start and end of bars, for quantization purposes.
To change the musical signatures, go into an interval in full view and mark the interval as having
its own metrics in the inspector if it does not already have some.

# Quantization
The quantization setting on an interval allows to say at which musical interval
child elements will be triggered if they rely on hierarchy for synchronization.

For instance, if the quantization setting is set at one bar, it means that
the event will be processed at the start of the next bar.

Most places that can be quantized thus have a choice of quantization intervals (bars, quarter notes, ...),
plus the *Parent* (uses the parent quantization setting, recursively) and *Free* (no quantization, things start directly)
settings.

# Tempo
Likewise, by default the tempo is the global one. Intervals support tempo curves,
which can give them a different speed behaviour.
The interval's children will all take this tempo unless another more precise tempo is
given at a deeper nesting level by adding a tempo process to the interval.

# Usage
- Processes which are able to use tempo & metrics information (audio plug-ins, LFO, arpeggiator, etc) will do so automatically.
- Triggers and intervals can be quantified to fall on the next quantification date from when they are triggered.

<!--
# Timing
How timing works in ossia score.

- Quantification
- Model time
- Physical time
-->