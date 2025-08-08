---
layout: default

title: Combine & Spread
description: "Array manipulation utilities for combining and spreading values"

parent: Processes
grand_parent: Reference

permalink: /processes/combine-spread.html
---
# Combine & Spread

![Combine & Spread]({{ site.img }}/reference/processes/combine-spread.png "Combine & Spread Processes")

The Combine and Spread processes provide essential array manipulation capabilities for processing and recombining values into arrays. They enable flexible data flow patterns, allowing you to collect individual values into arrays (Combine) or distribute array elements to individual outputs (Spread).

## Overview

These complementary processes enable:
- **Value aggregation** (Combine) - Collect multiple inputs into arrays
- **Value distribution** (Spread) - Extract array elements to individual outputs  
- **Dynamic array processing** with variable input/output counts
- **Flexible data routing** for complex processing chains
- **Real-time array manipulation** for live performances
- **Pattern organization** for structured data flows

Perfect for:
- Data collection and distribution
- Multi-channel processing
- Pattern sequencing and organization
- Complex routing scenarios
- Scientific data processing

## Combine Process

### Purpose
The Combine process aggregates multiple individual inputs into a single array output.

### Inputs (Dynamic)
| Port | Type | Description |
|------|------|-------------|
| Input 1 | Any | First value to combine |
| Input 2 | Any | Second value to combine |
| Input N | Any | Additional inputs (expandable) |

### Outputs
| Port | Type | Description |
|------|------|-------------|
| Array | Array | Combined array of all inputs |
| Count | Integer | Number of elements in array |

### Parameters
| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Input Count | Integer | Number of inputs | 3 | 2-32 |
| Array Type | Dropdown | Output array type | "Float" | Float, Integer, String |
| Auto-size | Toggle | Automatically adjust input count | Off | On/Off |

## Spread Process

### Purpose  
The Spread process distributes elements of an input array to individual outputs.

### Inputs
| Port | Type | Description |
|------|------|-------------|
| Array | Array | Input array to spread |
| Count | Integer | Number of outputs to create |

### Outputs (Dynamic)
| Port | Type | Description |
|------|------|-------------|
| Output 1 | Any | First array element |
| Output 2 | Any | Second array element |
| Output N | Any | Additional outputs (expandable) |

### Parameters
| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Output Count | Integer | Number of outputs | 3 | 1-32 |
| Fill Mode | Dropdown | Behavior for missing elements | "Zero" | Zero, Repeat, Ignore |
| Type Conversion | Toggle | Convert types if needed | On | On/Off |

## Usage Patterns

### Basic Combine Example

Collect individual sensor readings:

```
[Temperature] → [Combine] → [Sensor Array] → [Data Logger]  
[Humidity]    →
[Pressure]    →
```

Result: `[23.5, 65.2, 1013.2]`

### Basic Spread Example

Distribute array elements to different controls:

```
[RGB Array] → [Spread] → [Red Channel]   → [LED Red]
                      → [Green Channel] → [LED Green]  
                      → [Blue Channel]  → [LED Blue]
```

Input: `[255, 128, 64]` → Outputs: `255`, `128`, `64`

### Round-trip Processing

Combine, process, then spread:

```
[A, B, C] → [Combine] → [Array Processing] → [Spread] → [A', B', C']
```

## Advanced Usage Examples

### Multi-channel Audio Processing

Process multiple audio channels:

```
[Audio L] → [Combine] → [Multi-channel Effect] → [Spread] → [Processed L]
[Audio R] →                                              → [Processed R]
[Audio C] →                                              → [Processed C]
```

### Sensor Data Collection

Aggregate distributed sensors:

```
[Sensor 1] → [Combine] → [Statistics] → [Min/Max/Avg Analysis]
[Sensor 2] →
[Sensor 3] →
[Sensor 4] →
```

### Pattern Distribution

Distribute generated patterns:

```
[Pattern Generator] → [Array of Values] → [Spread] → [Device 1]
                                                  → [Device 2] 
                                                  → [Device 3]
                                                  → [Device 4]
```

### Color Processing

Work with color components:

```
[H] → [Combine] → [HSV Array] → [HSV to RGB] → [RGB Array] → [Spread] → [R]
[S] →                                                                → [G]
[V] →                                                                → [B]
```

### Mathematical Operations

Perform vector operations:

```
[X1] → [Combine] → [Vector A] → [Dot Product] → [Scalar Result]
[Y1] →
[Z1] →

[X2] → [Combine] → [Vector B] →
[Y2] →
[Z2] →
```

## Data Flow Patterns

### Fan-out Pattern

One source to multiple destinations:

```
[Data Source] → [Generate Array] → [Spread] → [Output 1]
                                           → [Output 2]
                                           → [Output 3]
```

### Fan-in Pattern  

Multiple sources to one destination:

```
[Source 1] → [Combine] → [Aggregated Data] → [Processor]
[Source 2] →
[Source 3] →
```

### Processing Chain

Transform data through multiple stages:

```
[Inputs] → [Combine] → [Process Array] → [Spread] → [Individual Processing] → [Outputs]
```

### Parallel Processing

Process multiple streams in parallel:

```
[Stream A] → [Combine] → [Parallel Processor] → [Spread] → [Result A]
[Stream B] →                                            → [Result B]  
[Stream C] →                                            → [Result C]
```

## Fill Modes (Spread Process)

When the input array has fewer elements than outputs:

### Zero Fill
Missing elements become zero:
- Input: `[1, 2]` with 4 outputs
- Result: `1`, `2`, `0`, `0`

### Repeat Fill
Repeat the last element:
- Input: `[1, 2]` with 4 outputs  
- Result: `1`, `2`, `2`, `2`

### Ignore Fill
Extra outputs remain unchanged:
- Input: `[1, 2]` with 4 outputs
- Result: `1`, `2`, `<previous>`, `<previous>`

## Type Handling

### Automatic Conversion
Both processes can handle mixed types:
- **Combine**: Converts inputs to common type
- **Spread**: Converts array elements to output types

### Type Compatibility
| Input Type | Array Type | Output Type |
|------------|------------|-------------|
| Float | Float Array | Float |
| Integer | Integer Array | Integer |
| String | String Array | String |
| Mixed | Float Array | Float (converted) |

## Performance Considerations

### Array Size Optimization
- **Limit array sizes** to reasonable ranges
- **Consider memory usage** for large arrays
- **Use appropriate data types** for your application
- **Clean up unused arrays** regularly

### Update Frequency
- **Rate limit** rapid changes if not needed
- **Batch updates** when possible
- **Consider processing chains** vs individual updates
- **Monitor CPU usage** with complex routing

### Memory Efficiency
- **Avoid unnecessary copies** of large arrays
- **Use streaming** for very large datasets
- **Clean up intermediate results**
- **Consider data lifetime** in processing chains

## Integration Examples

### MIDI Processing

Handle multi-note MIDI data:

```
[MIDI Note 1] → [Combine] → [Chord Array] → [Harmonic Analysis] → [Spread] → [Voice 1]
[MIDI Note 2] →                                                             → [Voice 2]
[MIDI Note 3] →                                                             → [Voice 3]
```

### OSC Message Processing

Aggregate OSC parameters:

```
[OSC /x] → [Combine] → [Position Array] → [3D Transform] → [Spread] → [X Transform]
[OSC /y] →                                                         → [Y Transform]
[OSC /z] →                                                         → [Z Transform]
```

### Lighting Control

Distribute lighting data:

```
[Light Pattern] → [Pattern Array] → [Spread] → [Light 1 Intensity]
                                            → [Light 2 Intensity]  
                                            → [Light 3 Intensity]
                                            → [Light N Intensity]
```

### Scientific Data Processing

Collect and analyze measurements:

```
[Measurement A] → [Combine] → [Dataset] → [Statistical Analysis] → [Spread] → [Mean]
[Measurement B] →                                                           → [StdDev]
[Measurement C] →                                                           → [Variance]
```

## Best Practices

### Data Organization
1. **Plan data flow** before connecting processes
2. **Use consistent naming** for related inputs/outputs
3. **Group related data** logically
4. **Document complex routing** for future reference

### Performance Optimization  
1. **Minimize unnecessary conversions** between types
2. **Use appropriate array sizes** for your application
3. **Consider update frequency** vs performance needs
4. **Profile complex processing chains**

### Error Handling
1. **Handle empty arrays** gracefully
2. **Check array bounds** in processing chains
3. **Provide default values** for missing data
4. **Test edge cases** thoroughly

### Pattern Design
1. **Keep data flows clear** and understandable
2. **Use descriptive parameter names**
3. **Group related operations** together
4. **Consider data lifetime** and cleanup

## Troubleshooting

### Array Size Mismatches
- **Check input/output counts** match expectations
- **Verify fill modes** for Spread process
- **Test with known array sizes** first
- **Use Count output** to verify array lengths

### Type Conversion Issues
- **Enable type conversion** if needed
- **Check data type compatibility**
- **Test with simple data** first
- **Verify conversion results** are as expected

### Performance Problems
- **Reduce array sizes** if processing is slow
- **Limit update frequency** for large arrays
- **Check for memory leaks** in long-running processes
- **Monitor system resources**

### Connection Problems
- **Verify port types** are compatible
- **Check dynamic port counts** are correct
- **Test with manual array creation** first
- **Validate data flow** step by step

## Related Processes

- [Array Utilities](/processes/array-utilities.html) - Additional array operations
- [ArrayGen](/processes/arraygen.html) - Array generation
- [Object Filter](/processes/object-filter.html) - Array element filtering
- [Pattern Combiner](/processes/pattern-combiner.html) - Pattern manipulation