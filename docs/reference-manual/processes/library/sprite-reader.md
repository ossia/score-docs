---
layout: default

title: Sprite Reader
description: "Extract sprites from sprite sheets for retro-style animations"

parent: Processes
grand_parent: Reference

permalink: /processes/sprite-reader.html
---
# Sprite Reader

![Sprite Reader]({{ site.img }}/reference/processes/sprite-reader.gif "Sprite Reader") 

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

For instance, you can create tempo-synchronized pixel art animations for music visualization.

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



## Try it!

Try it by downloading this [simple example!]({{ site.scores }}/reference/processes/sprite-reader.score)