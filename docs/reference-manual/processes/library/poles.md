---
layout: default

title: Poles
description: "Generate Gaussian curve distributions for smooth value transitions"

parent: Processes
grand_parent: Reference

permalink: /processes/poles.html
---
# Poles

![Poles]({{ site.img }}/reference/processes/poles.png "Poles") 

The Poles process generates smooth Gaussian curve distributions centered around adjustable positions. Perfect for creating natural-feeling transitions, smooth value distributions, and organic control curves in interactive systems.

## Overview

Poles enables:
- **Gaussian curve generation** - Mathematical bell curves with adjustable parameters
- **Smooth value distributions** - Natural-looking transitions and gradients  
- **Dynamic positioning** - Real-time adjustment of curve center position
- **Configurable width** - Control curve spread with sigma parameter
- **Array output** - Generate arrays of values following the curve
- **Scientific accuracy** - Uses proper Gaussian probability density function

## Parameters

### Pos (Position)
**Type**: Knob (float)  
**Range**: -1.0 to 1.0  
**Default**: 0.0

Sets the center position of the Gaussian curve along the output array. The curve peak will be positioned at this location:
- **-1.0** = Peak at the left end of the array
- **0.0** = Peak at the center of the array
- **1.0** = Peak at the right end of the array

### Length
**Type**: Spinbox (integer)  
**Range**: 1 to 1000  
**Default**: 20

Determines the number of output values in the generated array. Higher values provide smoother curves but use more memory and processing.

### Sigma
**Type**: Knob (float, logarithmic)  
**Range**: 0.001 to 1.0  
**Default**: 0.01

Controls the width (standard deviation) of the Gaussian curve:
- **Smaller values** = Narrow, sharp peaks
- **Larger values** = Wide, gentle curves
- **Logarithmic mapping** = Better control over small values

### Range  
**Type**: Knob (float)  
**Range**: 0.0 to 1.0  
**Default**: 1.0

Multiplier for the output values, controlling the maximum height of the curve:
- **0.0** = Flat output (all zeros)
- **0.5** = Half-height curve
- **1.0** = Full-height curve

## Output

### Out
**Type**: Array of floats  
**Content**: Gaussian curve values

Provides an array of floating-point values representing the Gaussian curve distribution.

## Mathematical Foundation

The Poles process implements the Gaussian probability density function:

```
f(x) = (1 / (σ√(2π))) × e^(-½((x-μ)/σ)²)
```

Where:
- **μ (mu)** = mean (position parameter)
- **σ (sigma)** = standard deviation (width parameter) 
- **x** = position along the curve

The implementation uses the constant **0.3989422804014327** which equals **1/√(2π)** for computational efficiency.

## Usage Examples

### Smooth Value Distribution
```
[Poles] → [Array to Multiple Outputs] → [LED Strip Control]
   ↑
[Position Automation]
```

Create smooth lighting transitions across LED strips with the peak following an animation.

### Audio Envelope Generation
```
[Poles] → [Array Processor] → [Audio Amplitude Control]
   ↑
[Note Trigger] → [Position Control]
```

Generate smooth audio envelopes with controllable attack and decay characteristics.

### Spatial Audio Panning
```
[Poles] → [Speaker Array Mapping] → [Multi-channel Audio]
   ↑
[Motion Tracker] → [Position Input]
```

Create smooth spatial audio transitions where sound intensity follows a Gaussian distribution across speakers.

### Visual Effects
```
[Poles] → [Shader Parameters] → [Gaussian Blur Effect]
   ↑
[Mouse Position] → [Real-time Control]
```

Control visual effects with smooth, natural-feeling parameter distributions.

## Curve Shape Examples

### Narrow Peak (Small Sigma)
```
Sigma = 0.01, Length = 20:
[0.0, 0.0, 0.0, 0.1, 0.8, 1.0, 0.8, 0.1, 0.0, 0.0, 0.0, ...]
         Sharp peak at center
```

### Wide Curve (Large Sigma)
```
Sigma = 0.3, Length = 20:
[0.2, 0.4, 0.6, 0.8, 0.9, 1.0, 0.9, 0.8, 0.6, 0.4, 0.2, ...]
         Gentle, wide distribution
```

### Position Offset
```
Pos = -0.5, Sigma = 0.1:
[1.0, 0.8, 0.3, 0.1, 0.0, 0.0, 0.0, ...]
Peak shifted to left side
```

## Advanced Applications

### Multi-pole Systems
Combine multiple Poles processes for complex distributions:
```
[Poles 1] → [Array Combiner] ← [Poles 2]
     ↓              ↓
[Position A]   [Position B]
     ↓              ↓
[Dual-peak Distribution]
```

### Dynamic Curve Morphing
```
[Poles] → [Output Array]
  ↑
[LFO] → [Sigma Modulation]
[Position Automation]
```

Create morphing curves by simultaneously animating position and width.

### Scientific Data Visualization
```
[Poles] → [Data Visualization] → [Research Display]
  ↑
[Measured Values] → [Statistical Modeling]
```

Model experimental data distributions or create probability visualizations.

### Interactive Installations
```
[Motion Sensor] → [Poles] → [Light Installation]
                     ↑
            [Distance Mapping] → [Sigma Control]
```

Create installations where viewer proximity controls both position and spread of effects.

## Performance Characteristics

### Computational Efficiency
- **Fast calculation** using precomputed constants
- **Exponential function** requires moderate CPU resources
- **Array size** linearly affects performance
- **Real-time capable** for typical array lengths

### Memory Usage
- **Array size** = Length × 4 bytes (float)
- **Example**: 100 elements = 400 bytes
- **Dynamic allocation** adjusts to Length parameter

### Update Frequency
- **Position changes** require full array recalculation
- **Sigma changes** trigger coefficient updates
- **Length changes** cause memory reallocation
- **Range changes** apply simple multiplication

## Integration Patterns

### Control Surface Mapping
Map hardware controls to Poles parameters:
```
MIDI Controller → Position (knob 1)
                → Sigma (knob 2)  
                → Range (knob 3)
```

### Automation Integration
```
Timeline Automation → Poles Parameters → Dynamic Curves
```

### Sensor-driven Systems
```
Physical Sensors → Poles Control → Environmental Response
```

## Troubleshooting

### Common Issues
- **Flat output**: Check Range parameter is not zero
- **Too sharp**: Increase Sigma value for wider curves
- **Too wide**: Decrease Sigma for sharper peaks
- **Wrong position**: Verify Pos parameter range (-1.0 to 1.0)

### Performance Issues
- **High CPU usage**: Reduce Length or update frequency
- **Memory warnings**: Lower Length value
- **Sluggish response**: Check for unnecessary parameter updates

## Mathematical Properties

### Normalization
The output is scaled so the peak value equals the Range parameter, not normalized to unit area like a true probability distribution.

### Symmetry
The curve is symmetric around the position parameter, creating mirror-image falloff on both sides.

### Continuous Derivatives
Gaussian curves have smooth derivatives at all points, ensuring no sharp transitions in the output.

## Related Processes

- **LFO**: Generate periodic control signals
- **Array Utilities**: Process and manipulate the output arrays  
- **Interpolator**: Create smooth transitions between discrete values
- **Math Expression**: Custom mathematical curve generation
- **Smooth**: Apply smoothing to control signals