---
layout: default

title: Patternal
description: "Rhythmic pattern to MIDI converter"

parent: Processes
grand_parent: Reference

permalink: /processes/patternal.html
---
# Patternal

![Patternal]({{ site.img }}/reference/processes/patternal.png "Patternal")

Turn rhythmic patterns into MIDI drums and percussion. Feed it arrays of velocities and it spits out perfectly timed MIDI notes - think of it as your digital drum machine that synchronizes to *score*'s musical timing.

Perfect for drum programming, rhythmic experimentation, or any situation where you want to convert pattern data into MIDI percussion tracks.

## How it works

Patternal takes pattern arrays where each pattern represents one drum sound (MIDI note) and a sequence of velocity values representing the rhythm. When it plays, each step in the pattern triggers at the right musical timing.

**Pattern input** - Arrays of `[note_number, [velocity, velocity, velocity...]]`
**Musical sync** - Automatically quantizes to musical timing
**MIDI output** - Note-on/note-off messages sent to MIDI bus
**Multiple drums** - Handle several drum sounds simultaneously

## Pattern format

Each pattern is a simple array with a MIDI note number and velocity sequence:

```json
[
  [36, [127, 0, 0, 0]],    // Kick drum: hit on beat 1
  [38, [0, 0, 64, 0]],     // Snare: hit on beat 3  
  [42, [32, 0, 32, 0]]     // Hi-hat: hits on beats 1 and 3
]
```

**Note numbers**: Standard MIDI drum map (36 = kick, 38 = snare, 42 = hi-hat, etc.)  
**Velocities**: 0-127 where 0 = silent, 127 = maximum volume  
**Pattern length**: Can be any length - 4 steps, 8 steps, 16 steps, whatever you need

A simple example of script that generates patterns in the required format is available: the `claves` Javascript preset.
It showcases how one can use the Total Serialism library shipped with score to support generation of stochastic rhythms.

![claves]({{ site.img }}/reference/processes/patternal/claves.png)

## Creative applications

**Drum programming**: Create classic drum patterns - four-on-the-floor, breakbeats, latin rhythms, or experimental polyrhythms.

**Algorithmic composition**: Generate patterns procedurally and feed them to Patternal for instant rhythmic results.

**Live performance**: Change patterns in real-time during performances for dynamic drum arrangement.

**Polyrhythmic experiments**: Use different pattern lengths for different drums to create complex interlocking rhythms.

**Pattern sequencing**: Combine with [[Scenario]] to switch between different pattern sets over time.

## Musical timing and sync

Patternal automatically synchronizes to *score*'s musical timing system, which means:

**Tempo sync**: Pattern playback follows the project tempo - change the BPM and patterns speed up or slow down accordingly.

**Quantization**: Pattern steps align perfectly to musical timing.

**Frame-accurate**: MIDI messages are generated at precisely the right sample to maintain tight timing.

## Integration with score

Works seamlessly with *score*'s MIDI system - connect the output to [[MIDI]] devices, software synthesizers, or other MIDI processes.

**MIDI routing**: Connect to any MIDI device or application that receives MIDI input.

**Effect processing**: Send the generated patterns through various MIDI Effects for additional processing.

**Multiple instances**: Run several Patternal processes for different drum kits or layered rhythmic elements.

## Advanced techniques

**Variable pattern lengths**: Mix 4-step kicks with 3-step hi-hats for interesting polyrhythmic effects.

**Velocity programming**: Use different velocity levels to create realistic drum dynamics and accents.

**Ghost notes**: Add subtle low-velocity hits between main beats for more human-like drum patterns.

**Pattern morphing**: Gradually change pattern arrays to create smooth transitions between different rhythmic feels.

## Related processes

Patternal pairs perfectly with [[Melodial]] for complete drum and melody programming, works alongside [[MIDI]] devices for output routing, and integrates with [[Automation]] for dynamic pattern changes over time.
