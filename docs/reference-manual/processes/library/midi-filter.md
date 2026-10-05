---
layout: default

title: MIDI Filter
description: "Advanced MIDI message filtering and extraction"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-filter.html
---
# MIDI Filter


MIDI Filter extracts messages from a MIDI stream and converts their contents into
values for controls. Connect a MIDI source to **MIDI messages**, then use either
the MIDI outlet or the value outlets below. It does not synthesize audio.

## Controls

| Control | Meaning |
| --- | --- |
| **Filter type** | CC, PitchBend, AfterTouch, PolyPressure, NoteOn, NoteOff, NoteAny or NoteRunning |
| **Channel** | 0 processes all channels; see the current limitation below before using a nonzero value |
| **Index** | 0 accepts all indices; a nonzero value matches the actual CC/note number, not a one-based offset |
| **Mode** | Index, Value or Both for the extracted data |
| **Zero to note off** | Interpret zero-velocity note-ons as releases for filtering and held-note tracking |
| **Note off to zero** | In NoteRunning mode, include zero-valued release data in the value outputs |

**Channel limitation:** the implementation's nonzero Channel
test skips the selected channel rather than isolating it. Use Channel 0 when
inspecting a stream, and do not rely on this control for selected-channel-only
routing. The running-note collection is indexed by pitch rather than by
channel/pitch, so identical pitches from multiple channels are not tracked
independently.

Because Index 0 means “all”, this control cannot isolate only CC 0 or note 0.

## Outputs

* **MIDI messages**: the matching original messages.
* **Raw Output**: integer data or a note/index and value pair, depending on Mode.
* **Normalized value**: a floating-point value, or a note/index paired with a
  normalized value. Note velocity and CC values use the 0–1 range.
* **Raw poly output**: a list of held notes, velocities, or note/velocity pairs.

The note-zero toggles affect interpretation and extracted values; they are not
a general MIDI-message rewriting stage. In particular, **Note off to zero** does
not replace the MIDI outlet's note-off bytes with a note-on message. Use the
[MIDI output device]({{ site.baseurl }}/devices/midiout-device.html) policy when
the receiving hardware requires that wire representation.

## Example workflows

For a CC control, use **CC**, **Channel 0**, **Index 74** and **Mode Value**.
Cable **Normalized value** to a suitable parameter or a mapping process.

For a single-channel chord stream, use **NoteRunning** and **Mode Both** to obtain
held note/velocity pairs. Enable **Zero to note off** if the source encodes
releases as note-ons with velocity zero. Stop or restart the source carefully:
the filter can only release notes whose release messages reach it.

See also [MIDI utilities]({{ site.baseurl }}/processes/midi-utilities.html) and
[Piano roll]({{ site.baseurl }}/processes/piano-roll.html).
To inspect the original message stream alongside a filter, branch it to
[MIDI display]({{ site.baseurl }}/processes/midi-display.html).
