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

Build dynamic AI prompts from multiple text inputs. Perfect for interactive installations where you want prompts to change based on sensor data, user input, or other real-time information.

This process takes separate text components and intelligently combines them into well-formed prompts for AI image generators, language models, or other prompt-based systems.

## How it works

You can feed text into multiple inputs that get intelligently combined:

**Base Prompt** - Your foundation text (e.g., "A beautiful landscape")  
**Style** - Style modifiers like "photorealistic" or "impressionist painting"  
**Subject** - The main focus like "mountain range at sunset"  
**Modifiers** - Additional descriptors that can come from sensors or user input  
**Weight** - Controls how strongly each component influences the final prompt

The process outputs the **Composed Prompt** and tracks the **Token Count** so you can stay within AI model limits.

You can choose different **Templates** (Standard, Detailed, Minimal), set custom **Separators** between components, and limit **Max Length** for different AI services.

## Example uses

**Basic composition**: Set Base Prompt: "A beautiful landscape", Style: "impressionist painting", Subject: "mountain range at sunset", and watch it create: "A beautiful landscape, impressionist painting, mountain range at sunset"

**Interactive installations**: Connect motion sensors to the Modifiers input using a [[Mapping Tool]], so movement changes the descriptive words that get added to your prompts.

**Smooth transitions**: Pair this with the [[AI Prompt Interpolator]] to gradually morph between completely different prompt styles.

**Performance tip**: Use a [[Rate Limiter]] to control how often prompts update in real-time applications - most AI services don't need prompts changing every frame.

Watch the Token Count output to stay within your AI model's limits, and experiment with different Templates to find the style that works best with your AI service.

Perfect for connecting to external AI services or other *score* processes that work with generated text content.

## Related processes

Combine with [[AI Prompt Interpolator]] for smooth prompt transitions, String utilities for text processing, or [[Array Utilities]] when working with multiple modifiers.