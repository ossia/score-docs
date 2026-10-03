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

At interval level, the musical controls are time signatures, tempo curves and quantization. Individual processes can also expose their own timing controls.

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
- Processes which use tempo and metrics information (audio plug-ins, LFO, arpeggiator, etc.) receive that information from their interval. Whether a particular parameter follows tempo depends on its synchronization mode.
- Triggers and intervals can be quantified to fall on the next quantification date from when they are triggered.

## Process durations and the time chooser

Current development-build processes use the [Time Chooser]({{ site.baseurl }}/reference/time-chooser.html) for parameters that can be free durations or musical note values. Click the readout beneath the knob to cycle **free → straight → dotted → triplet**. Free durations do not follow tempo; note values do.

This control is distinct from an interval's **Parent** or **Free** quantization setting:

| Kind of timing | Example | What is synchronized? |
|---|---|---|
| Event quantization | Trigger quantized to a bar | When an event is allowed to happen. |
| Process grid | [Free Metronome]({{ site.baseurl }}/processes/metronome.html), [Midi Quantify]({{ site.baseurl }}/processes/midi-quantify.html) | Impulses or note starts are placed on a process's selected grid. |
| Stage duration | [[ADSR]] Attack or Release | How long a stage takes after it starts; the trigger itself is not moved onto a beat. |
| Cycle duration | [[LFO]] Period | How long an oscillation takes. Enable **Lock to bars** for synchronized cycles aligned to musical position. |
| Quiet-time duration | [[Rate Limiter]] in Debounce mode | How long to wait after the last input; even a synchronized duration does not make its output grid-aligned. |

Note fractions refer to a **whole note**, not the current bar. `1/4` is a quarter note and `1/1` is four quarter notes. Thus `1/1` matches a bar in 4/4 but not a bar in 3/4. At 120 BPM a quarter note lasts 0.5 seconds; changing tempo changes synchronized durations accordingly.

For a rhythmic control pattern, give the parent interval its intended metrics, select `1/8` on Free Metronome's Period, and connect its output to ADSR's Trigger. The metronome determines the grid; ADSR's Attack and Decay determine the shape and length after each trigger.

Older saved variants may still expose a frequency, millisecond or quantification selector instead of a time chooser. They remain distinct process types, not an automatic migration to the newer controls. Consult each process page before transferring settings.

<!--
# Timing
How timing works in ossia score.

- Quantification
- Model time
- Physical time
-->