---
layout: default

title: Interpolator
description: "Interpolate between multiple values using weights"

parent: Processes
grand_parent: Reference

permalink: /processes/interpolator.html
---
# Interpolator

![Interpolator]({{ site.img }}/reference/processes/interpolator.png "Value Interpolator")

The Interpolator process provides weighted interpolation between multiple values or vectors. Given a set of weights and a set of values, it calculates the linear interpolation of each value. This is particularly useful for navigating latent spaces, morphing between states, and creating smooth transitions.

## Overview

The Interpolator enables:
- Weighted blending of multiple values
- Smooth transitions between states
- Latent space navigation
- Multi-dimensional morphing
- Real-time interpolation

Perfect for:
- AI latent space exploration
- Parameter morphing
- State transitions
- Creative blending
- Smooth control surfaces

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Values | Array | Set of values to interpolate between |
| Weights | Float Array | Interpolation weights for each value |
| Normalize | Bool | Whether to normalize weights |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Result | Float/Array | Interpolated result |
| Normalized Weights | Float Array | Weights after normalization |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Value Count | Integer | Number of values to interpolate | 3 | 2-20 |
| Dimensions | Integer | Dimensions per value | 1 | 1-100 |
| Interpolation | Dropdown | Interpolation method | "Linear" | Linear, Cubic, Spherical |
| Auto Normalize | Toggle | Automatically normalize weights | On | On/Off |

## Interpolation Methods

### Linear Interpolation
Standard weighted average:
```
result = Σ(weight[i] * value[i]) / Σ(weight[i])
```

### Cubic Interpolation
Smooth curves through control points, useful for temporal interpolation.

### Spherical Interpolation (SLERP)
Maintains constant "distance" during interpolation, ideal for:
- Unit vectors
- Rotations
- Normalized data

## Basic Usage

### Simple 2-Value Blend

Crossfade between two values:

```
Values: [0.0, 1.0]
Weights: [0.7, 0.3]
Result: 0.3 (70% of first value, 30% of second)
```

### Multi-Value Mixing

Blend between multiple states:

```
Values: [red_color, green_color, blue_color]
Weights: [0.5, 0.3, 0.2]
Result: Mixed color with 50% red, 30% green, 20% blue
```

## Advanced Applications

### Latent Space Navigation

Navigate AI model latent spaces:

```
[Latent Points A, B, C, D] → [Interpolator] → [Blended Vector] → [AI Model]
[2D Control Pad] → [Position to Weights] →
```

Example for 4-point interpolation from 2D position:
```javascript
// Convert X,Y position to 4-corner weights
weights = [
  (1-x) * (1-y),  // Bottom-left
  x * (1-y),      // Bottom-right  
  (1-x) * y,      // Top-left
  x * y           // Top-right
]
```

### Parameter Morphing

Smooth transitions between effect presets:

```
[Preset A params] → [Interpolator] → [Current params] → [Effect]
[Preset B params] →
[Preset C params] →
         ↑
[Control Weights]
```

### Multi-Dimensional Control

Control multiple parameters simultaneously:

```
[Audio Features] → [Feature to Weights] → [Interpolator] → [Visual Params]
                                               ↑
                        [Color Palette Points A, B, C]
```

## Creative Techniques

### Circular Navigation

Navigate around a circle of values:

```
[LFO] → [Phase to Weights] → [Interpolator] → [Morphed Value]
               ↑                    ↑
        [Convert to 4 weights]  [4 Corner Values]
```

### Gesture-Based Morphing

Use hand tracking for intuitive control:

```
[Hand Position] → [2D to Barycentric] → [Interpolator] → [Instrument Params]
                                              ↑
                                    [3 Instrument Presets]
```

### Temporal Evolution

Animate through parameter spaces:

```
[Timeline Position] → [Curve Lookup] → [Interpolator] → [Evolving Parameters]
                                            ↑
                                [Keyframe Parameter Sets]
```

## Weight Calculation Strategies

### Distance-Based Weights

Calculate weights based on distance from control points:

```javascript
// For each control point i:
distance[i] = length(input_position - control_point[i])
weight[i] = 1.0 / (distance[i] + epsilon)
// Normalize weights
```

### Gaussian Weights

Smooth influence regions:

```javascript
weight[i] = exp(-(distance[i]^2) / (2 * sigma^2))
```

### Barycentric Coordinates

For triangular regions:
```javascript
// Convert point inside triangle to barycentric coordinates
// Each coordinate is a weight for triangle vertices
```

## Integration Examples

### AI-Driven Visuals

```
[Style Vectors A, B, C] → [Interpolator] → [Blended Style] → [GAN Model]
[Audio Analysis] → [Feature Mapping] →
```

### Interactive Soundscapes

```
[Location Presets] → [Interpolator] → [Audio Parameters] → [Spatial Audio]
[User Position] → [Proximity Weights] →
```

### Adaptive Lighting

```
[Scene Configurations] → [Interpolator] → [Light Settings] → [DMX Output]
[Environmental Sensors] → [Context Weights] →
```

## Performance Considerations

### Real-time Usage
- Linear interpolation is fastest
- Cubic interpolation adds computational cost
- Spherical interpolation is most expensive

### Memory Usage
- Scales with number of values and dimensions
- Consider using lower precision for large datasets
- Cache normalized weights when possible

### Update Rate
- Match update rate to control sensitivity
- Use rate limiting for smooth transitions
- Consider interpolation of weights themselves

## Best Practices

### Weight Management
1. **Normalization**: Ensure weights sum to 1.0 for proper blending
2. **Smoothing**: Filter rapid weight changes for stable output
3. **Validation**: Check for negative or invalid weights
4. **Constraints**: Implement weight constraints for specific behaviors

### Value Organization
1. **Consistency**: Keep value dimensions consistent
2. **Ordering**: Organize values logically (e.g., by similarity)
3. **Range**: Normalize value ranges when needed
4. **Quality**: Ensure all reference values are valid

### Control Strategies
1. **Intuitive Mapping**: Design weight controls that feel natural
2. **Feedback**: Provide visual feedback for current interpolation
3. **Presets**: Save useful weight configurations
4. **Limits**: Constrain weights to meaningful ranges

## Troubleshooting

### Unexpected Results
- Check weight normalization
- Verify value dimensions match
- Ensure weights are in valid ranges
- Test with simple known values

### Performance Issues
- Reduce update frequency
- Use simpler interpolation methods
- Limit number of values
- Cache computed results

### Control Problems
- Smooth weight transitions
- Check weight calculation logic
- Verify input ranges
- Test with manual weight values

## Mathematical Background

### Linear Interpolation Formula
```
result = (w₁ × v₁ + w₂ × v₂ + ... + wₙ × vₙ) / (w₁ + w₂ + ... + wₙ)
```

### Barycentric Coordinates
For triangle ABC with point P:
```
w₁ = Area(PBC) / Area(ABC)
w₂ = Area(APC) / Area(ABC)  
w₃ = Area(APB) / Area(ABC)
```

### Spherical Interpolation
```
slerp(v₁, v₂, t) = (sin((1-t)θ) × v₁ + sin(tθ) × v₂) / sin(θ)
where θ = arccos(v₁ · v₂)
```

## Related Processes

- [Nodes](/processes/nodes.html) - 2D interpolation spaces
- [Tweener](/processes/tweener.html) - Easing and transitions
- [Mapping](/processes/mapping.html) - Parameter mapping
- [AI Prompt Interpolator](/processes/ai-prompt-interpolator.html) - Text interpolation