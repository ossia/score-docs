---
layout: default

title: Lightness Computer
description: "Extract luminance values from shaders for control purposes"

parent: Processes
grand_parent: Reference

permalink: /processes/lightness-computer.html
---
# Lightness Computer

![Lightness Computer]({{ site.img }}/reference/processes/lightness-computer.png "Lightness Computer Process")

The Lightness Computer renders an input shader and extracts luminance (brightness) values from the result, converting visual information into control data. This enables using visual shaders as sources of control values for other parameters, creating powerful feedback loops between graphics and control systems.

## Overview

Lightness Computer enables:
- **Visual-to-control conversion** from any shader or graphics source
- **Luminance extraction** from rendered graphics
- **Real-time brightness analysis** with GPU acceleration
- **Multi-point sampling** for complex control scenarios  
- **Integration between graphics and control** domains
- **Creative feedback loops** in audio-visual systems

Perfect for:
- Audio-reactive visuals that also control audio
- Lighting control based on visual content
- Feedback systems between graphics and parameters
- Creative control interfaces using visual elements
- Scientific visualization with control output

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Shader/Texture | Texture | Input visual content to analyze |
| Sample Points | Array | Coordinates where to sample luminance |
| Threshold | Float | Minimum luminance threshold |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Luminance | Float Array | Extracted brightness values |
| Average | Float | Overall average brightness |
| Peak | Float | Maximum brightness value |
| Statistics | Object | Detailed luminance statistics |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Sample Mode | Dropdown | How to extract values | "Grid" | Grid, Points, Average |
| Grid Size | Integer | Grid resolution | 8 | 1-64 |
| Sample Count | Integer | Number of sample points | 16 | 1-256 |
| Update Rate | Dropdown | Analysis frequency | "30 FPS" | 1-60 FPS |
| Color Space | Dropdown | Luminance calculation | "RGB" | RGB, HSV, Lab |

## Sampling Modes

### Grid Mode
Samples luminance at regular grid intervals:
- **Grid Size**: 8x8 creates 64 sample points
- **Uniform distribution** across the entire image
- **Consistent sampling** for regular patterns
- **Good for overall analysis** and general control

### Points Mode  
Samples at specific coordinate locations:
- **Custom coordinates** via Sample Points input
- **Precise control** over sampling locations
- **Variable number** of sample points
- **Ideal for tracking** specific visual elements

### Average Mode
Computes overall image statistics:
- **Single average value** for entire image
- **Peak brightness detection**
- **Statistical analysis** (min, max, variance)
- **Efficient for simple** brightness control

## Luminance Calculation

### RGB Luminance (Default)
Standard luminance calculation:
```
Luminance = 0.299*R + 0.587*G + 0.114*B
```
- **Perceptually accurate** brightness
- **Standard in video** and graphics applications
- **Compatible with** most color processing

### HSV Value
Uses the Value component from HSV:
```
Luminance = max(R, G, B)
```
- **Raw brightness** without color weighting
- **Useful for color-independent** analysis
- **Simple maximum** of color components

### Lab Lightness
Uses CIE Lab color space L* component:
- **Perceptually uniform** lightness
- **Scientific accuracy** for color analysis
- **Advanced color science** applications

## Usage Examples

### Audio-Reactive Graphics with Feedback

Create feedback between audio, visuals, and control:

```
[Audio] → [FFT] → [Shader Parameters] → [Visual Shader]
                                             ↓
[Control Feedback] ← [Lightness Computer] ←┘
    ↓
[Audio Effects Parameters]
```

### Lighting Control from Visuals

Drive physical lighting based on screen content:

```
[Video Content] → [Color Processing] → [Lightness Computer] → [DMX Values]
                                                           → [LED Strip Control]
                                                           → [Stage Lighting]
```

### Interactive Visual Instrument

Use visual feedback for musical control:

```
[MIDI Input] → [Visual Response] → [Shader] → [Lightness Computer] → [Synth Parameters]
                                                                   → [Effect Controls]
                                                                   → [MIDI Feedback]
```

### Scientific Visualization Analysis

Extract quantitative data from visualizations:

```
[Scientific Data] → [3D Visualization] → [Lightness Computer] → [Data Analysis]
                                                              → [Statistical Output]
                                                              → [Control Systems]
```

## Advanced Sampling Techniques

### Region-based Analysis

Sample different screen regions for different controls:

```
[Shader] → [Lightness Computer] → [Left Region] → [Left Channel Volume]
                               → [Right Region] → [Right Channel Volume]  
                               → [Center Region] → [Bass Control]
```

Configure sample points:
```
Left Region:   [(0.1, 0.3), (0.4, 0.7)]   # Left side sampling
Right Region:  [(0.6, 0.3), (0.9, 0.7)]   # Right side sampling  
Center Region: [(0.4, 0.4), (0.6, 0.6)]   # Center sampling
```

### Temporal Analysis

Track brightness changes over time:

```
[Current Luminance] → [Delay] → [Difference Calculator] → [Change Rate]
                  → [Running Average] → [Trend Analysis]
                  → [Peak Detection] → [Event Triggers]
```

### Multi-scale Analysis

Use different grid sizes for different purposes:

```
[Shader] → [Lightness Computer 4x4] → [Global Control]
        → [Lightness Computer 16x16] → [Detailed Control] 
        → [Lightness Computer 64x64] → [Precise Control]
```

## Integration with Graphics Pipeline

### Shader-based Sources

Work with various graphics sources:

```
[ISF Shader] → [Lightness Computer] → [Control Output]
[Video File] → [Lightness Computer] → [Control Output]
[Camera Input] → [Lightness Computer] → [Control Output]
[Generated Graphics] → [Lightness Computer] → [Control Output]
```

### Multi-stage Processing

Chain multiple analysis stages:

```
[Raw Shader] → [Color Correction] → [Lightness Computer] → [Filtered Control]
                                  → [Edge Detection] → [Feature Control]
                                  → [Blur Filter] → [Smooth Control]
```

### Real-time Performance

Optimize for live performance:
- **Lower update rates** (15-30 FPS) for non-critical control
- **Smaller grid sizes** (4x4, 8x8) for better performance  
- **GPU acceleration** for all luminance calculations
- **Efficient sampling** strategies

## Creative Applications

### Generative Feedback Systems

Create evolving visual-control systems:

```
[Noise Generator] → [Evolving Shader] → [Lightness Computer] → [Shader Parameters]
                                                           → [Audio Synthesis]
                                                           → [Light Control]
```

### Interactive Installations

Respond to environmental changes:

```
[Camera Feed] → [Motion Detection] → [Visual Response] → [Lightness Computer] → [Environment Control]
```

### Performance Instruments

Build visual performance tools:

```
[Performer Input] → [Visual Synthesis] → [Lightness Computer] → [Musical Output]
                                                             → [Visual Feedback]
                                                             → [Lighting Design]
```

### Data Sonification

Convert visual data analysis to sound:

```
[Data Visualization] → [Lightness Computer] → [Frequency Mapping] → [Audio Synthesis]
                                           → [Amplitude Control] → [Sound Design]
```

## Performance Optimization

### GPU Efficiency

Maximize graphics performance:
- **Use appropriate texture sizes** for analysis
- **Limit update frequency** to necessary rates
- **Choose efficient sampling** patterns
- **Minimize GPU-CPU transfers**

### Sample Count Optimization

Balance detail vs performance:
- **4x4 grid (16 samples)**: Basic control, low CPU
- **8x8 grid (64 samples)**: Good detail, moderate CPU  
- **16x16 grid (256 samples)**: High detail, higher CPU
- **Custom points**: Optimized for specific needs

### Update Rate Management

Choose appropriate refresh rates:
- **60 FPS**: Smooth real-time response
- **30 FPS**: Good for most applications
- **15 FPS**: Adequate for slow-changing controls
- **Variable rate**: Based on content complexity

## Best Practices

### Sampling Strategy
1. **Start with simple grid sampling** for basic applications
2. **Use point sampling** for tracking specific features
3. **Combine multiple sample modes** for complex control
4. **Test different grid sizes** for optimal performance

### Control Mapping
1. **Scale luminance values** to appropriate control ranges
2. **Apply smoothing** to reduce jitter in control signals
3. **Use thresholds** to ignore noise and small variations
4. **Implement hysteresis** for stable switching behavior

### Performance Management
1. **Monitor GPU usage** during development
2. **Profile different sampling configurations**
3. **Use lower update rates** when possible
4. **Consider batch processing** for multiple analyses

### Visual Design
1. **Design shaders** with control output in mind
2. **Consider contrast and brightness** for reliable control
3. **Use clear visual patterns** for predictable control
4. **Test under different** lighting and display conditions

## Troubleshooting

### Control Signal Issues
- **Check sampling locations** are in visible areas
- **Verify luminance calculation method** is appropriate
- **Test with high-contrast visuals** first
- **Monitor sample values** in inspector

### Performance Problems
- **Reduce grid size** or sample count
- **Lower update rate** for less critical applications
- **Check GPU usage** and optimize graphics pipeline
- **Consider simpler shaders** for analysis sources

### Unstable Control
- **Add smoothing/filtering** to control outputs
- **Use appropriate thresholds** to ignore noise
- **Check for visual flickering** in source material
- **Implement rate limiting** for rapid changes

### Integration Issues
- **Verify texture formats** are compatible
- **Check coordinate systems** match expectations
- **Test with known visual patterns** first
- **Validate control value ranges** are appropriate

## Related Processes

- [Analysis](/processes/analysis.html) - Audio analysis and feature extraction
- [Computer Vision](/processes/computer-vision-utilities.html) - Advanced image analysis
- [Shader](/processes/shaders.html) - Graphics shader processing
- [Object Filter](/processes/object-filter.html) - Data extraction and filtering