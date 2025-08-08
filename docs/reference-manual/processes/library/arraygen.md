---
layout: default

title: ArrayGen
description: "Generate arrays using mathematical expressions"

parent: Processes
grand_parent: Reference

permalink: /processes/arraygen.html
---
# ArrayGen

![ArrayGen]({{ site.img }}/reference/processes/arraygen.png "ArrayGen Process")

ArrayGen is a powerful process that generates arrays of values using mathematical expressions. It provides a flexible way to create sequences, patterns, and complex data sets programmatically, with support for variables, functions, and real-time parameter control.

## Overview

ArrayGen enables:
- **Mathematical array generation** using expressions
- **Real-time expression editing** with live updates
- **Variable substitution** and parameterization
- **Complex mathematical functions** and operations
- **Dynamic array sizing** based on expressions
- **Pattern generation** for creative and scientific applications

Perfect for:
- Creating mathematical sequences and patterns
- Generating control data for automations
- Building lookup tables and waveforms
- Scientific data generation
- Creative pattern design

## Inputs

| Port | Type | Description |
|------|------|-------------|
| N | Integer | Number of elements to generate |
| Variables | Object | Named variables for expressions |
| Expression | String | Mathematical expression to evaluate |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Array | Float Array | Generated array values |
| Length | Integer | Actual array length |
| Min/Max | Float | Array value range |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Expression | Text Editor | Mathematical expression | `i / n` | Any valid expression |
| Array Size | Integer | Number of elements | 10 | 1-10000 |
| Live Editing | Toggle | Enable real-time updates | On | On/Off |
| Format | Dropdown | Number format | "Float" | Float, Integer |

## Expression Language

### Basic Syntax

ArrayGen uses a powerful expression language with mathematical functions:

```javascript
// Basic arithmetic
i * 2.5 + 1.0

// Trigonometric functions  
sin(i * 2 * pi / n)

// Exponential and logarithmic
exp(-i / n) * log(i + 1)

// Conditional expressions
i < n/2 ? 1.0 : 0.0
```

### Available Variables

| Variable | Description | Range |
|----------|-------------|-------|
| `i` | Current index | 0 to n-1 |
| `n` | Total array size | User-defined |
| `pi` | Pi constant | 3.14159... |
| `e` | Euler's number | 2.71828... |

### Mathematical Functions

| Function | Description | Example |
|----------|-------------|---------|
| `sin(x)`, `cos(x)`, `tan(x)` | Trigonometric | `sin(i * pi / n)` |
| `asin(x)`, `acos(x)`, `atan(x)` | Inverse trig | `asin(i / n * 2 - 1)` |
| `exp(x)`, `log(x)`, `log10(x)` | Exponential | `exp(-i / n)` |
| `sqrt(x)`, `pow(x,y)` | Power functions | `sqrt(i / n)` |
| `abs(x)`, `sign(x)` | Absolute/sign | `abs(sin(i * pi))` |
| `floor(x)`, `ceil(x)`, `round(x)` | Rounding | `floor(i / 4) * 0.25` |
| `min(a,b)`, `max(a,b)` | Min/max | `max(0, sin(i))` |

## Common Patterns

### Linear Sequences

Generate linear progressions:

```javascript
// Simple linear: 0, 1, 2, 3, ...
i

// Normalized linear: 0.0 to 1.0
i / (n - 1)

// Custom range: start to end  
start + i * (end - start) / (n - 1)
```

### Sinusoidal Waves

Create wave patterns:

```javascript
// Basic sine wave
sin(i * 2 * pi / n)

// Multiple cycles
sin(i * 2 * pi * cycles / n)

// Phase-shifted wave
sin(i * 2 * pi / n + phase)

// Amplitude modulation
amplitude * sin(i * 2 * pi / n)
```

### Exponential Patterns

Generate exponential curves:

```javascript
// Exponential growth
exp(i / n * growth_rate)

// Exponential decay
exp(-i / n * decay_rate)

// Logarithmic curve
log(i + 1) / log(n)
```

### Random-like Patterns

Create pseudo-random sequences:

```javascript
// Simple pseudo-random
sin(i * 17.3) * cos(i * 23.7)

// Noise-like pattern
sin(i * 12.9) + 0.5 * sin(i * 39.2) + 0.25 * sin(i * 67.1)
```

## Usage Examples

### Control Automation Arrays

Generate automation curves:

```
[ArrayGen] → [Automation Curve] → [Parameter Control]
    ↑
"sin(i * pi / n) * amplitude"
```

Example expressions:
- **Fade in**: `i / (n - 1)`
- **Fade out**: `(n - 1 - i) / (n - 1)`  
- **Bell curve**: `exp(-pow((i - n/2) / (n/4), 2))`
- **Sawtooth**: `(i % period) / period`

### Waveform Generation

Create custom waveforms:

```
[ArrayGen] → [Audio Buffer] → [Wavetable Synth]
    ↑
"sin(i * 2 * pi * harmonics / n) * (1 - i / n)"
```

### Visual Pattern Generation

Generate patterns for visuals:

```
[ArrayGen] → [LED Strip Control] → [Light Pattern]
    ↑
"max(0, sin(i * 2 * pi / n + time)) * brightness"
```

### Scientific Data Simulation

Create synthetic datasets:

```
[ArrayGen] → [Data Analysis] → [Scientific Visualization]
    ↑
"amplitude * exp(-i / tau) * sin(omega * i + phi) + noise"
```

## Advanced Techniques

### Multi-variable Expressions

Use custom variables for parameterization:

```javascript
// With variables: frequency, amplitude, phase
amplitude * sin(i * 2 * pi * frequency / n + phase)

// Combine multiple parameters
base_value + variation * cos(i * rate + offset)
```

### Conditional Logic

Create complex patterns with conditions:

```javascript
// Alternating pattern
i % 2 == 0 ? value_a : value_b

// Threshold-based
i < threshold ? rising_value : falling_value

// Multi-step pattern
i < n/3 ? step1 : i < 2*n/3 ? step2 : step3
```

### Recursive Patterns

Build on previous values (with care):

```javascript
// Simple accumulation pattern
i == 0 ? 0 : prev_value + increment

// Fibonacci-like sequences
i < 2 ? 1 : fib(i-1) + fib(i-2)
```

## Live Coding & Real-time Editing

### Interactive Development

1. **Enable Live Editing** in parameters
2. **Modify expressions** in the text editor
3. **Press Ctrl+Enter** to update array
4. **See results immediately** in connected processes

### Expression Debugging

Monitor expression evaluation:
- **Check array output** in the inspector
- **Verify min/max ranges** make sense
- **Test with small array sizes** first
- **Use simple expressions** to debug complex ones

## Performance Considerations

### Expression Complexity

- **Simple expressions** evaluate faster
- **Avoid complex nested functions** for large arrays
- **Cache expensive calculations** when possible
- **Use appropriate array sizes** for real-time use

### Memory Usage

- **Large arrays** consume more memory
- **Consider streaming** for very large datasets
- **Clean up unused arrays** regularly
- **Monitor memory usage** in system

### Update Frequency

- **Limit updates** for performance-critical applications
- **Use rate limiting** if expressions change rapidly
- **Consider pre-computation** for static patterns
- **Optimize for your use case**

## Integration Examples

### Audio Synthesis

Generate wavetables and envelopes:

```
[ArrayGen: sine wave] → [Wavetable Oscillator] → [Audio Output]
[ArrayGen: ADSR envelope] → [Amplitude Modulation]
```

### Visual Effects

Create animation sequences:

```
[ArrayGen: position curve] → [Object Animation] → [Visual Display]
[ArrayGen: color gradient] → [Color Mapping] → [LED Control]
```

### Control Systems

Generate control sequences:

```
[ArrayGen: timing pattern] → [Sequence Trigger] → [System Control]
[ArrayGen: parameter sweep] → [Device Control] → [Automated Testing]
```

### Data Processing

Create reference data:

```
[ArrayGen: calibration curve] → [Sensor Calibration] → [Accurate Readings]
[ArrayGen: lookup table] → [Data Transformation] → [Processed Output]
```

## Best Practices

### Expression Design
1. **Start simple** and build complexity gradually
2. **Test with small arrays** before scaling up
3. **Use meaningful variable names**
4. **Comment complex expressions** for future reference

### Performance Optimization
1. **Choose appropriate array sizes** for your application
2. **Avoid unnecessary updates** of static patterns
3. **Use simpler expressions** for real-time applications
4. **Profile performance** with large datasets

### Pattern Creation
1. **Normalize values** to appropriate ranges (0-1, -1 to 1)
2. **Consider edge cases** (division by zero, etc.)
3. **Test boundary conditions** (first and last elements)
4. **Verify pattern continuity** if needed

## Troubleshooting

### Expression Errors
- **Check syntax** for typos and missing operators
- **Verify function names** are correct
- **Ensure parentheses** are balanced
- **Test with simple expressions** first

### Performance Issues
- **Reduce array size** if updates are slow
- **Simplify expressions** for better performance
- **Check for infinite loops** or recursive calls
- **Monitor CPU usage** during generation

### Unexpected Results
- **Verify variable ranges** (i, n, custom variables)
- **Check mathematical logic** in expressions
- **Test edge cases** (i=0, i=n-1)
- **Use debugging expressions** to isolate issues

## Related Processes

- [Array Utilities](/processes/array-utilities.html) - Array manipulation
- [ExprTk](/processes/exprtk.html) - Expression evaluation
- [JavaScript](/processes/javascript.html) - Advanced scripting
- [Automation](/processes/automation.html) - Parameter automation