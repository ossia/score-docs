---
layout: default

title: GAN Image Generation
description: "Real-time image generation using GAN models"

parent: Processes
grand_parent: Reference

permalink: /processes/gan-image-generation.html
---
# GAN Image Generation

![GAN Image Generation]({{ site.img }}/reference/processes/gan-generation.png "GAN Image Generation")

Generate images in real-time using Generative Adversarial Network (GAN) models. This process supports various GAN architectures for different creative applications.

## Overview

The GAN Image Generation process enables real-time synthesis of images from latent vectors or noise inputs. Supported models include:
- MobileStyleGAN - Fast, mobile-optimized style transfer
- FBAnimeGAN - Anime-style image generation
- Custom ONNX GAN models

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Latent Vector | Float Array | Input latent space coordinates |
| Noise | Float | Random seed value |
| Style Vector | Float Array | Style conditioning (model-dependent) |
| Class | Integer | Class index for conditional GANs |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Generated Image | Texture | The generated image |
| Latent Info | Object | Information about the latent space |

## Parameters

| Parameter | Widget | Description | Default | Range |
|-----------|--------|-------------|---------|-------|
| Model | File Selector | Path to ONNX model | - | .onnx files |
| Resolution | Dropdown | Output resolution | "256x256" | 64x64 to 1024x1024 |
| Latent Size | Integer | Size of latent vector | 512 | Model-dependent |
| Seed | Integer | Random seed | -1 | -1 (random) or 0+ |
| Interpolation | Dropdown | Latent interpolation | "Spherical" | Linear, Spherical |

## Supported Models

### MobileStyleGAN
- Optimized for real-time performance
- Lower memory footprint
- Suitable for interactive installations

Download: [MobileStyleGAN ONNX](https://github.com/bes-dev/MobileStyleGAN.pytorch)

### FBAnimeGAN
- Specialized for anime-style generation
- High-quality stylized outputs
- Good for artistic applications

### Custom Models
Any GAN model exported to ONNX format with standard input/output conventions.

## Usage Examples

### Interactive Latent Space Exploration

Use mouse or sensor input to navigate the latent space:

```
[Mouse X/Y] → [Scale] → [Latent Vector] → [GAN Generation]
                                               ↓
                                        [Window Device]
```

### Automated Generation

Create evolving visuals with LFO-driven latent vectors:

```
[Multiple LFOs] → [Array Combiner] → [GAN Generation]
                                           ↓
                                    [Video Recorder]
```

### Style Morphing

Interpolate between different styles:

```
[Style A] → [Interpolator] → [Style Vector] → [GAN Generation]
[Style B] ↗     ↑
           [LFO/Control]
```

## Performance Optimization

### GPU Acceleration
- Ensure GPU support is enabled in score settings
- Monitor GPU memory usage for larger models

### Batch Processing
- Process multiple latent vectors simultaneously
- Use array inputs for efficient generation

### Resolution Scaling
- Start with lower resolutions for prototyping
- Scale up for final output

## Creative Applications

### Live Visuals
- Map audio features to latent dimensions
- Create responsive, generative backgrounds
- Synchronize with musical events

### Installation Art
- Sensor-driven image generation
- Environmental responsive visuals
- Long-form generative pieces

### Video Effects
- Real-time style transfer
- Dynamic texture generation
- Transitional effects

## Troubleshooting

### Model Loading Issues
- Verify ONNX model compatibility
- Check model input/output shapes
- Ensure sufficient GPU memory

### Performance Problems
- Reduce output resolution
- Limit generation frequency
- Use simpler models for real-time

## Best Practices

1. **Latent Space Mapping**: Understand your model's latent space structure
2. **Smooth Transitions**: Use interpolation for fluid motion
3. **Seed Management**: Fix seeds for reproducible results
4. **Resource Monitoring**: Watch GPU usage and temperatures

## Related Processes

- [GAN Image Processing](/processes/gan-image-processing.html) - Process existing images
- [Interpolator](/processes/interpolator.html) - Smooth value transitions
- [Nodes](/processes/nodes.html) - 2D latent space navigation
- [AI Recognition](/processes/ai-recognition.html) - Combine with detection