---
layout: default

title: MIDI File Scroller
description: "Manual scrubbing through MIDI file content"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-file-scroller.html
---
# MIDI File Scroller

![MIDI File Scroller]({{ site.img }}/reference/processes/midi-file-scroller.png "MIDI File Scroller")

Scrub through MIDI files manually with position control. Instead of playing back MIDI files in real-time, MIDI File Scroller lets you "seek" to any position and hear exactly what notes would be playing at that moment.

Perfect for exploring MIDI file content, creating position-based interactions, or building systems where MIDI playback is controlled by sensors, gestures, or other continuous input.

## How it works

MIDI File Scroller loads a MIDI file and maps its entire timeline to a 0-1 position control. Move the position parameter and hear the MIDI notes that should be active at that point in the file.

**MIDI file** - Load any standard MIDI file (.mid/.midi)  
The process monitors for file changes, so you can edit externally and see updates immediately.

**MIDI track** (1-127, default 1) - Select which track to scrub through  
Choose different tracks to explore different instruments or parts.

**Position** (0.0-1.0) - Manual position control through the file  
0.0 = beginning of file, 1.0 = end of file. This parameter can be automated, controlled by sensors, or manipulated in real-time.

## Key features

**Instant seeking**: Jump to any position in the MIDI file immediately - no waiting for playback to catch up.

**Note duration mapping**: The process understands note lengths and maintains proper note-on/off states as you scrub through.

**Smooth transitions**: Moving the position slider creates clean note transitions without stuck or overlapping notes.

**File monitoring**: Edit your MIDI file in external software and changes appear immediately.

## Creative applications

**Interactive exploration**: Let users explore musical compositions by moving sliders, sensors, or controllers - each position reveals different musical content.

**Gesture-based playback**: Map body tracking, camera input, or sensor data to MIDI file position for expressive, non-linear musical experiences.

**Visual synchronization**: Synchronize MIDI content with video scrubbing, image sequences, or other position-based media.

**Composition analysis**: Study complex MIDI compositions by slowly scrubbing through sections to understand harmonic progressions and voice leading.

**Performance control**: Use as a "tape head" that can be positioned anywhere in a musical sequence for live performance manipulation.

## Integration techniques

**Sensor control**: Map the position parameter to sensor data - use distance sensors, light levels, or motion tracking to control playback position.

**Video synchronization**: Link MIDI file position to video scrubbing for synchronized audiovisual experiences.

**Multi-file systems**: Use multiple MIDI File Scrollers to scrub through different files or tracks simultaneously.

**Automation curves**: Draw automation curves for the position parameter to create custom, non-linear playback sequences.

## Technical details

The process uses interval mapping to efficiently track which notes should be active at any position. It maintains proper MIDI state, ensuring clean note-on/off messages as you move through the file.

The position mapping is linear - equal position changes create equal time movement through the file, regardless of tempo changes within the MIDI file.

Works perfectly with [[MIDI Filter]] to extract specific types of data, [[MIDI utilities]] for processing the output, or software synthesizers for audio generation.

## Related processes

Chain with [[MIDI utilities]] for note processing, use [[MIDI Filter]] to extract control data, or combine with [[Mapping Tool]] to shape the position control response for more musical scrubbing behavior.