---
layout: default

title: Matrix
description: "Flexible audio routing and spatialization matrix"

parent: Processes
grand_parent: Reference

permalink: /processes/matrix.html
---
# Matrix

![Matrix]({{ site.img }}/reference/processes/matrix.png "Audio Matrix Router")

The Matrix process provides flexible audio routing and mixing capabilities, allowing you to route any input to any output with individual gain control. It's essential for complex spatialization setups and multi-channel audio routing.

## Overview

The Matrix acts as a configurable audio router with:
- Any number of inputs and outputs
- Individual gain control for each connection
- Real-time automation capabilities
- Integration with spatialization algorithms
- Support for large-scale audio systems

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Audio Inputs | Audio Array | Multiple audio sources |
| Coefficients | Float Array | Routing coefficients |
| Control | Object | Automation control data |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Audio Outputs | Audio Array | Routed audio channels |
| Monitoring | Float Array | Current routing state |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Input Count | Integer | Number of inputs | 2 | 1-128 |
| Output Count | Integer | Number of outputs | 2 | 1-128 |
| Mode | Dropdown | Routing mode | "Additive" | Additive, Replace, Multiply |
| Interpolation | Dropdown | Coefficient smoothing | "Linear" | None, Linear, Exponential |
| Fade Time | Float | Transition time (ms) | 10 | 0-1000 |

## Matrix Configuration

### Visual Interface

The Matrix provides a grid interface where:
- Rows represent inputs
- Columns represent outputs
- Intersections show routing gains
- Click and drag to adjust values

### Coefficient Array

The coefficient array is organized as a flat array:
```
[in1→out1, in1→out2, ..., in2→out1, in2→out2, ...]
```

For a 2x2 matrix:
```
[0.0, 1.0,   // Input 1: silent to output 1, full to output 2
 1.0, 0.0]   // Input 2: full to output 1, silent to output 2
```

## Usage Examples

### Basic Stereo Routing

Simple stereo crossfade:

```
[Left Channel]  → [Matrix 2x2] → [Left Output]
[Right Channel] →              → [Right Output]
```

### Spatialization Integration

Use with GBAP or DBAP for speaker routing:

```
[Audio Source] → [Matrix] → [Speaker 1]
       ↑                  → [Speaker 2]
[GBAP Gains]             → [Speaker 3]
                         → [Speaker 4]
```

### Multi-Source Mixing

Mix multiple sources to multiple destinations:

```
[Source 1] → [Matrix 4x8] → [Output Bus 1-8]
[Source 2] →
[Source 3] →
[Source 4] →
```

## Automation

### Coefficient Control

Automate individual matrix points:

```
[LFO] → [Scale 0-1] → [Matrix.coeff[5]]
```

### Pattern Sequencing

Create routing patterns:

```
[Step Sequencer] → [Coefficient Array] → [Matrix]
```

### Dynamic Routing

Change routing based on analysis:

```
[Audio Analysis] → [Threshold] → [Matrix Preset]
```

## Presets and Scenes

### Saving Configurations

1. Set up desired routing
2. Right-click → "Save as Preset"
3. Name the configuration

### Preset Interpolation

Smoothly transition between routing configurations:

```
[Preset A] → [Interpolator] → [Matrix]
[Preset B] →      ↑
            [Fade Control]
```

## Advanced Techniques

### Feedback Matrix

Create feedback networks (use with caution):

```
[Input] → [Matrix] → [Effect] → [Output]
              ↑          ↓
              ←──────────┘
```

### Parallel Processing

Split signals for parallel effects:

```
[Input] → [Matrix 1x4] → [Effect 1] → [Matrix 4x1] → [Output]
                      → [Effect 2] →
                      → [Effect 3] →
                      → [Dry Path] →
```

### Surround Upmixing

Convert stereo to surround:

```
[L/R Input] → [Matrix 2x6] → [5.1 Output]
                  ↑
            [Upmix Coefficients]
```

## Integration Examples

### With Spatialization

Complete spatialization chain:

```
[Sources] → [Matrix] → [Speakers]
               ↑
        [DBAP] + [GBAP]
          ↑        ↑
    [Position] [Grid Control]
```

### Live Performance Setup

Flexible routing for live shows:

```
[Instruments] → [Matrix] → [FOH]
                        → [Monitors]
                        → [Recording]
                        → [Effects Send]
```

## Performance Considerations

### CPU Usage
- Increases with matrix size
- Interpolation adds overhead
- Use sparse matrices when possible

### Latency
- Near-zero latency for routing
- Interpolation adds minimal delay
- Consider fade time settings

### Memory
- Scales with input × output count
- Coefficient storage is efficient
- Preset storage considerations

## Best Practices

1. **Start Small**: Begin with minimal routing needs
2. **Document Routing**: Label inputs/outputs clearly
3. **Use Presets**: Save common configurations
4. **Monitor Levels**: Watch for gain buildup
5. **Test Thoroughly**: Verify all routing paths

## Common Patterns

### Cross-fade Matrix
```
[1.0, 0.0]  // A to Left
[0.0, 1.0]  // B to Right
```

### Distribution Matrix
```
[0.5, 0.5]  // Equal to both
[0.5, 0.5]
```

### Isolation Matrix
```
[1.0, 0.0, 0.0]  // Channel isolation
[0.0, 1.0, 0.0]
[0.0, 0.0, 1.0]
```

## Troubleshooting

### No Audio Output
- Check coefficient values
- Verify input signals
- Confirm output connections

### Distortion
- Reduce coefficient sum per output
- Check input levels
- Enable normalization if needed

### Clicking/Popping
- Increase fade time
- Use interpolation
- Avoid instant large changes

## Related Processes

- [GBAP]({{ site.baseurl }}/processes/gbap.html) - Grid-based panning
- [DBAP]({{ site.baseurl }}/processes/dbap.html) - Distance-based panning
- [Audio Mixer]({{ site.baseurl }}/processes/audio-mixer.html) - Simple mixing
- [Mapping]({{ site.baseurl }}/processes/mapping.html) - Parameter control