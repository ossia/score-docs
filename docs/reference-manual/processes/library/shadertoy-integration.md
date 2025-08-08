---
layout: default

title: Shadertoy Integration
description: "Import and use Shadertoy shaders directly in score"

parent: Processes
grand_parent: Reference

permalink: /processes/shadertoy-integration.html
---
# Shadertoy Integration

![Shadertoy Integration]({{ site.img }}/reference/processes/shadertoy.png "Shadertoy to ISF Conversion")

ossia score now supports direct integration with Shadertoy, the popular online shader development platform. You can drag and drop Shadertoy URLs directly into your score, and they will be automatically converted to ISF format for use in the graphics pipeline.

## Overview

Shadertoy integration enables:
- Direct import of Shadertoy shaders via URL
- Automatic conversion to ISF (Interactive Shader Format)
- Preservation of shader parameters and inputs
- Real-time parameter control
- Integration with score's media pipeline

## How It Works

The integration process:
1. **URL Detection**: Drag a Shadertoy URL into score
2. **Automatic Download**: Shader source is fetched from Shadertoy
3. **Conversion**: GLSL code is converted to ISF format
4. **Parameter Mapping**: Uniforms become controllable parameters
5. **Integration**: Shader appears as standard ISF process

## Supported Shadertoy Features

### Core Features
- Fragment shader conversion
- Uniform parameter mapping
- Time-based animations
- Resolution handling
- Mouse input conversion

### Limitations
- Multi-pass shaders require manual conversion
- Some Shadertoy-specific features may not translate directly
- 3D textures and complex samplers need adjustment
- Audio input requires additional setup

## Usage

### Direct URL Import

1. **Find Shader**: Browse [Shadertoy](https://www.shadertoy.com/)
2. **Copy URL**: Copy the shader's URL (e.g., https://www.shadertoy.com/view/XsX3RB)
3. **Drag to Score**: Drag the URL directly into your score timeline
4. **Automatic Conversion**: score converts and creates ISF shader process

### URL Formats Supported

- Direct shader URLs: `https://www.shadertoy.com/view/XXXXXX`
- Embed URLs: `https://www.shadertoy.com/embed/XXXXXX`
- Preview URLs with parameters

### Parameter Mapping

Common Shadertoy uniforms are automatically converted:

| Shadertoy | ISF Equivalent | Description |
|-----------|----------------|-------------|
| iTime | TIME | Animation time |
| iResolution | RENDERSIZE | Output resolution |
| iMouse | Mouse Position | Mouse coordinates |
| iFrame | Frame Counter | Frame count |
| iDate | Date/Time | System date/time |

## Examples

### Basic Animation Shader

Import a simple animated shader:

```
URL: https://www.shadertoy.com/view/XsX3RB
Automatic conversion creates:
- Time parameter for animation
- Resolution parameter
- Color controls
```

### Interactive Shader

Import mouse-interactive effects:

```
URL: https://www.shadertoy.com/view/Ms2SD1
Creates:
- Mouse position control
- Interactive parameters
- Real-time responsiveness
```

### Generative Art

Complex generative shaders:

```
URL: https://www.shadertoy.com/view/4djSRW
Results in:
- Multiple parameter controls
- Animation controls  
- Complexity parameters
```

## Advanced Usage

### Custom Parameter Mapping

After import, you can:
1. Map score parameters to shader uniforms
2. Connect external controls (MIDI, OSC)
3. Automate parameters with LFOs
4. Create custom control interfaces

### Integration with Media Pipeline

Use converted shaders in complex chains:

```
[Video Input] → [Shadertoy Effect] → [Additional ISF] → [Output]
                      ↑
                [Parameter Control]
```

### Performance Optimization

For better performance:
- Test shader complexity before live use
- Use lower resolutions for complex shaders
- Implement LOD (Level of Detail) controls
- Monitor GPU usage

## Manual Conversion Tips

For shaders that don't convert automatically:

### Multi-pass Shaders

1. Identify render passes
2. Create separate ISF shaders for each pass
3. Chain them in score
4. Share buffer textures between passes

### Custom Inputs

Convert custom Shadertoy inputs:

```glsl
// Shadertoy
uniform sampler2D iChannel0;

// ISF equivalent
/*{
    "INPUTS": [
        {"NAME": "inputImage", "TYPE": "image"}
    ]
}*/
uniform sampler2D inputImage;
```

### Audio Integration

Connect audio analysis to shader parameters:

```
[Audio Input] → [FFT Analysis] → [Shader Parameters]
[Beat Detection] → [Trigger] → [Shader Events]
```

## Common Conversion Issues

### Performance Problems
- **Issue**: Shader too complex for real-time
- **Solution**: Simplify algorithm, reduce iterations, use lower precision

### Parameter Mismatches
- **Issue**: Controls don't work as expected
- **Solution**: Check uniform name mapping, adjust ranges

### Visual Differences
- **Issue**: Colors or effects look different
- **Solution**: Check color space, coordinate system differences

### Missing Features
- **Issue**: Some effects missing after conversion
- **Solution**: Manual adjustment of complex features

## Best Practices

### Selection Criteria
1. **Complexity**: Choose appropriate complexity for your hardware
2. **Interactivity**: Prefer shaders with useful parameters
3. **Performance**: Test thoroughly before live use
4. **Licensing**: Respect shader creator's license terms

### Optimization
1. **Preview First**: Test shaders in development environment
2. **Parameter Limits**: Set reasonable parameter ranges
3. **Resolution Control**: Implement dynamic resolution scaling
4. **GPU Monitoring**: Watch temperature and usage

### Integration
1. **Naming**: Use descriptive names for converted shaders
2. **Documentation**: Document parameter meanings
3. **Presets**: Save useful parameter combinations
4. **Version Control**: Track shader modifications

## Troubleshooting

### Import Issues
- **URL not recognized**: Check URL format, ensure public shader
- **Conversion fails**: Try manual download and conversion
- **Missing parameters**: Check original shader code

### Runtime Issues
- **Poor performance**: Reduce resolution, simplify parameters
- **Visual glitches**: Check GPU driver updates
- **Crashes**: Monitor GPU memory usage

## Creative Applications

### Live Visuals
- Music-reactive backgrounds
- Real-time shader morphing
- Interactive installation visuals

### Video Processing
- Custom video effects chains
- Real-time style transfer
- Artistic video filters

### Generative Content
- Procedural textures
- Dynamic backgrounds
- Algorithmic art

## Community Resources

### Popular Shadertoy Artists
- iq (Íñigo Quílez) - Technical demos
- BigWings - Artistic effects
- Shane - Creative experiments
- FabriceNeyret2 - Educational shaders

### Collections
- Educational shaders for learning
- Performance-optimized effects
- Interactive examples
- Audio-reactive shaders

## Related Documentation

- [ISF Shaders](/processes/shaders.html) - General shader documentation
- [Graphics Pipeline](/in-depth/graphics-pipeline.html) - Understanding score's graphics
- [Live Coding](/common-practices/8-live-coding.html) - Shader live coding
- [Video Processing](/processes/video.html) - Video effects pipeline