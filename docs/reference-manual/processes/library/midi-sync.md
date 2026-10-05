---
layout: default

title: MIDI Sync Out
description: "Send MIDI clock, transport messages and timecode"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-sync.html
---

# MIDI Sync Out

**MIDI Sync Out**, in **Timing/Midi**, sends synchronization from an executing
score interval to external MIDI equipment.

## Setup

1. Add a [MIDI output device]({{ site.baseurl }}/devices/midiout-device.html).
2. Add MIDI Sync Out to the interval whose tempo/time should drive the receiver.
3. Assign **MIDI output** to that device. The process resolves the addressed MIDI
   device stream directly; an ordinary cable to a MIDI-processing node is not a
   substitute for this device assignment.
4. Enable the message families the receiving hardware expects, and configure the
   receiver to follow that external clock or timecode.

## Controls

| Input | Purpose |
| --- | --- |
| **MIDI Clock** | Enable the 24-pulses-per-quarter-note clock derived from the interval tempo |
| **MIDI Start/Stop** | Enable MIDI transport messages |
| **MIDI TimeCode** | Enable MIDI timecode (MTC) |
| **MTC offset (s)** | Add an offset in seconds to the transmitted time |
| **MTC rate** | Select the displayed 24, 25, 29.97 or 30 fps mode |

Clock expresses musical tempo; MTC expresses a time position. They are different
protocols, so enabling both is only useful when the receiver understands both.
The output controls start disabled until enabled by the user.

## Limitations

This process sends synchronization; it does not make score a slave to an external
transport. Use [MIDI Sync In]({{ site.baseurl }}/processes/midi-timecode-input.html)
to extract incoming timing values. MIDI transmission and receiver behavior add
latency and jitter; test the actual devices rather than assuming sample-accurate
lock. The current explicit seek/transport callback does not send a relocation
message, so verify seeking and restart behavior with the receiver.

In the current implementation the displayed 29.97/30 choices use the opposite
numerical rates for frame calculation; use 24 or 25 fps when possible, and do not
rely on the two higher-rate modes for frame-accurate synchronization.
