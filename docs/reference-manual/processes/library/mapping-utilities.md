---
layout: default

title: Mapping utilities
description: "Essential utilities for parameter mapping, filtering, and control signal processing"

parent: Processes
grand_parent: Reference

permalink: /processes/mapping-utilities.html
---
# Mapping Utilities

![Mapping utilities]({{ site.img }}/reference/processes/mapping-utilities.png "Mapping utilities") 

The mapping utilities collection provides essential building blocks for parameter transformation, signal conditioning, and control flow management. These processes form the foundation of most interactive systems in ossia score.

## Overview

The mapping utilities include:
- **Range processing** - Scale and filter numeric ranges
- **Signal conditioning** - Clean and prepare control signals  
- **Basic data types** - Generate and process fundamental data types
- **Trigger detection** - Detect threshold crossings and state changes
- **Array manipulation** - Process and distribute array data
- **Direction analysis** - Track parameter movement and changes

Perfect for:
- Sensor data conditioning
- Parameter scaling and conversion
- Control flow management
- Interactive system building
- Real-time signal processing

## Range Mapper {#range-mapper}

![Range Mapper]({{ site.img }}/reference/processes/range-mapper.png "Range Mapper")

The Range Mapper performs linear scaling from one numeric range to another. Essential for converting between different parameter scales and sensor calibration.

### Parameters

**In**  
*Type*: Value input (float)  
*Description*: The input value to be scaled

**In min**  
*Type*: Spinbox (-1e6 to 1e6)  
*Default*: 0.0  
*Description*: Minimum value of the input range

**In max**  
*Type*: Spinbox (-1e6 to 1e6)  
*Default*: 1.0  
*Description*: Maximum value of the input range

**Out min**  
*Type*: Spinbox (-1e6 to 1e6)  
*Default*: 0.0  
*Description*: Minimum value of the output range

**Out max**  
*Type*: Spinbox (-1e6 to 1e6)  
*Default*: 1.0  
*Description*: Maximum value of the output range

### Output

**Out**  
*Type*: Float value  
*Description*: Scaled output value

### Usage Examples

**MIDI to Frequency:**
```
Input: 60 (MIDI note)
In min: 0, In max: 127
Out min: 20, Out max: 20000
Output: ~9449 Hz
```

**Sensor Normalization:**
```
Input: 512 (ADC reading)
In min: 0, In max: 1023  
Out min: 0.0, Out max: 1.0
Output: ~0.5
```

## Range Filter {#range-filter}

![Range Filter]({{ site.img }}/reference/processes/range-filter.png "Range Filter")

The Range Filter allows only values within a specified range to pass through, filtering out unwanted values. Supports both normal and inverted operation modes.

### Parameters

**Min**  
*Type*: Spinbox (-1e6 to 1e6)  
*Default*: 0.0  
*Description*: Minimum value of the allowed range

**Max**  
*Type*: Spinbox (-1e6 to 1e6)  
*Default*: 1.0  
*Description*: Maximum value of the allowed range  

**Invert**  
*Type*: Toggle  
*Default*: Off  
*Description*: When enabled, only values outside the range pass through

### Output

**Output**  
*Type*: Optional float  
*Description*: Input value if within range, no output if filtered

### Behavior

**Normal Mode (Invert: Off)**:
- Values >= Min AND <= Max pass through unchanged
- Values outside range are filtered (no output)

**Inverted Mode (Invert: On)**:
- Values <= Min OR >= Max pass through unchanged  
- Values inside range are filtered (no output)

### Usage Examples

**Noise Gate:**
```
Min: 0.1, Max: 1.0, Invert: Off
Input: 0.05 → No output (filtered)
Input: 0.5 → Output: 0.5
```

**Outlier Detection:**
```
Min: -1.0, Max: 1.0, Invert: On
Input: 0.5 → No output (normal range)
Input: 2.0 → Output: 2.0 (outlier detected)
```

## Trigger {#trigger}

![Trigger]({{ site.img }}/reference/processes/trigger.png "Trigger Process")

The Trigger process detects when input values cross specified thresholds, generating impulses on state transitions. Essential for converting continuous signals to discrete events.

### Parameters

**Input**  
*Type*: Value input (float)  
*Description*: Continuous input signal to monitor

**Ceil**  
*Type*: Range slider  
*Description*: Dual threshold defining trigger and release points  
- **Start value**: Lower threshold (release trigger)
- **End value**: Upper threshold (enter trigger)

### Outputs

**Enter**  
*Type*: Optional impulse  
*Description*: Sends impulse when input crosses above upper threshold

**Leave**  
*Type*: Optional impulse  
*Description*: Sends impulse when input crosses below lower threshold

### State Behavior

The trigger maintains internal state to prevent multiple triggers:

1. **Inactive State**: Input below lower threshold
   - Enter trigger armed
   - Leave trigger disarmed

2. **Active State**: Input above upper threshold  
   - Enter trigger disarmed
   - Leave trigger armed

3. **Hysteresis**: Prevents oscillation between states when input hovers near thresholds

### Usage Examples

**Button Press Detection:**
```
Input: Button pressure (0.0 - 1.0)
Ceil: Start: 0.2, End: 0.8
Enter → Button pressed
Leave → Button released
```

**Audio Gate:**
```
Input: Audio level
Ceil: Start: 0.1, End: 0.3  
Enter → Audio signal present
Leave → Audio signal absent
```

**Motion Detection:**
```
Input: Motion sensor value
Ceil: Start: 0.05, End: 0.1
Enter → Motion started
Leave → Motion stopped
```

## Angle Mapper {#angle-mapper}

![Angle Mapper]({{ site.img }}/reference/processes/angle-mapper.png "Angle Mapper")

The Angle Mapper tracks the direction of change in input values, outputting -1, 0, or 1 to indicate decreasing, steady, or increasing values respectively.

### Parameters

**In**  
*Type*: Value input (float)  
*Description*: Input signal to analyze for direction changes

### Output

**Out**  
*Type*: Callback (float)  
*Description*: Direction indicator:
- **-1.0**: Input is decreasing  
- **0.0**: Input is unchanged
- **1.0**: Input is increasing

### Behavior

The process compares each input value with the previous value:
- **First input**: No output (establishing baseline)
- **Subsequent inputs**: Output based on comparison with previous value
- **State memory**: Maintains previous value for continuous comparison

### Usage Examples

**Encoder Direction:**
```
Input sequence: 0.1, 0.3, 0.3, 0.1, 0.5
Output sequence: 1, 0, -1, 1
```

**Parameter Trend Analysis:**
```
Input: Temperature sensor
Output: 1 = warming, -1 = cooling, 0 = stable
```

**Control Surface Feedback:**
```
Input: Fader position
Output: Direction indication for LED feedback
```

## Combine {#combine}

*Note: This process is documented in the [Combine & Spread](combine-spread.html) page as part of the array processing utilities.*

The Combine process aggregates multiple inputs into a single array output.

### Quick Reference

**Function**: N inputs → 1 array output  
**Use case**: Collecting multiple control values  
**Category**: Array manipulation

## Spread {#spread}

*Note: This process is documented in the [Combine & Spread](combine-spread.html) page as part of the array processing utilities.*

The Spread process distributes array elements to multiple individual outputs.

### Quick Reference

**Function**: 1 array input → N outputs  
**Use case**: Distributing array data to multiple destinations  
**Category**: Array manipulation

## Basic Data Types

The mapping utilities include fundamental data type generators that send values when their parameters change.

### Impulse {#impulse}

![Impulse]({{ site.img }}/reference/processes/impulse.png "Impulse Generator")

Generates impulse messages triggered by any input message.

**Function**: Message input → Impulse output  
**Use case**: Converting any message type to impulse  
**Trigger**: Any incoming message

#### Messages

**Message**  
*Type*: Generic message input  
*Description*: Any incoming message triggers the impulse output

#### Output

**Impulse**  
*Type*: Callback  
*Description*: Sends impulse when any message is received

### Integer {#integer}

![Integer]({{ site.img }}/reference/processes/integer.png "Integer Generator")

Sends integer values when the parameter changes.

**Parameters**:
- **Value**: Integer spinbox with unlimited range
- **Auto-send**: Sends value when parameter changes

**Output**: Integer callback with current value

**Use cases**:
- Counter values
- Discrete state indicators  
- Index generation

### Float {#float}

![Float]({{ site.img }}/reference/processes/float.png "Float Generator")

Sends floating-point values when the parameter changes.

**Parameters**:
- **Value**: Float spinbox with unlimited range
- **Auto-send**: Sends value when parameter changes

**Output**: Float callback with current value

**Use cases**:
- Continuous parameter generation
- Reference value broadcasting
- Manual parameter control

### String {#string}

![String]({{ site.img }}/reference/processes/string.png "String Generator")

Sends text strings when the parameter changes.

**Parameters**:
- **Value**: Text line editor
- **Auto-send**: Sends string when parameter changes

**Output**: String callback with current text

**Use cases**:
- Text message broadcasting
- Command generation
- Label distribution

## Integration Examples

### Sensor Processing Pipeline
```
[Sensor Input] → [Range Mapper] → [Range Filter] → [Trigger] → [Events]
                       ↓              ↓             ↓
                 [Normalize]    [Remove noise]  [Detect states]
```

Complete sensor conditioning from raw input to clean events.

### Multi-parameter Control
```
[Controller 1] → [Combine] → [Spread] → [Parameter 1]
[Controller 2] →            → [Spread] → [Parameter 2]  
[Controller 3] →            → [Spread] → [Parameter 3]
```

Aggregate multiple controllers and distribute to multiple parameters.

### Direction-based Effects
```
[Position Input] → [Angle Mapper] → [Direction Logic] → [Effect Intensity]
```

Use movement direction to control effect parameters.

### Threshold-based Automation
```
[Continuous Input] → [Trigger] → [State Machine] → [Automated Actions]
                        ↓
                 [Discrete Events]
```

Convert continuous signals to discrete state-based automation.

## Performance Characteristics

### Computational Efficiency
- **Range Mapper**: Very low CPU usage, simple arithmetic
- **Range Filter**: Minimal processing, comparison operations only
- **Trigger**: Low CPU usage, maintains minimal state
- **Angle Mapper**: Minimal processing, single comparison per update
- **Data Types**: Near-zero processing overhead

### Memory Usage  
- **Stateless processes**: Range Mapper, Range Filter - no memory overhead
- **Stateful processes**: Trigger (boolean state), Angle Mapper (single float)
- **Data Types**: Parameter storage only, minimal memory usage

### Latency
- **All processes**: Near-zero latency, immediate output generation
- **Real-time safe**: All processes suitable for low-latency applications

## Best Practices

### Signal Conditioning Chain
1. **Range Mapper**: Scale to working range first
2. **Range Filter**: Remove outliers and noise  
3. **Trigger**: Generate clean discrete events
4. **Processing**: Apply higher-level logic

### Threshold Selection
- **Hysteresis**: Use different enter/leave thresholds to prevent oscillation
- **Noise margins**: Set thresholds outside expected noise range
- **Context appropriate**: Match thresholds to signal characteristics

### Performance Optimization
- **Minimize state**: Use stateless processes when possible
- **Chain efficiently**: Arrange processing to minimize redundant operations
- **Parameter stability**: Avoid rapidly changing configuration parameters

### Common Patterns
- **Sensor → Mapper → Filter → Logic**: Standard sensor processing
- **Input → Combine → Process → Spread**: Multi-channel processing
- **Signal → Trigger → State Machine**: Event-driven systems
- **Parameter → Direction → Feedback**: Dynamic response systems

## Related Processes

- **Calibrator**: Advanced sensor calibration with learning capabilities
- **Mapping Tool**: Comprehensive parameter transformation with curve shaping  
- **Math Expression**: Custom mathematical transformations
- **Logic Processes**: Boolean logic and conditional processing
- **Array Utilities**: Advanced array processing and manipulation