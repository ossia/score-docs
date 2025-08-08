---
layout: default

title: Qwen LLM
description: "Large Language Model inference with Qwen"

parent: Processes
grand_parent: Reference

permalink: /processes/qwen-llm.html
---
# Qwen LLM

![Qwen LLM]({{ site.img }}/reference/processes/qwen-llm.png "Qwen Language Model")

The Qwen LLM process enables local inference of Qwen language models for text generation, conversation, and creative applications within score.

## Overview

Qwen (通义千问) is a series of large language models that can be run locally for:
- Text generation and completion
- Interactive conversations
- Code generation
- Creative writing
- Real-time text processing in performances

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Prompt | String | Input text or question |
| System Message | String | System-level instructions |
| Context | String Array | Conversation history |
| Temperature | Float | Randomness control |
| Max Tokens | Integer | Maximum response length |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Response | String | Generated text |
| Tokens Used | Integer | Number of tokens processed |
| Generation Info | Object | Detailed generation statistics |
| Stream | String | Token-by-token output stream |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Model | File Selector | Path to Qwen ONNX model | - | .onnx files |
| Temperature | Float | Response randomness | 0.7 | 0.0-2.0 |
| Top P | Float | Nucleus sampling | 0.9 | 0.0-1.0 |
| Top K | Integer | Top-k sampling | 50 | 1-100 |
| Repetition Penalty | Float | Reduce repetition | 1.1 | 1.0-2.0 |
| Stream Output | Toggle | Enable streaming | Off | On/Off |

## Model Variants

### Qwen-1.8B
- Lightweight, fast inference
- Suitable for real-time applications
- Lower memory requirements

### Qwen-7B
- Better quality responses
- More creative capabilities
- Higher resource usage

### Qwen-14B
- Best quality
- Advanced reasoning
- Requires significant resources

## Usage Examples

### Interactive Text Generation

Create dynamic text based on sensor input:

```
[Sensor Data] → [Prompt Composer] → [Qwen LLM] → [Text Display]
                                          ↓
                                  [Text to Speech]
```

### Live Performance Assistant

Generate performance cues and text:

```
[MIDI Input] → [Note to Text] → [Qwen LLM] → [Projection]
                                      ↑
                            [Performance Context]
```

### Automated Storytelling

Create evolving narratives:

```
[Scene Analysis] → [Qwen LLM] → [Story Text]
        ↑               ↓
    [FastVLM]    [Memory Buffer]
```

## Prompt Engineering

### System Messages
Set the model's behavior and context:
- "You are a poetic narrator describing visual scenes"
- "Generate short, rhythmic responses suitable for music"
- "Respond only with stage directions"

### Effective Prompting
- Be specific about desired output format
- Provide examples when possible
- Use consistent formatting
- Include relevant context

### Creative Applications
- Poetry generation from sensor data
- Dynamic subtitles for performances
- Interactive narrative experiences
- Generative dialogue systems

## Performance Optimization

### Model Loading
- Load models at startup to avoid delays
- Use quantized models for better performance
- Consider model size vs. quality tradeoffs

### Streaming Mode
Enable streaming for:
- Real-time text display
- Reduced latency perception
- Progressive text revelation

### Caching
- Cache common responses
- Implement context windowing
- Reuse computation where possible

## Integration Examples

### Multi-Modal Performance

Combine with other AI processes:

```
[Camera] → [FastVLM] → [Scene Description]
                              ↓
                         [Qwen LLM]
                              ↓
              [Poetic Interpretation] → [Display]
```

### Interactive Installation

Create responsive text environments:

```
[Visitor Input] → [Qwen LLM] → [Response]
                      ↑             ↓
              [Context Manager]  [Projection]
                      ↑
              [Conversation History]
```

### Code Generation

Generate live code for other processes:

```
[Musical Input] → [Analysis] → [Qwen LLM] → [JavaScript Code]
                                                    ↓
                                            [JS Process]
```

## Advanced Features

### Context Management
- Maintain conversation history
- Implement sliding window contexts
- Clear context on specific triggers

### Token Control
- Monitor token usage for costs
- Implement token limits
- Use token-aware truncation

### Output Filtering
- Implement content filtering
- Format output for specific uses
- Parse structured responses

## Best Practices

1. **Model Selection**: Choose model size based on quality/performance needs
2. **Temperature Tuning**: Lower for consistency, higher for creativity
3. **Context Length**: Balance context with performance
4. **Error Handling**: Implement fallbacks for failed generations
5. **Resource Monitoring**: Watch memory and CPU/GPU usage

## Troubleshooting

### Slow Generation
- Use smaller models
- Reduce max token length
- Enable GPU acceleration
- Implement streaming

### Poor Quality Output
- Adjust temperature and sampling parameters
- Improve prompt clarity
- Provide better examples
- Check model compatibility

### Memory Issues
- Use quantized models
- Reduce batch size
- Clear context regularly
- Monitor system resources

## Creative Use Cases

### Performance
- Generate live subtitles
- Create dynamic poetry
- Produce stage directions
- Generate character dialogue

### Installation
- Visitor interaction systems
- Generative text displays
- Responsive narratives
- Educational experiences

### Experimentation
- Text-based compositions
- Language exploration
- Conceptual art generation
- Hybrid human-AI creation

## Related Processes

- [AI Prompt Composer](/processes/ai-prompt-composer.html) - Build complex prompts
- [FastVLM](/processes/fastvlm.html) - Video understanding
- [Text](/processes/text.html) - Text manipulation
- [JavaScript](/processes/javascript.html) - Process generated code