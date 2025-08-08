---
layout: default

title: Mapping tool
description: "Advanced parameter mapping with range learning and curve shaping"

parent: Processes
grand_parent: Reference

permalink: /processes/mapping-tool.html
---
# Mapping Tool

![Mapping tool]({{ site.img }}/reference/processes/mapping-tool.png "Mapping tool") 

The Mapping Tool is a comprehensive parameter transformation utility that maps input values to different output ranges with advanced features like automatic range learning, deadzone detection, curve shaping, and various wrap modes. Essential for sensor calibration, parameter scaling, and complex control mappings.

## Overview

The Mapping Tool provides:
- **Range scaling** - Map any input range to any output range
- **Automatic learning** - Learn input min/max values from incoming data
- **Deadzone handling** - Ignore small variations around a midpoint
- **Curve shaping** - Apply mathematical transformations to the mapping
- **Range behaviors** - Different methods for handling out-of-range values
- **Real-time calibration** - Adjust parameters during live performance

Perfect for:
- Sensor calibration and scaling
- MIDI controller response shaping
- Parameter range conversion
- Complex control mappings
- Interactive installation setup

## Parameters

### Input Range

**Min**  
*Type*: Float spinbox  
*Range*: Unlimited  
*Default*: 0.0

Sets the minimum expected input value. Values at or below this become 0.0 in the normalized space.

**Max**  
*Type*: Float spinbox  
*Range*: Unlimited  
*Default*: 1.0

Sets the maximum expected input value. Values at or above this become 1.0 in the normalized space.

**Midpoint**  
*Type*: Float spinbox  
*Range*: Unlimited  
*Default*: 0.5

Central reference point for deadzone calculations and some curve operations.

**Deadzone**  
*Type*: Float spinbox  
*Range*: Positive values only  
*Default*: 0.0

Size of the deadzone around the midpoint. Input values within this range are snapped to the midpoint value.

### Learning Controls

**Learn Min**  
*Type*: Toggle button  
*Default*: Off

When enabled, automatically updates the Min parameter to the lowest input value encountered. Useful for automatic sensor calibration.

**Learn Max**  
*Type*: Toggle button  
*Default*: Off

When enabled, automatically updates the Max parameter to the highest input value encountered. Useful for automatic sensor calibration.

### Processing Options

**Range Behaviour**  
*Type*: Dropdown menu  
*Options*: Free, Clip, Wrap, Fold  
*Default*: Clip

Controls how out-of-range input values are handled:

- **Free**: Allow values outside 0-1 range (may exceed output bounds)
- **Clip**: Clamp values to 0-1 range (hard limiting)
- **Wrap**: Wrap values around 0-1 boundaries (modulo behavior)
- **Fold**: Fold values back into 0-1 range (ping-pong behavior)

**Shape Behaviour**  
*Type*: Dropdown menu  
*Options*: None, Tanh, Sin, Asym  
*Default*: None

Applies mathematical curve shaping to the normalized (0-1) value:

- **None**: Linear response
- **Tanh**: Hyperbolic tangent curve (S-curve with soft saturation)
- **Sin**: Sine curve (smooth S-curve)
- **Asym**: Asymmetric exponential curve (uneven response)

**Curve**  
*Type*: Knob  
*Range*: -1.0 to 1.0  
*Default*: 0.0

Applies power-law curve shaping:
- **Negative values**: Exponential curve (slow start, fast finish)
- **Zero**: Linear response
- **Positive values**: Logarithmic curve (fast start, slow finish)

**Invert**  
*Type*: Toggle  
*Default*: Off

Inverts the normalized output (1.0 - value) before scaling to output range.

**Absolute Value**  
*Type*: Toggle  
*Default*: Off

Takes the absolute value of the input before any other processing. Useful for bipolar signals that should be treated as unipolar.

### Output Range

**Out Min**  
*Type*: Float spinbox  
*Range*: Unlimited  
*Default*: 0.0

Minimum value of the output range.

**Out Max**  
*Type*: Float spinbox  
*Range*: Unlimited  
*Default*: 1.0

Maximum value of the output range.

## Processing Pipeline

The Mapping Tool processes input values through the following stages:

1. **Absolute Value**: If enabled, convert negative values to positive
2. **Deadzone**: If input is within deadzone of midpoint, snap to midpoint
3. **Normalization**: Scale input from (Min, Max) to (0, 1)
4. **Range Behavior**: Handle out-of-range values (clip, wrap, fold)
5. **Shape Behavior**: Apply mathematical curve transformation
6. **Curve**: Apply power-law curve shaping
7. **Invert**: If enabled, invert the normalized value
8. **Output Scaling**: Scale from (0, 1) to (Out Min, Out Max)

## Usage Examples

### Sensor Calibration
```
[Sensor Input] → [Mapping Tool] → [Normalized Output]
                       ↑
            [Learn Min: On, Learn Max: On]
```

Automatically calibrate sensor range by enabling learning modes and exercising the full sensor range.

**Setup**:
1. Enable Learn Min and Learn Max
2. Move sensor through its full range
3. Disable learning when satisfied with calibration
4. Set appropriate output range

### MIDI Controller Shaping
```
[MIDI Controller] → [Mapping Tool] → [Shaped Control]
                          ↑
                [Curve: 0.3, Shape: Tanh]
```

Shape MIDI controller response for more musical control curves.

**Parameters**:
- Input: 0-127 (MIDI range)
- Output: 0.0-1.0 (normalized)
- Curve: 0.3 (logarithmic feel)
- Shape: Tanh (soft saturation)

### Bipolar to Unipolar Conversion
```
[Bipolar Signal (-1 to 1)] → [Mapping Tool] → [Unipolar (0 to 1)]
                                   ↑
                        [Absolute: On, Min: 0, Max: 1]
```

Convert bipolar signals to unipolar using absolute value.

### Joystick Deadzone
```
[Joystick Axis] → [Mapping Tool] → [Deadzone-corrected Output]
                        ↑
            [Midpoint: 0.5, Deadzone: 0.1]
```

Eliminate joystick drift by creating a deadzone around the center position.

**Configuration**:
- Input: -1.0 to 1.0 (joystick range)
- Midpoint: 0.0 (center position)
- Deadzone: 0.05 (ignore small movements)
- Output: -1.0 to 1.0 (corrected range)

### Complex Response Curve
```
[Linear Input] → [Mapping Tool] → [Exponential Response]
                      ↑
        [Curve: -0.7, Shape: Asym, Invert: On]
```

Create complex response curves by combining multiple shaping operations.

## Advanced Applications

### Multi-stage Processing
```
[Input] → [Mapping Tool 1] → [Mapping Tool 2] → [Final Output]
              ↑                    ↑
        [Range scaling]      [Curve shaping]
```

Chain multiple mapping tools for complex transformations.

### Conditional Mapping
```
[Control Signal] → [Logic Gate] → [Enable Mapping]
[Input Signal] → [Mapping Tool] → [Conditional Output]
```

Use logic processes to enable/disable mapping based on conditions.

### Dynamic Range Adjustment
```
[Range Control] → [Mapping Tool Parameters]
[Input Signal] → [Mapping Tool] → [Dynamic Output]
```

Modify mapping parameters in real-time for dynamic response changes.

## Range Behavior Details

### Free Mode
No constraints applied. Output can exceed the specified output range if input exceeds the input range.

**Use cases**: 
- When you want natural extrapolation
- Temporary range excursions are acceptable

### Clip Mode  
Values are hard-limited to 0-1 before output scaling.

**Mathematical behavior**:
```
output = clamp(normalized, 0.0, 1.0)
```

**Use cases**:
- Preventing parameter overruns
- Hard limiting for safety

### Wrap Mode
Values wrap around the 0-1 boundary using modulo arithmetic.

**Mathematical behavior**:
```
output = normalized % 1.0  // simplified
```

**Use cases**:
- Cyclic parameters (angles, phases)
- Creating repeating patterns

### Fold Mode
Values fold back and forth within the 0-1 range.

**Mathematical behavior**:
```
// Ping-pong behavior at boundaries
if (floor(normalized) % 2 == 0)
    output = normalized - floor(normalized)
else
    output = 1.0 - (normalized - floor(normalized))
```

**Use cases**:
- Triangular wave generation
- Smooth boundary handling

## Shape Behavior Details

### Tanh (Hyperbolic Tangent)
Creates an S-shaped curve with smooth saturation at both ends.

**Mathematical formula**:
```
output = (tanh(input * 2 - 1) + 1) / 2
```

**Characteristics**:
- Smooth transitions
- Soft saturation
- Symmetrical response

### Sin (Sine)  
Creates a gentler S-curve using sine function.

**Mathematical formula**:
```
output = (sin(input * 2 - 1) + 1) / 2
```

**Characteristics**:
- Very smooth transitions
- Less aggressive than tanh
- Musical feeling

### Asym (Asymmetric)
Creates an asymmetrical exponential curve.

**Mathematical formula**:
```
x = input * 2 - 1
output = (exp(x) - exp(-x * 1.2)) / (exp(x) + exp(-x))
output = (output + 1) / 2
```

**Characteristics**:
- Different response for positive/negative deviations
- Exponential feel
- Unique character

## Integration Examples

### Audio Parameter Control
```
[Expression Pedal] → [Mapping Tool] → [Reverb Size]
                          ↑
                [Curve: 0.5, Shape: Tanh]
```

Shape expression pedal response for musical reverb control.

### Lighting Control
```
[Motion Sensor] → [Mapping Tool] → [Light Brightness]
                       ↑
            [Learn: Auto-calibrate, Deadzone: 0.02]
```

Automatically calibrate motion sensor for lighting control with noise filtering.

### Video Parameter Mapping
```
[Audio Level] → [Mapping Tool] → [Visual Effect Intensity]
                      ↑
            [Range: 0-1, Curve: -0.3, Invert: Off]
```

Map audio levels to video effects with logarithmic response.

## Best Practices

### Calibration Workflow
1. **Start with learning**: Enable auto-learning for unknown sensors
2. **Exercise full range**: Move sensor/controller through complete range
3. **Disable learning**: Turn off learning when calibration is complete
4. **Fine-tune shape**: Adjust curve and shape parameters for feel
5. **Test extensively**: Verify behavior across full operating range

### Parameter Settings
- **Use deadzone**: Add small deadzone to eliminate noise and drift
- **Choose appropriate curves**: Match curve type to the parameter being controlled
- **Test edge cases**: Verify behavior at minimum and maximum ranges
- **Consider user experience**: Shape curves for intuitive control feel

### Performance Considerations
- **Efficient processing**: Mapping tool is optimized for real-time use
- **Minimal latency**: Processing adds negligible latency
- **Multiple instances**: Safe to use many mapping tools simultaneously
- **Learning overhead**: Learning mode adds minimal computational cost

## Related Processes

- **Calibrator**: Alternative mapping process with different feature set
- **Math Expression**: Custom mathematical transformations
- **Range Filter**: Simple value range limiting
- **Smooth**: Apply smoothing to mapped values