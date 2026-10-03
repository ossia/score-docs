---
layout: default
title: "MIDI Humanize"
description: "Vary MIDI note timing, dynamics, duration and pitch"
parent: Processes
grand_parent: Reference
permalink: /processes/midi-humanize.html
---

# MIDI Humanize

MIDI Humanize processes a **MIDI** input into a **MIDI** output with controlled variation. Insert it between a sequencer and an instrument.

Timing controls use the shared [Time Chooser]({{ site.baseurl }}/reference/time-chooser.html).

- **Timing** sets the timing deviation. **Colour** chooses uncorrelated white noise (0), correlated 1/f variation (1), or Brownian drift (2).
- **Early** permits apparently early deviations by adding a real baseline delay of `Early × 3 × Timing`. It cannot send notes before they arrive.
- **Velocity** controls velocity deviation; **Vel. range** bounds resulting velocities.
- **Length** varies durations. Shortening is limited by available lookahead because duration is only known when note-off arrives.
- **Chance** is the probability of playing a note. **Pitch** adds random transposition in semitones; note-offs follow the transposed note.
- **Chord** groups nearby notes under one timing deviation. **Spread** adds delay between successive chord notes for a strum.
- **Channel** (0 means all) and **Key range** restrict affected notes.
- **Seed** 0 runs freely. A nonzero seed makes a reproducible take and resets its random sequence when transport rewinds.

Timing, Chord and Spread use time choosers. Begin with small deviations and Early at zero when live latency matters. Use a nonzero Seed when comparing repeated renders or rehearsing a fixed variation.
