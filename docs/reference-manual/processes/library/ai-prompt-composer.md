---
layout: default

title: AI Prompt Composer
description: "Compose and manipulate AI prompts dynamically"

parent: Processes
grand_parent: Reference

permalink: /processes/ai-prompt-composer.html
---
# AI Prompt Composer

![AI Prompt Composer]({{ site.img }}/reference/processes/ai-prompt-composer.png "AI Prompt Composer")

The AI Prompt Composer allows you to dynamically create and manipulate prompts for AI models. This is particularly useful for creating interactive installations where prompts can be modified in real-time based on user input or sensor data.

## Overview

The Prompt Composer process provides a structured way to build complex prompts from multiple components, allowing for dynamic composition and interpolation between different prompt states.

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Base Prompt | String | The foundation prompt text |
| Style | String | Style modifiers (e.g., "photorealistic", "abstract") |
| Subject | String | Main subject of the prompt |
| Modifiers | String Array | Additional descriptive modifiers |
| Weight | Float (0-1) | Influence weight for interpolation |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Composed Prompt | String | The final composed prompt |
| Token Count | Integer | Number of tokens in the prompt |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Template | Dropdown | Prompt composition template | "Standard" | Standard, Detailed, Minimal |
| Separator | Text | Text to separate components | ", " | - |
| Max Length | Integer | Maximum prompt length | 256 | 1-1024 |
| Format | Dropdown | Output format | "Plain" | Plain, Weighted, Structured |

## Usage Examples

### Basic Prompt Composition

Connect text inputs to compose a dynamic prompt:

1. Set Base Prompt: "A beautiful landscape"
2. Add Style: "impressionist painting"
3. Add Subject: "mountain range at sunset"
4. Add Modifiers: ["dramatic lighting", "vibrant colors"]

Result: "A beautiful landscape, impressionist painting, mountain range at sunset, dramatic lighting, vibrant colors"

### Interactive Installation

Use sensor data to modify prompts in real-time:

1. Connect motion sensors to the Modifiers input
2. Map sensor values to descriptive terms
3. Use the composed prompt with image generation models

### Prompt Interpolation

The Prompt Composer can work with the [AI Prompt Interpolator](/processes/ai-prompt-interpolator.html) to smoothly transition between different prompt states.

## Best Practices

- **Token Limits**: Monitor the Token Count output to ensure prompts stay within model limits
- **Consistency**: Use templates to maintain consistent prompt structure
- **Performance**: For real-time applications, limit the update rate using a [Rate Limiter](/processes/rate-limiter.html)

## Integration with AI Models

The Prompt Composer output can be connected to:
- Text-to-image models (Stable Diffusion, DALL-E)
- Large Language Models (GPT, Claude)
- Multi-modal models

## Related Processes

- [AI Prompt Interpolator](/processes/ai-prompt-interpolator.html) - Smooth transitions between prompts
- [String](/processes/string.html) - Basic string manipulation
- [Array Utilities](/processes/array-utilities.html) - Array manipulation for modifiers