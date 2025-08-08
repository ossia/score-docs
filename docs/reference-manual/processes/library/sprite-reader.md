---
layout: default

title: Sprite Reader
description: "Extract sprites from sprite sheets for retro-style animations"

parent: Processes
grand_parent: Reference

permalink: /processes/sprite-reader.html
---
# Sprite Reader

![Sprite Reader]({{ site.img }}/reference/processes/sprite-reader.png "Sprite Reader") 

The Sprite Reader process extracts individual sprites from sprite sheets, enabling retro-style animations and efficient texture usage. Perfect for game development aesthetics, pixel art animations, and nostalgic visual effects.

## Overview

Sprite Reader enables:
- **Sprite sheet parsing** - Extract individual frames from grid-based sprite sheets
- **Animation control** - Navigate through sprites with percentage-based control
- **Retro gaming aesthetics** - Perfect for 8-bit and 16-bit style visuals
- **Efficient texture usage** - Pack multiple sprites into single texture files
- **Real-time animation** - Drive sprite selection with automations or external controls

## Parameters

### Image
**Type**: File input  
**Supported formats**: PNG, JPEG, GIF, BMP
**Description**: The sprite sheet image file containing the grid of sprites

### Sprite Size
**Type**: XY Spinboxes (integers)  
**Default**: 32x32  
**Range**: 1-1024 pixels

Sets the dimensions of each individual sprite in the sheet. All sprites must be the same size and arranged in a regular grid.

### Image Count
**Type**: Horizontal slider (0.0 - 1.0)  
**Default**: 0.0

Controls which sprite to display as a percentage through the total sprite count:
- **0.0** = First sprite (top-left)
- **0.5** = Middle sprite
- **1.0** = Last sprite (bottom-right)

## Output

### Out
**Type**: Texture output  
**Content**: Current selected sprite as GPU texture

Provides the extracted sprite as a texture ready for use in the graphics pipeline.

## How It Works

The Sprite Reader automatically calculates the sprite grid layout:

1. **Grid Detection**: Divides the image by sprite size to determine rows and columns
2. **Sprite Indexing**: Numbers sprites from left-to-right, top-to-bottom
3. **Percentage Mapping**: Maps the 0.0-1.0 input range to sprite indices
4. **Extraction**: Copies the selected sprite region to output texture

### Example Grid Layout
```
Sprite Sheet (128x64, 32x32 sprites):
┌──────┬──────┬──────┬──────┐
│  0   │  1   │  2   │  3   │  
├──────┼──────┼──────┼──────┤
│  4   │  5   │  6   │  7   │  
└──────┴──────┴──────┴──────┘

Percentage → Sprite:
0.0 → 0, 0.125 → 1, 0.25 → 2, etc.
```

## Usage Examples

### Character Animation
```
[Character Sprite Sheet] → [Sprite Reader] → [Video Output]
                              ↑
                    [LFO] → [Image Count]
```

Animate a character by cycling through walk/run sprites using an LFO.

### Interactive Sprite Selection
```
[OSC Controller] → [Sprite Reader] → [ISF Shader]
                       ↑
                [Image Count Control]
```

Let users select different character states or expressions via external control.

### Retro Game UI
```
[UI Sprite Sheet] → [Sprite Reader] → [UI Overlay]
                        ↑
                [Button State Logic]
```

Display different button states (normal, hover, pressed) based on interaction.

### Pixel Art Animation
```
[Animation Sprites] → [Sprite Reader] → [Pixel Art Effect]
                          ↑
                [Tempo-synced Automation]
```

Create tempo-synchronized pixel art animations for music visualization.

## Sprite Sheet Preparation

### Best Practices
- **Uniform sizing**: All sprites must be exactly the same dimensions
- **Grid alignment**: Sprites should align perfectly to a regular grid
- **No spacing**: Avoid gaps between sprites (0-pixel spacing)
- **Power-of-2 dimensions**: Use 32x32, 64x64, 128x128 for optimal GPU performance
- **Consistent style**: Maintain visual consistency across all sprites

### Common Sprite Sizes
- **8x8**: Tiny icons, simple pixel art
- **16x16**: Classic retro game sprites
- **32x32**: Standard indie game characters
- **64x64**: Detailed character sprites
- **128x128**: High-resolution sprites

### File Format Tips
- **PNG**: Best for pixel art with transparency
- **JPEG**: Acceptable for photos but avoid for pixel art
- **Use transparency**: PNG alpha channel for transparent backgrounds

## Animation Techniques

### Linear Animation
Map a linear automation to Image Count for smooth sprite progression:
```
Timeline Automation: 0.0 → 1.0 over time
Result: Plays all sprites in sequence
```

### Looping Animation
Use modulo-like behavior by restricting the range:
```
LFO (Triangle) → Scale (0.0-0.8) → Image Count
Result: Loops through first 80% of sprites
```

### State-based Animation
Use conditional logic to select sprite ranges:
```
Game State → Logic → Sprite Range Selection → Image Count
```

### Beat-synchronized Animation
```
Tempo → Beat Counter → Sprite Selection → Image Count
```

## Performance Considerations

### Optimization Tips
- **Texture size**: Keep sprite sheets reasonably sized (2048x2048 max recommended)
- **Sprite count**: More sprites = more precise animation but larger memory usage
- **Format choice**: PNG compression can reduce file size significantly
- **GPU memory**: Large sprite sheets consume more VRAM

### Memory Usage
- **Formula**: Width × Height × 4 bytes (RGBA) = memory per sprite sheet
- **Example**: 512×512 sprite sheet = ~1MB GPU memory
- **Recommendation**: Monitor total texture memory usage in complex projects

## Integration Examples

### Game Development Pipeline
```
Art Software → Export Sprite Sheet → Sprite Reader → Game Logic
```

### VJ Performance Setup
```
Multiple Sprite Sheets → Sprite Readers → Mixer → Output
                            ↑
                    MIDI Controller Input
```

### Educational Content
```
Educational Sprites → Sprite Reader → Interactive Learning App
                         ↑
                Student Input Control
```

## Troubleshooting

### Common Issues
- **Blank output**: Check that Image Count is within 0.0-1.0 range
- **Wrong sprites**: Verify Sprite Size matches your sprite sheet grid
- **Distorted sprites**: Ensure sprites are perfectly aligned in source image
- **Performance issues**: Reduce sprite sheet size or sprite count

### Grid Calculation Problems
- **Missing sprites**: Check if image dimensions are exactly divisible by sprite size
- **Incorrect indexing**: Verify sprite layout follows left-to-right, top-to-bottom order
- **Border artifacts**: Ensure no spacing between sprites in source image

## Related Processes

- **Image Process**: Load and display static images
- **Video**: Play video files frame by frame
- **ISF Shader**: Apply effects to sprite output
- **Texture Generator**: Create procedural sprite-like textures

## Technical Implementation

The Sprite Reader uses Qt's QImage for image processing, providing reliable cross-platform image loading and manipulation. The process efficiently extracts sprite regions without copying the entire source image to GPU memory.