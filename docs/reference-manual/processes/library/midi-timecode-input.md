---
layout: default

title: MIDI Sync In
description: "Extract timecode, tempo and position from incoming MIDI synchronization"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-timecode-input.html
---

# MIDI Sync In

**MIDI Sync In**, in **Timing/Midi**, decodes incoming MIDI Time Code (full-frame
and quarter-frame messages) and MIDI clock into control values.

Assign a [MIDI input device]({{ site.baseurl }}/devices/midiin-device.html) to
**MIDI in**, or cable a MIDI source to it. Keep the containing interval executing
while receiving messages. Connect the resulting values to the controls or
synchronization logic that should follow the source.

## Inputs

| Control | Purpose |
| --- | --- |
| **Sync Mode** | MTC only, clock only, or MTC with clock interpolation |
| **Offset (seconds)** | Offset the decoded time |
| **Output Format** | Seconds, milliseconds, microseconds, nanoseconds or flicks |
| **Framerate** | Auto, 24, 25, 29.97 or 30 fps |
| **Base Tempo** | Starting tempo for clock-derived timing before estimation stabilizes |
| **Clock filter** | Smoothing for the clock-based tempo estimate |
| **Song Position** | Initial MIDI song-position value, in sixteenth notes |

## Outputs

* **Timecode**: position in the selected Output Format.
* **Tempo**: estimated clock tempo.
* **Song Position**: MIDI song-position value.
* **Valid**: whether the process has a valid timing result.
* **Frame Rate**, **MTC Active**, **Clock Active**: status of the decoded timing source.

Use the status outputs to decide whether downstream logic should follow the
position. A MIDI clock stream alone does not convey SMPTE timecode: clock-only
position is derived from tempo, transport messages and song position.

Adding this process does **not** automatically slave score's global transport,
start playback or select a master clock. It produces values for an explicitly
constructed synchronization workflow. For sending score's timing to equipment,
see [MIDI Sync Out]({{ site.baseurl }}/processes/midi-sync.html).
