---
layout: default

title: FastVLM
description: "Real-time video-to-text inference"

parent: Processes
grand_parent: Reference

permalink: /processes/fastvlm.html
---
# FastVLM

![FastVLM]({{ site.img }}/reference/processes/fastvlm.png "FastVLM Video-to-Text")

FastVLM enables real-time video understanding and description through efficient vision-language models. It can analyze video streams and generate textual descriptions, answer questions about visual content, and provide scene understanding.

## Overview

FastVLM (Fast Vision-Language Model) processes video frames and generates natural language descriptions in real-time. This is useful for:
- Automated video captioning
- Interactive installations that respond to visual context
- Accessibility applications
- Content analysis and logging

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Video Input | Texture | Video stream or image sequence |
| Prompt | String | Optional prompt or question |
| Context | String | Additional context information |
| Frame Rate | Integer | Analysis frame rate |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Description | String | Generated text description |
| Confidence | Float | Confidence score (0-1) |
| Tokens | Integer | Number of generated tokens |
| Analysis | Object | Detailed analysis data |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Model | File Selector | FastVLM model path | - | .onnx files |
| Max Length | Integer | Maximum response length | 128 | 1-512 |
| Temperature | Float | Generation randomness | 0.7 | 0.0-2.0 |
| Mode | Dropdown | Analysis mode | "Description" | Description, Q&A, Analysis |
| Language | Dropdown | Output language | "English" | Multiple options |

## Analysis Modes

### Description Mode
Generates general descriptions of the visual content:
- Scene description
- Object identification
- Action recognition
- Temporal changes

### Q&A Mode
Answers specific questions about the video:
- "What is happening in this scene?"
- "How many people are visible?"
- "What color is the object?"

### Analysis Mode
Provides structured analysis:
- Object detection with locations
- Scene classification
- Motion analysis
- Temporal events

## Usage Examples

### Live Video Description

Generate real-time captions for a camera feed:

```
[Camera Device] → [FastVLM] → [Text Display]
                      ↓
              [OSC Output: /video/description]
```

### Interactive Q&A System

Create an installation that answers questions about what it sees:

```
[Camera] → [FastVLM] → [Text to Speech]
              ↑              ↓
    [Voice Recognition]  [Speaker]
```

### Content Logger

Automatically log video content:

```
[Video File] → [FastVLM] → [CSV Recorder]
                    ↓
            [Description + Timestamp]
```

## Prompt Engineering

### Effective Prompts
- "Describe what you see in detail"
- "List all objects in the scene"
- "What is the main action happening?"
- "Describe the mood and atmosphere"

### Context Usage
Provide context for better results:
- Scene type (indoor/outdoor)
- Expected content
- Specific focus areas

## Performance Optimization

### Frame Sampling
- Adjust Frame Rate parameter for efficiency
- Use keyframe detection for static scenes
- Implement motion-based sampling

### Model Configuration
- Use quantized models for faster inference
- Adjust max token length based on needs
- Enable GPU acceleration

### Batching
- Process multiple frames in parallel
- Queue descriptions for smooth output
- Implement result caching

## Creative Applications

### Narrative Generation

Generate evolving stories based on visual input:

```
[Camera] → [FastVLM] → [GPT/LLM] → [Story]
               ↓
        [Scene Description]
```

### Accessibility Tools

Provide audio descriptions for visually impaired users:

```
[Video] → [FastVLM] → [Text Filter] → [TTS] → [Audio]
             ↓
    [Detailed Descriptions]
```

### Interactive Installations

Create responsive environments:

```
[Multiple Cameras] → [FastVLM] → [Scene Analysis]
                          ↓
                 [Lighting Control]
                 [Sound Generation]
                 [Projection Mapping]
```

## Integration with Other AI Models

### Combined Analysis
```
[Video] → [YOLO Detection] → [Object List]
     ↓                            ↓
[FastVLM] → [Combined Description]
```

### Multi-Modal Generation
```
[FastVLM Description] → [Stable Diffusion] → [Generated Image]
                    ↓
            [Audio Generation]
```

## Best Practices

1. **Frame Selection**: Choose representative frames for analysis
2. **Prompt Clarity**: Use specific, clear prompts for better results
3. **Result Filtering**: Post-process outputs for consistency
4. **Error Handling**: Implement fallbacks for unclear scenes
5. **Privacy**: Consider privacy implications of scene analysis

## Troubleshooting

### Poor Descriptions
- Check video quality and lighting
- Adjust temperature parameter
- Provide more specific prompts
- Ensure model is appropriate for content

### Performance Issues
- Reduce frame rate
- Use smaller model variants
- Enable hardware acceleration
- Implement result caching

## Technical Notes

### Model Requirements
- Supports ONNX-exported FastVLM models
- Requires appropriate input preprocessing
- Memory usage scales with model size

### Output Format
Descriptions can be formatted as:
- Plain text
- JSON structured data
- Tagged annotations

## Related Processes

- [AI Recognition](/processes/ai-recognition.html) - Object detection
- [Qwen LLM](/processes/qwen-llm.html) - Language model inference
- [Text](/processes/text.html) - Text manipulation
- [OSC Device](/devices/osc-device.html) - Send descriptions via OSC