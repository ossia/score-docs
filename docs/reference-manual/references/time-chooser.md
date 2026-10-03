---
layout: default

title: Time Chooser
description: "Choose free durations or tempo-synchronized note values"

parent: Reference

permalink: /reference/time-chooser.html
---
# Time Chooser

The time chooser combines a duration knob with a clickable readout underneath it. It is used by current development-build processes such as [[LFO]], [[Rate Limiter]] and [[ADSR]]. Older saved process variants may still have separate frequency, millisecond or quantification controls.

## Free time and musical time

Click the readout to cycle through **free time → straight notes → dotted notes → triplets → free time**. Rapid successive clicks also advance the mode; clicking the readout is not a reset.

- **Free time:** drag the knob to choose a duration independent of tempo. The readout uses milliseconds for short durations and seconds for longer ones. Right-click to enter a number: **numeric entry is in seconds**, even when the readout shows `ms`. For example, enter `0.01` for 10 ms.
- **Straight notes:** drag through note values such as `1/8` and `1/4`.
- **Dotted notes:** the suffix `.` means one and a half times the straight duration; `1/8.` is a dotted eighth note.
- **Triplets:** the suffix `T` means two thirds of the straight duration; `1/8T` is an eighth-note triplet.

In musical modes, dragging normally stays within the selected feel. Hold **Alt** or **Shift** while dragging to access all division detents, including the other feels. Turn towards larger durations for longer notes. Numeric right-click entry is available only in free mode; choose musical divisions with the knob.

Available straight divisions run from `1/64` to `4/1`; dotted divisions from `1/32.` to `2/1.`; triplets from `1/32T` to `1/1T`. Values are fractions of a **whole note**, not fractions of the current bar: `1/1` lasts four quarter notes, which is one bar only in 4/4. At 120 BPM, `1/4` is 0.5 seconds and `1/8` is 0.25 seconds.

## Defaults and resetting

The chooser remembers separate free and synchronized positions while switching modes. Cycling from free time enters straight-note mode; cycling through the other feels keeps the underlying note length where that division exists, otherwise choosing the nearest available division.

Double-click the **knob**, rather than its readout, to reset:

- In free mode, reset to that parameter's default duration.
- In synchronized mode, reset to straight `1/8`.

The initial synchronized selection is `1/8`; the free range and default are defined by each process. New time-chooser controls start in free mode unless a preset or saved value selects synchronization. Most use a response curve with extra travel for short durations.

## Synchronization is process-specific

A synchronized value follows the current tempo, but that does not always mean starting on a beat. A metronome can place events on a musical grid; an envelope uses the note value as the **length of a stage after its trigger**. Likewise, a synchronized debounce interval is a waiting duration after the last input, not a scheduled grid point. See each process for its timing behavior and limits.

Legacy process types remain loadable with their own controls. Opening an older score does not replace those types with the new time-chooser versions. To adopt a newer variant, insert the current process and explicitly re-create its settings and connections; do not assume old frequency or millisecond numbers have the same units as a duration.
