---
layout: default

title: MIDI Filter
description: "Advanced MIDI message filtering and extraction"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-filter.html
---
# MIDI Filter

![MIDI Filter]({{ site.img }}/reference/processes/midi-filter.png "MIDI Filter")

Extract exactly the [[MIDI support|MIDI]] data you need from complex MIDI streams. This process acts like a precision tool for filtering, converting, and organizing MIDI messages, with multiple output formats and polyphonic note tracking.

Essential when you're dealing with multi-channel MIDI keyboards, complex controllers, or when you need to convert MIDI data into control signals for other processes.

## How it works

MIDI Filter examines incoming MIDI messages and extracts specific types of data based on your filter settings. It can track running notes, convert between formats, and output data in several different ways simultaneously.

**Filter type** - What kind of MIDI messages to extract:
- **CC**: Control Change messages (knobs, faders, mod wheels)
- **PitchBend**: Pitch bend wheel data
- **AfterTouch**: Channel pressure (mono aftertouch)
- **PolyPressure**: Polyphonic aftertouch (per-note pressure)
- **NoteOn**: Note-on messages only
- **NoteOff**: Note-off messages only  
- **NoteAny**: Both note-on and note-off
- **NoteRunning**: Currently held notes (polyphonic state)

**Channel** (0-16) - Filter by MIDI channel (0 = all channels)

**Index** (0-128) - Filter by parameter number (0 = all, 1-128 for specific CC numbers, note numbers, etc.)

**Mode** - What data to output:
- **Index**: Output the parameter number (which CC, which note)
- **Value**: Output the parameter value (CC value, velocity, etc.)
- **Both**: Output both index and value

**Note off to zero** - Convert note-off messages to zero velocity note-ons (useful for some synths)

## Multiple output formats

MIDI Filter provides several outputs simultaneously:

**Filtered MIDI** - Clean MIDI stream with only your selected message types
**Raw output** - Integer values or note structures  
**Normalized output** - Floating-point values scaled 0-1
**Polyphonic output** - Arrays of all currently active notes (perfect for chord analysis)

## Practical uses

**CC extraction**: Set Filter to "CC", Channel to 1, Index to 74 to extract filter cutoff from a specific synthesizer channel.

**Polyphonic analysis**: Use "NoteRunning" mode to get arrays of all currently held notes - perfect for chord recognition or harmony analysis.

**Multi-channel routing**: Filter by channel to separate different instruments from a single MIDI stream.

**Velocity to control**: Extract note velocities and convert to 0-1 range for controlling audio effects intensity.

**Aftertouch control**: Use "AfterTouch" or "PolyPressure" to control parameters based on key pressure.

## Advanced techniques

**Chord detection**: Use NoteRunning mode with the polyphonic output to analyze chord progressions in real-time.

**Multi-parameter control**: Run multiple MIDI Filters in parallel to extract different CC numbers for controlling different aspects of your score.

**Format conversion**: Use this to convert between MIDI note formats and control signals - great for using keyboards to control non-musical parameters.

Chain multiple filters with different settings to create complex MIDI processing workflows, or combine with [[Mapping Tool]] to shape the extracted data for perfect parameter control.

## Related processes

Works great with [[MIDI utilities]], [[Mapping Tool]] for parameter shaping, [[Calibrator]] for response curves, or [[Mapping Curve]] for simple scaling. Combine with [[Audio Effects]] that respond to MIDI data.
