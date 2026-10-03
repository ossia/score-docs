---
layout: default

title: MIDI display
description: "Monitor MIDI messages and note lifetimes"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-display.html
---

# MIDI display

**MIDI display**, in **Monitoring**, shows the messages reaching a MIDI port as a
scrolling note display and message log. It is available in current development
builds. Use it to diagnose missing releases, unexpected retriggers and message
routing without replacing the receiving instrument.

## Ports and controls

* **in**: MIDI input. Fan out a source's MIDI outlet to both the instrument and
  this input to monitor the same stream.
* **Window**: visible history length, expressed in seconds or a synchronized
  musical duration with the time chooser.
* **events**: value output used by the display, not a MIDI-through outlet.

The process has no MIDI output: keep the original source-to-instrument connection.
It must execute to collect messages.

## Reading the display

The display distinguishes released notes, currently held notes, retriggers and
unmatched note-offs. A note held for more than two seconds without a release is
flagged as potentially stuck. A deliberately sustained note can trigger this
warning too; it is a diagnostic threshold, not proof that the source is broken.

Use **Copy MIDI log** in the context menu to copy the visible log, or **Clear MIDI
log** to reset the display. The monitor keeps bounded recent history rather than
an archival capture of the full session. Heavy message bursts or long UI stalls
can exceed this history. It displays message status and the first data bytes,
not a complete SysEx payload inspector.

For note-on-zero interpretation at a device boundary, see
[MIDI input device]({{ site.baseurl }}/devices/midiin-device.html). For extraction
into control values, use [MIDI Filter]({{ site.baseurl }}/processes/midi-filter.html).
