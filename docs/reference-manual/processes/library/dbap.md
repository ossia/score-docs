---
layout: default

title: DBAP
description: "Distance-Based Amplitude Panning for spatial audio"

parent: Processes
grand_parent: Reference

permalink: /processes/dbap.html
---
# DBAP - Distance-Based Amplitude Panning

![DBAP]({{ site.img }}/reference/processes/dbap.png "Distance-Based Amplitude Panning")

DBAP (Distance-Based Amplitude Panning) is a flexible spatialization technique that calculates speaker gains based on the distances between sound sources and speakers. Unlike traditional panning laws, DBAP works with irregular speaker layouts and any number of speakers.

## Overview

DBAP offers several advantages:
- Works with any speaker configuration (regular or irregular)
- Supports 2D and 3D spatialization
- No sweet spot dependency
- Scalable from stereo to large speaker arrays
- Computationally efficient

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Source Position | Vec2/Vec3 | Position of the sound source |
| Source Positions | Array | Multiple source positions |
| Speaker Positions | Array | Speaker layout configuration |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Gains | Float Array | Amplitude values for each speaker |
| Distances | Float Array | Distance from source to each speaker |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Dimensions | Dropdown | 2D or 3D mode | 2D | 2D, 3D |
| Rolloff | Float | Distance attenuation curve | 6.0 | 0.1-50.0 |
| Blur | Float | Spatial blur amount | 0.0 | 0.0-1.0 |
| Focus | Float | Spatial focus/spread | 1.0 | 0.1-10.0 |
| Normalize | Toggle | Normalize output gains | On | On/Off |

## Speaker Configuration

### Defining Speaker Positions

Speaker positions can be set through:
1. Manual entry in the inspector
2. Loading from a configuration file
3. Programmatic generation via JavaScript

Example 2D configuration (8-speaker ring):
```javascript
[
  [1.0, 0.0],    // Front
  [0.7, 0.7],    // Front-Right
  [0.0, 1.0],    // Right
  [-0.7, 0.7],   // Rear-Right
  [-1.0, 0.0],   // Rear
  [-0.7, -0.7],  // Rear-Left
  [0.0, -1.0],   // Left
  [0.7, -0.7]    // Front-Left
]
```

### Common Configurations

| Setup | Description |
|-------|-------------|
| Stereo | 2 speakers at ±30° |
| Quad | 4 speakers in square |
| 5.1 | Standard surround setup |
| Octophonic | 8 speakers in circle |
| Dome | 3D hemispherical array |

## Rolloff Parameter

The rolloff controls how sound amplitude decreases with distance:
- **Low values (1-3)**: Gradual fade, wider spread
- **Medium values (4-8)**: Natural attenuation
- **High values (10+)**: Sharp localization

## Usage Examples

### Basic 2D Panning

Simple setup for quadraphonic panning:

```
[XY Pad] → [Source Position] → [DBAP] → [Gains]
                                   ↑         ↓
                          [Speaker Config] [Matrix Mixer]
```

### Multi-Source Spatialization

Handle multiple sound sources:

```
[Multi-Cursor] → [Source Positions] → [DBAP] → [Per-Source Gains]
                                         ↑              ↓
                                [Speaker Layout]   [Audio Router]
```

### Automated Movement

Create spatial trajectories:

```
[Path Generator] → [DBAP] → [Speaker Gains]
        ↑             ↑
    [LFO/Time]  [Speaker Array]
```

## Integration with Other Spatial Tools

### DBAP + Matrix

Combine DBAP with the Matrix process for flexible routing:

```
[DBAP] → [Gains] → [Matrix] → [Audio Outputs]
                       ↑
                [Audio Sources]
```

### DBAP + GBAP Hybrid

Use both techniques for different frequency bands:

```
[Low Freq] → [DBAP] → [Mix]
[High Freq] → [GBAP] → [Mix]
```

## 3D Spatialization

For 3D setups, positions include height (z-coordinate):

```javascript
// 3D speaker positions [x, y, z]
[
  [1.0, 0.0, 0.0],   // Front floor
  [1.0, 0.0, 1.0],   // Front ceiling
  [-1.0, 0.0, 0.0],  // Rear floor
  [-1.0, 0.0, 1.0],  // Rear ceiling
  // ... more speakers
]
```

## Performance Optimization

### Calculation Rate
- Full rate: Every audio sample
- Control rate: Once per buffer
- On change: Only when position moves

### CPU Efficiency
- Pre-calculate speaker distances
- Use lookup tables for complex setups
- Implement movement thresholds

## Artistic Applications

### Concert Hall Spatialization
- Place virtual sources anywhere
- Create immersive soundscapes
- Support any speaker configuration

### Installation Art
- React to visitor positions
- Create spatial zones
- Dynamic speaker reconfiguration

### Live Performance
- Real-time source manipulation
- Gesture-controlled spatialization
- Multi-performer setups

## Best Practices

1. **Speaker Calibration**: Measure actual speaker positions
2. **Rolloff Tuning**: Adjust for room acoustics
3. **Source Limits**: Avoid placing sources exactly on speakers
4. **Gain Management**: Monitor overall levels
5. **Testing**: Walk the space to verify spatialization

## Troubleshooting

### Uneven Distribution
- Check speaker position accuracy
- Verify normalization settings
- Adjust rolloff parameter

### Localization Issues
- Increase rolloff for sharper focus
- Reduce blur parameter
- Check speaker phase alignment

### CPU Overload
- Reduce calculation rate
- Limit number of sources
- Optimize speaker count

## Mathematical Background

DBAP calculates gains using:
```
gain[i] = 1 / (distance[i]^rolloff)
```

With normalization:
```
gain[i] = gain[i] / sum(all gains)
```

## Related Processes

- [GBAP](/processes/gbap.html) - Grid-based panning
- [Matrix](/processes/matrix.html) - Audio routing matrix
- [Multi-Cursor](/processes/multi-cursor.html) - Multiple source positions
- [Path Generator](/processes/path-generator.html) - Spatial trajectories