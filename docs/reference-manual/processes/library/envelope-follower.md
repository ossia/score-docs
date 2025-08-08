---
layout: default

title: Envelope Follower
description: "Audio envelope detection for CV-like control"

parent: Processes
grand_parent: Reference

permalink: /processes/envelope-follower.html
---
# Envelope Follower

![Envelope Follower]({{ site.img }}/reference/processes/envelope-follower.png "Audio Envelope Follower")

The Envelope Follower extracts the amplitude envelope from audio signals, converting them to control voltages suitable for modulating other parameters. Based on [Kevin Ferguson's algorithm](https://kferg.dev/posts/2020/audio-reactive-programming-envelope-followers/), it provides smooth, responsive envelope detection that stays in the audio domain for CV-like control.

## Overview

The Envelope Follower enables:
- Real-time envelope extraction from audio
- CV-style control signal generation
- Audio-reactive parameter modulation
- Smooth amplitude tracking
- Low-latency envelope detection

Perfect for:
- Audio-reactive visuals
- Sidechain-style effects
- Dynamic parameter control
- Live audio analysis
- Expressive instrument design

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Audio In | Audio | Input audio signal |
| Threshold | Float | Detection threshold level |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Envelope | Audio | Envelope control signal |
| Peak | Float | Current peak level |
| RMS | Float | RMS (average) level |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Attack | Knob | Envelope attack time (ms) | 1.0 | 0.1-100.0 |
| Release | Knob | Envelope release time (ms) | 100.0 | 1.0-5000.0 |
| Gain | Knob | Output gain multiplier | 1.0 | 0.0-10.0 |
| Mode | Dropdown | Detection mode | "Peak" | Peak, RMS, Peak+RMS |
| Smoothing | Knob | Additional smoothing | 0.0 | 0.0-1.0 |

## Detection Modes

### Peak Detection
Tracks the instantaneous peak amplitude:
- Fast response to transients
- Good for percussive material
- Captures attack transients well
- Can be sensitive to noise

### RMS Detection  
Tracks the average energy level:
- Smoother response
- Better for sustained sounds
- Represents perceived loudness
- Less sensitive to spikes

### Peak + RMS
Combines both methods:
- Peak detection for attacks
- RMS for sustain portions
- Balanced response
- Versatile for mixed material

## Usage Examples

### Audio-Reactive Visuals

Drive visual parameters from music:

```
[Music] → [Envelope Follower] → [Visual Parameter]
              ↓
        [Brightness]
        [Color Intensity]  
        [Animation Speed]
```

### Sidechain Compression Effect

Create ducking effects without a compressor:

```
[Kick Drum] → [Envelope Follower] → [Inverted] → [Music Volume]
                                         ↓
                                  [0→1 becomes 1→0]
```

### Dynamic Filter Control

Modulate filter cutoff with envelope:

```
[Audio] → [Filter] → [Output]
            ↑
[Same Audio] → [Envelope Follower] → [Scale] → [Cutoff Frequency]
```

### Expressive Synthesis

Create responsive synthesizer controls:

```
[Audio Input] → [Envelope Follower] → [Synthesis Parameters]
                                           ↓
                                  [Oscillator Pitch]
                                  [Filter Resonance]
                                  [Effect Depth]
```

## Parameter Configuration

### Attack Time
Controls how quickly the envelope responds to increasing levels:
- **Very Fast (0.1-1ms)**: Capture all transients
- **Fast (1-10ms)**: Good for percussion  
- **Medium (10-50ms)**: Musical response
- **Slow (50ms+)**: Smooth, averaged response

### Release Time
Controls how quickly the envelope decays:
- **Fast (1-50ms)**: Tight, percussive following
- **Medium (50-500ms)**: Musical decay
- **Slow (500-2000ms)**: Smooth, ambient following
- **Very Slow (2s+)**: Long-term dynamics

### Gain Scaling
Adjust output level to match target parameter ranges:
```
[0-1 Envelope] × [Gain 10] = [0-10 Control Range]
```

## Advanced Techniques

### Multi-band Envelope Following

Track different frequency ranges separately:

```
[Audio] → [High Pass] → [Envelope Follower] → [Treble Control]
       → [Band Pass] → [Envelope Follower] → [Mid Control]  
       → [Low Pass]  → [Envelope Follower] → [Bass Control]
```

### Envelope Multiplication

Combine multiple envelopes for complex control:

```
[Audio 1] → [Envelope Follower] → [Multiply] → [Complex Control]
[Audio 2] → [Envelope Follower] → 
```

### Rhythm Extraction

Extract rhythmic information:

```
[Drums] → [High Pass] → [Envelope Follower] → [Rhythm Pattern]
                              ↓
                        [Fast Attack/Release]
```

## Integration Examples

### Live Performance Setup

```
[Microphone] → [Envelope Follower] → [Light Controller]
                                   → [Video Effects]
                                   → [Synthesizer Mod]
```

### Interactive Installation

```
[Ambient Sound] → [Envelope Follower] → [Installation Response]
                                             ↓
                                      [Lighting Intensity]
                                      [Motor Speeds]  
                                      [Projection Brightness]
```

### Creative Audio Processing

```
[Voice] → [Envelope Follower] → [Granular Synthesis Control]
                                      ↓
                              [Grain Size]
                              [Grain Density]
                              [Pitch Variation]
```

## Calibration and Setup

### Setting Threshold

1. **Monitor Input Levels**: Watch peak/RMS outputs
2. **Set Baseline**: Adjust threshold for quiet passages
3. **Check Dynamic Range**: Ensure full 0-1 output range
4. **Test with Content**: Use representative audio material

### Optimizing Response

1. **Match Material Type**: 
   - Percussion: Fast attack, medium release
   - Vocals: Medium attack, medium release
   - Sustained: Slow attack, slow release

2. **Target Parameter Matching**:
   - Visual: Smooth, readable changes
   - Audio: Musical response times
   - Control: Appropriate sensitivity

## Creative Applications

### Generative Music

Use envelope to control composition parameters:

```
[Live Audio] → [Envelope Follower] → [Composition Logic]
                                          ↓
                                   [Note Generation]
                                   [Harmony Changes]
                                   [Rhythm Patterns]
```

### Adaptive Soundscapes

Create responsive audio environments:

```
[Environmental Audio] → [Envelope Follower] → [Soundscape Control]
                                                    ↓
                                            [Ambient Layers]
                                            [Effect Intensity]
                                            [Spatial Movement]
```

### Performance Instruments

Build expressive controllers:

```
[Breath Sensor] → [Audio → Envelope] → [Instrument Expression]
[Contact Mic]   →                            ↓
                                      [Volume Control]
                                      [Timbre Shaping]
                                      [Effect Sends]
```

## Performance Optimization

### CPU Efficiency
- Optimized for real-time performance
- Minimal processing overhead
- Suitable for multiple instances

### Latency Considerations
- Very low latency (typically < 5ms)
- Attack time affects response latency
- Consider lookahead for time-critical applications

### Update Rate
- Audio-rate processing for smooth control
- Can be decimated for less critical applications
- Balance smoothness vs. CPU usage

## Best Practices

### Signal Conditioning
1. **Pre-filtering**: Remove DC offset and unwanted frequencies
2. **Gain Staging**: Ensure appropriate input levels
3. **Noise Gating**: Use threshold to ignore noise floor
4. **Limiting**: Prevent envelope clipping

### Control Mapping
1. **Scaling**: Map envelope range to parameter range
2. **Inversion**: Use 1-x for inverse relationships
3. **Curve Shaping**: Apply curves for musical response
4. **Rate Limiting**: Smooth rapid changes if needed

### System Design
1. **Redundancy**: Have backup control methods
2. **Monitoring**: Display envelope values for debugging
3. **Presets**: Save settings for different material types
4. **Documentation**: Note parameter relationships

## Troubleshooting

### Envelope Too Sensitive
- Increase threshold level
- Increase attack time
- Add smoothing
- Check for input clipping

### Envelope Too Slow
- Decrease attack/release times
- Check input gain
- Try peak mode instead of RMS
- Verify signal levels

### Irregular Response
- Check input signal quality
- Remove DC offset
- Use appropriate detection mode
- Consider pre-filtering

### No Output
- Verify input connections
- Check gain settings
- Monitor input levels
- Test with known audio source

## Mathematical Background

### Peak Detection
```
peak[n] = max(|input[n]|, peak[n-1] * release_coeff)
```

### RMS Calculation
```
rms[n] = sqrt(α * input[n]² + (1-α) * rms[n-1]²)
```

### Envelope Smoothing
```
envelope[n] = attack_coeff * target + (1-attack_coeff) * envelope[n-1]
```

## Related Processes

- [Analysis](/processes/analysis.html) - Audio feature extraction
- [Gate](/processes/gate.html) - Amplitude gating
- [Compressor](/processes/compressor.html) - Dynamic range control
- [LFO](/processes/lfo.html) - Alternative modulation source