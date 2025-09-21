---
layout: default

title: MIDI File Reader
description: "Timeline-synchronized MIDI file playback"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-file-reader.html
---
# MIDI File Reader

![MIDI File Reader]({{ site.img }}/reference/processes/midi-file-reader.png "MIDI File Reader")

Play MIDI files in perfect sync with your score's timeline. This process loads standard MIDI files and plays them back with sample-accurate timing, automatically following tempo changes and providing track selection.

Perfect for incorporating existing MIDI compositions into your scores, backing tracks for live performance, or using MIDI files as control data sources for other processes.

## How it works

MIDI File Reader loads a MIDI file and plays it back in sync with *score*'s musical timeline. It automatically handles tempo conversions and provides clean note-off messages when files change.

**MIDI file** - Load any standard MIDI file (.mid/.midi)  
The process automatically monitors the file for changes, so you can edit MIDI files in external software and hear updates immediately.

**MIDI track** (1-127, default 1) - Select which track to play  
Most MIDI files contain multiple tracks - drums on track 10, different instruments on other tracks. Choose the track you want to hear.

The output is a clean MIDI stream that can feed into synthesizers, [[MIDI utilities]], or other MIDI-processing tools.

## Key features

**Timeline sync**: Playback follows *score*'s musical position exactly - pause, scrub, or loop and the MIDI stays in sync.

**File monitoring**: Edit your MIDI file in your DAW while *score* is running - changes appear immediately without reloading.

**Clean transitions**: When switching files or tracks, hanging notes are automatically stopped to prevent stuck notes.

**Tempo handling**: Respects the MIDI file's tempo information and converts it to *score*'s timeline.

## Creative applications

**Backing tracks**: Use MIDI file backing tracks that sync perfectly with your live audio and video elements.

**Control sequences**: Use MIDI files as complex control data - convert note patterns into parameter automation using [[MIDI Filter]].

**Multi-track playback**: Use multiple MIDI File Readers to play different tracks from the same file, each feeding different synthesizers or processes.

**Interactive arrangements**: Switch between different MIDI tracks based on user input or system state for dynamic arrangements.

**Template integration**: Import MIDI drum patterns, bass lines, or chord progressions as starting points for new compositions.

## Technical details

The process uses the MIDI file's "ticks per beat" information to calculate sample-accurate timing. It maintains a running list of active notes to ensure clean note-off messages when files change or tracks switch.

File watching works on most filesystems - save your MIDI file in Logic, Live, or any other DAW and hear the changes in *score* immediately.

Perfect for feeding into software synthesizers, [[MIDI utilities]] for message processing, or [[MIDI Filter]] for extracting specific control data from musical sequences.

## Related processes

Chain with [[MIDI utilities]] for note processing, use [[MIDI Filter]] to extract control data, or combine with software synthesizers for complete MIDI playback systems. Works great with [[Audio Effects]] on the synthesized output.