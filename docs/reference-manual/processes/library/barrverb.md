---
layout: default

title: BarrVerb
description: "Vintage-inspired reverb based on Alesis MIDIVerb"

parent: Processes
grand_parent: Reference

permalink: /processes/barrverb.html
---
# BarrVerb

![BarrVerb]({{ site.img }}/reference/processes/barrverb.png "BarrVerb Reverb Effect")

BarrVerb is a vintage-inspired digital reverb effect based on the classic Alesis MIDIVerb algorithms. It recreates the distinctive sound of 1980s digital reverbs, perfect for retro aesthetics, creative sound design, and adding character to modern productions.

## Overview

BarrVerb provides:
- Authentic vintage digital reverb algorithms
- Multiple reverb types and settings
- Real-time parameter control
- CPU-efficient implementation
- Classic 1980s digital reverb character

Based on the open-source [BarrVerb project](https://github.com/ErroneousBosh/BarrVerb), which recreates the algorithms from the legendary Alesis MIDIVerb series.

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Audio In | Audio | Input audio signal |
| Dry/Wet | Float (0-1) | Balance between dry and reverb signal |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Audio Out | Audio | Processed audio with reverb |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Program | Dropdown | Reverb algorithm/preset | "Hall 1" | See Programs |
| Decay | Knob | Reverb decay time | 0.5 | 0.0-1.0 |
| Mix | Knob | Dry/wet balance | 0.3 | 0.0-1.0 |
| High Cut | Knob | High frequency damping | 0.7 | 0.0-1.0 |
| Low Cut | Knob | Low frequency damping | 0.0 | 0.0-1.0 |
| Input Gain | Knob | Input level adjustment | 1.0 | 0.0-2.0 |

## Reverb Programs

BarrVerb includes multiple classic reverb algorithms:

### Hall Reverbs
- **Hall 1**: Large concert hall simulation
- **Hall 2**: Warm, musical hall space
- **Hall 3**: Bright, spacious hall

### Plate Reverbs  
- **Plate 1**: Classic steel plate reverb
- **Plate 2**: Warm plate with extended decay
- **Plate 3**: Bright, percussive plate sound

### Room Reverbs
- **Room 1**: Small acoustic room
- **Room 2**: Medium live room
- **Room 3**: Large ambient room

### Special Effects
- **Reverse**: Reverse reverb effect
- **Gate**: Gated reverb (classic 80s sound)
- **Chorus**: Reverb with built-in chorus

## Vintage Character

### Authentic Sound
BarrVerb recreates the distinctive qualities of 1980s digital reverbs:
- **Bit-Crushed Character**: 12-bit ADC/DAC emulation
- **Aliasing Artifacts**: Authentic digital artifacts
- **Classic Algorithms**: Original delay line structures
- **Period-Correct Filtering**: Vintage filter responses

### Creative Applications
The vintage character makes BarrVerb perfect for:
- Synthwave and retro productions
- Lo-fi and nostalgic soundscapes
- Creative sound design
- Adding character to clean digital sounds

## Usage Examples

### Retro Drum Processing

Add classic 80s reverb to drums:

```
[Drum Kit] → [BarrVerb] → [Output]
                ↑
      [Program: "Gate"]
      [Decay: Short]
      [Mix: 40%]
```

### Synthwave Lead

Create atmospheric synth leads:

```
[Synthesizer] → [BarrVerb] → [Output]
                    ↑
          [Program: "Hall 2"]
          [Decay: Medium]
          [High Cut: 0.6]
```

### Vocal Processing

Add warmth to vocals:

```
[Vocal Input] → [BarrVerb] → [Vocal Output]
                    ↑
          [Program: "Plate 1"]
          [Mix: 25%]
          [Low Cut: 0.2]
```

## Parameter Automation

### Dynamic Reverb

Automate parameters for evolving effects:

```
[Audio] → [BarrVerb] → [Output]
             ↑
[LFO] → [Decay Time]
[Envelope] → [Mix Level]
```

### Performance Control

Map MIDI controllers:

```
[MIDI Controller] → [CC74] → [BarrVerb.Mix]
                 → [CC71] → [BarrVerb.Decay]
                 → [CC72] → [BarrVerb.HighCut]
```

## Sound Design Techniques

### Reverse Effects

Use reverse reverb for dramatic builds:

1. Set Program to "Reverse"
2. Automate Mix from 0% to 100%
3. Trigger before musical events

### Gated Reverb

Classic 80s gated reverb sound:

1. Select "Gate" program
2. Short decay time (0.1-0.3)
3. High mix level (60-80%)
4. Apply to snare drums or vocals

### Atmospheric Pads

Create spacious pad sounds:

1. Long decay time (0.8-1.0)
2. High Cut around 0.5 for warmth
3. Mix at 50% or higher
4. Use with sustained synthesizer sounds

## Integration Examples

### Drum Machine Chain

```
[Drum Machine] → [EQ] → [BarrVerb] → [Compressor] → [Output]
                           ↑
                  [Program Selection]
                  [Sync to Tempo]
```

### Send Effect Setup

```
[Multiple Sources] → [Mixer] → [Main Output]
                        ↓
                  [Send Bus] → [BarrVerb] → [Return]
```

### Parallel Processing

```
[Input] → [Split] → [Dry Path] → [Mix]
             ↓                    ↑
        [BarrVerb] → [EQ] --------┘
```

## Performance Considerations

### CPU Usage
- Efficient implementation suitable for real-time use
- Lower CPU usage than convolution reverbs
- Multiple instances possible on modern systems

### Latency
- Minimal processing latency
- Real-time parameter changes
- No look-ahead required

### Memory
- Small memory footprint
- No IR samples to load
- Fast initialization

## Best Practices

### Program Selection
1. **Match the Source**: Choose programs that complement your material
2. **Genre Appropriate**: Use Hall for orchestral, Plate for vocals, Gate for drums
3. **Experiment**: Try unexpected combinations for creative results

### Parameter Settings
1. **Start Conservative**: Begin with subtle settings and increase gradually
2. **Context Dependent**: Adjust based on mix density and tempo
3. **Frequency Balance**: Use High/Low Cut to fit reverb in the mix

### Mix Integration
1. **EQ the Reverb**: Filter the reverb return to avoid muddiness
2. **Stereo Width**: BarrVerb adds natural stereo width
3. **Ducking**: Consider sidechain compression for clarity

## Troubleshooting

### Too Muddy
- Increase Low Cut parameter
- Reduce Mix level
- Use shorter Decay time
- Apply high-pass filter to reverb return

### Too Harsh
- Increase High Cut parameter
- Try a warmer program (Plate vs Hall)
- Reduce Input Gain
- Check for input clipping

### Not Vintage Enough
- Ensure authentic programs are selected
- Try higher Mix levels
- Combine with period-appropriate EQ
- Layer with other vintage effects

## Creative Techniques

### Program Morphing

Automate between different programs:
```
[Step Sequencer] → [Program Selection] → [BarrVerb]
```

### Feedback Loops

Create experimental textures:
```
[Input] → [BarrVerb] → [Delay] → [Filter] → [BarrVerb Input]
```
*Use with caution - control feedback levels carefully*

### Vintage Chain

Complete retro processing chain:
```
[Source] → [BitCrusher] → [BarrVerb] → [Tape Saturation] → [Output]
```

## Historical Context

The Alesis MIDIVerb series (1987-1990s) was revolutionary for making digital reverb affordable for home studios. BarrVerb preserves this legacy while adding modern convenience and automation capabilities.

## Related Processes

- [Audio Effects](/processes/audio-effects.html) - Other reverb and effects
- [Delay](/processes/delay.html) - Echo and delay effects  
- [Chorus](/processes/chorus.html) - Modulated effects
- [BitCrusher](/processes/bitcrusher.html) - Vintage digital artifacts