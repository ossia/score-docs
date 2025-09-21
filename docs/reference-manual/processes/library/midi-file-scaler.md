---
layout: default

title: MIDI File Scaler
description: "Microtonal MIDI scaling with Scala support"

parent: Processes
grand_parent: Reference

permalink: /processes/midi-file-scaler.html
---
# MIDI File Scaler

![MIDI File Scaler]({{ site.img }}/reference/processes/midi-file-scaler.png "MIDI File Scaler")

Transform MIDI notes into microtonal frequencies using Scala tuning files. This process converts standard MIDI note numbers into precise frequency values based on custom scales and keyboard mappings.

Essential for microtonal music, historical temperaments, just intonation, or any musical system that goes beyond 12-tone equal temperament.

## How it works

MIDI File Scaler takes incoming MIDI notes and converts them to frequency values based on Scala (.scl) tuning files and optional keyboard mapping (.kbm) files. Instead of outputting MIDI, it produces arrays of frequencies for active notes.

**MIDI messages** - Input MIDI data from keyboards, files, or other sources

**SCL file** - Scala tuning file (.scl) defining your custom scale  
These files contain mathematical ratios or cent values that define each scale degree. Thousands of historical and experimental scales are available from the Scala archive.

**KBM file** - Keyboard mapping file (.kbm) for advanced tuning control  
Maps which scale degrees appear on which MIDI keys, allowing complex retuning schemes.

**Frequency adjust** (-500 to +500 cents) - Fine-tuning offset for the entire scale

**Frequency scale** (0.5x to 2.0x) - Global frequency scaling for transposition

## Understanding Scala files

**SCL files** define scales as mathematical relationships:
```
! major_just.scl
Just Major Scale
 7
!
 9/8
 5/4
 4/3
 3/2
 5/3
 15/8
 2/1
```

**KBM files** define keyboard mappings:
```
! Map C major to white keys only
 12
 0
 7
 1
 60
 1 2 3 4 5 6 7 8 9 10 11 12
```

These files can be found in the Scala software archive or created with tuning software.

## Creative applications

**Just intonation**: Use mathematically pure intervals for harmonically rich music that's impossible with equal temperament.

**Historical temperaments**: Recreate Baroque, Renaissance, or other historical tuning systems for authentic period performance.

**Ethnic scales**: Implement traditional scales from different cultures that don't fit 12-tone systems.

**Experimental microtonality**: Design custom scales for unique harmonic exploration.

**Frequency-based synthesis**: Feed the frequency outputs to oscillators that can accept frequency control rather than MIDI.

## Integration with score

The frequency array output is perfect for controlling oscillators that accept frequency input rather than MIDI. This is common in:

- **[[Faust]] synthesizers** that use frequency parameters
- **Software synthesizers** with frequency modulation inputs  
- **Custom audio processes** that work with frequency arrays
- **Granular synthesis** systems that can retune grains

## Technical details

Built on the Surge Synthesizer's tuning library for precise, professional-grade microtonal processing. The system handles note-on/off tracking, interpolated tunings for missing scale degrees, and proper frequency calculation for real-time performance.

When using both SCL and KBM files together, the system validates compatibility and provides error handling for mismatched configurations.

## Workflow tips

**Start simple**: Begin with basic just intonation scales before exploring complex microtonal systems.

**Test with familiar music**: Apply new tunings to melodies you know well to hear the differences clearly.

**Scale libraries**: Build a collection of interesting SCL files for different musical projects.

**Frequency visualization**: Use tools to visualize the frequency relationships in your custom scales.

## Related processes

Perfect for use with [[Faust]] processes that accept frequency control, frequency-based synthesis systems, or any process that benefits from precise frequency relationships rather than tempered MIDI notes.