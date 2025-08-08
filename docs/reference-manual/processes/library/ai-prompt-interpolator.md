---
layout: default

title: AI Prompt Interpolator
description: "Smoothly interpolate between different AI prompts"

parent: Processes
grand_parent: Reference

permalink: /processes/ai-prompt-interpolator.html
---
# AI Prompt Interpolator

![AI Prompt Interpolator]({{ site.img }}/reference/processes/ai-prompt-interpolator.png "AI Prompt Interpolator")

The AI Prompt Interpolator enables smooth transitions between different prompts, creating dynamic and evolving AI-generated content. This is essential for creating fluid, generative experiences where prompts gradually transform over time.

## Overview

This process intelligently blends between multiple prompts while maintaining semantic coherence. It's particularly useful for:
- Generative art installations with evolving themes
- Live performances with gradual style transitions
- Interactive experiences responding to user input

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Prompt A | String | First prompt state |
| Prompt B | String | Second prompt state |
| Position | Float (0-1) | Interpolation position between prompts |
| Additional Prompts | String Array | Optional additional prompt states |
| Weights | Float Array | Weights for multi-prompt interpolation |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Interpolated | String | The interpolated prompt |
| Components | String Array | Individual components being blended |
| Blend Info | Object | Detailed blend information |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Mode | Dropdown | Interpolation method | "Semantic" | Linear, Semantic, Weighted |
| Smoothing | Float | Transition smoothness | 0.5 | 0.0-1.0 |
| Preserve Structure | Toggle | Maintain prompt structure | On | On/Off |
| Component Mode | Dropdown | How to handle components | "Blend" | Blend, Switch, Morph |

## Interpolation Modes

### Linear
Simple word-by-word blending based on position.

### Semantic
Intelligent blending that preserves meaning and context.

### Weighted
Multi-dimensional interpolation using weight vectors.

## Usage Examples

### Style Morphing

Gradually transition between artistic styles:

```
Prompt A: "Portrait in the style of Van Gogh, swirling brushstrokes"
Prompt B: "Portrait in the style of Picasso, geometric shapes"
Position: 0.5
Result: "Portrait in a hybrid style, expressive brushwork with angular features"
```

### Time-based Evolution

Connect an [LFO](/processes/lfo.html) to the Position input for automatic cycling:

1. LFO frequency: 0.1 Hz (10-second cycle)
2. Prompt A: "Sunrise over calm ocean"
3. Prompt B: "Sunset over stormy seas"

### Multi-prompt Blending

Use Additional Prompts for complex interpolations:

1. Define multiple prompt states
2. Use Weights array to control influence
3. Create multi-dimensional prompt spaces

## Advanced Techniques

### Prompt Space Navigation

Use with the [Nodes](/processes/nodes.html) process to navigate through multiple prompt states in 2D space.

### Latent Space Control

Combine with the [Interpolator](/processes/interpolator.html) process to control both prompts and latent space simultaneously.

## Performance Considerations

- **Update Rate**: Limit updates for API-based models
- **Caching**: The process caches intermediate states
- **Batch Processing**: Multiple interpolations can be computed in parallel

## Best Practices

1. **Semantic Consistency**: Keep prompts semantically related for smooth transitions
2. **Component Alignment**: Structure prompts similarly for better blending
3. **Testing**: Preview interpolations before live use

## Integration Examples

### With Image Generation

```
[LFO] → [Prompt Interpolator] → [Stable Diffusion]
         ↑                        ↓
    [Prompt Composer]        [Window Device]
```

### Interactive Control

```
[MIDI Controller] → [Mapping] → [Prompt Interpolator]
                                         ↓
                                  [Text Generation]
```

## Related Processes

- [AI Prompt Composer](/processes/ai-prompt-composer.html) - Create structured prompts
- [Interpolator](/processes/interpolator.html) - General value interpolation
- [Tweener](/processes/tweener.html) - Advanced easing functions
- [Nodes](/processes/nodes.html) - 2D interpolation space