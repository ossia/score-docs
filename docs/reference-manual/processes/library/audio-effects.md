---
layout: default

title: Audio Effects
description: "Real-time audio processing effects for creative sound design"

parent: Processes
grand_parent: Reference

permalink: /processes/audio-effects.html
---
# Audio Effects

![Audio Effects]({{ site.img }}/reference/processes/audio-effects.png "Audio Effects")

Ossia score provides a comprehensive suite of real-time audio effects for creative sound processing. These effects are based on established DSP libraries including Lance Putnam's Gamma library and the ofxTonic framework, ensuring high-quality audio processing with professional-grade algorithms.

## Overview

The audio effects collection includes:
- **Time-based effects** - Flanger, Echo for spatial and temporal processing
- **Dynamics processing** - Compressor, Limiter for level control
- **Distortion effects** - Bitcrush for digital degradation
- **Real-time processing** - All effects optimized for live performance
- **Professional algorithms** - Based on proven DSP implementations

## Flanger {#flanger}

![Flanger]({{ site.img }}/reference/processes/flanger.png "Flanger Effect")

The Flanger creates a sweeping, jet-like effect by mixing the original signal with a slightly delayed copy whose delay time is modulated by a low-frequency oscillator.

### Parameters

**Amount**  
*Type*: Horizontal slider (0.0 - 0.01)  
*Default*: 0.001  
Controls the depth of delay modulation. Higher values create more pronounced sweeping effects.

**Delay**  
*Type*: Time chooser (0.0 - 10.0 ms)  
*Default*: 0.5 ms  
*Mapping*: Logarithmic  
Sets the base delay time. The LFO modulates around this central value.

**Frequency**  
*Type*: Horizontal slider (0.001 - 100.0 Hz)  
*Default*: 0.5 Hz  
Controls the speed of the sweep effect. Lower values create slow, smooth sweeps; higher values create rapid, tremolo-like effects.

**Feed-forward**  
*Type*: Horizontal slider (-0.99 - 0.99)  
*Default*: 0.7  
Mixes the delayed signal with the direct signal. Positive values create upward sweeps, negative values create downward sweeps.

**Feed-back**  
*Type*: Horizontal slider (-0.99 - 0.99)  
*Default*: 0.7  
Controls signal feedback within the delay line, adding resonance and emphasis to the effect.

### Usage Examples

**Classic Jet Flanger:**
- Amount: 0.003
- Delay: 2.0 ms
- Frequency: 0.2 Hz
- Feed-forward: 0.8
- Feed-back: 0.6

**Subtle Chorus Effect:**
- Amount: 0.001
- Delay: 8.0 ms
- Frequency: 0.1 Hz
- Feed-forward: 0.3
- Feed-back: 0.1

## Echo {#echo}

![Echo]({{ site.img }}/reference/processes/echo.png "Echo Effect")

The Echo effect creates discrete delayed repetitions of the input signal with feedback control and filtering for natural-sounding echoes and delays.

### Parameters

**Delay**  
*Type*: Time chooser (0.001 - 30.0 seconds)  
*Default*: 0.2 seconds  
*Mapping*: Logarithmic  
Sets the delay time between the original signal and its echo. Maximum delay of 30 seconds allows for creative long-delay effects.

**Feedback**  
*Type*: Horizontal slider (0.0 - 1.0)  
*Default*: 0.2  
Controls how much of the delayed signal is fed back into the delay line. Higher values create longer echo tails.

**Filter**  
*Type*: Horizontal slider (0.0 - 1.0)  
*Default*: 0.5  
*Mapping*: Logarithmic  
Controls a low-pass filter applied to the delayed signal. Lower values create darker, more natural-sounding echoes.

**Dry/Wet**  
*Type*: Horizontal slider (0.0 - 1.0)  
*Default*: 0.2  
Balances the original (dry) signal with the delayed (wet) signal. 0.0 = dry only, 1.0 = wet only.

### Technical Details

- Maximum delay: 30 seconds
- Filter range: 200 Hz - 3000 Hz low-pass
- Soft saturation: 10x tanh limiting prevents digital clipping
- Linear interpolation for smooth delay modulation

### Usage Examples

**Short Slap Echo:**
- Delay: 0.08 seconds
- Feedback: 0.3
- Filter: 0.7
- Dry/Wet: 0.3

**Long Ambient Delay:**
- Delay: 2.5 seconds
- Feedback: 0.6
- Filter: 0.3 (darker)
- Dry/Wet: 0.4

**Ping-pong Style:**
- Delay: 0.25 seconds
- Feedback: 0.5
- Filter: 0.5
- Dry/Wet: 0.5

## Compressor {#compressor}

![Compressor]({{ site.img }}/reference/processes/compressor.png "Compressor Effect")

The Compressor reduces the dynamic range of audio signals, making quiet parts louder and loud parts quieter. Includes sidechain input for advanced compression techniques.

### Parameters

**Audio**  
*Type*: Dynamic audio bus  
Main audio input. Supports multiple channels with automatic processing.

**Sidechain**  
*Type*: Dynamic audio bus (optional)  
External control signal for sidechain compression. When connected, compression is triggered by this signal rather than the main audio.

**Makeup**  
*Type*: Knob (0 - 30 dB)  
*Default*: 0 dB  
Compensates for level reduction caused by compression. Applied after compression processing.

**Attack**  
*Type*: Knob (0.0 - 1.0 seconds)  
*Default*: 0.001 seconds  
How quickly the compressor responds to signal peaks. Faster attack catches transients, slower attack preserves punch.

**Release**  
*Type*: Knob (0.0 - 1.0 seconds)  
*Default*: 0.05 seconds  
How quickly the compressor stops compressing after the signal drops below threshold. Affects naturalness of compression.

**Threshold**  
*Type*: Knob (0.0 - 1.0)  
*Default*: 0.5  
Level above which compression begins. Signals below threshold pass unaffected.

**Ratio**  
*Type*: Knob (0.05 - 50:1)  
*Default*: 1:1 (no compression)  
Compression strength. 2:1 = gentle, 4:1 = moderate, 10:1+ = limiting.

**Lookahead**  
*Type*: Knob (0.001 - 0.005 seconds)  
*Default*: 0.001 seconds  
Allows the compressor to "see" peaks before they happen, enabling transparent compression of fast transients.

### Usage Examples

**Vocal Compression:**
- Threshold: 0.6
- Ratio: 3:1
- Attack: 0.003s
- Release: 0.1s
- Makeup: 3 dB

**Drum Bus Glue:**
- Threshold: 0.4
- Ratio: 2:1
- Attack: 0.01s
- Release: 0.08s
- Makeup: 2 dB

**Sidechain Pumping:**
- Connect kick drum to sidechain
- Threshold: 0.3
- Ratio: 8:1
- Attack: 0.001s
- Release: 0.2s

## Limiter {#limiter}

![Limiter]({{ site.img }}/reference/processes/limiter.png "Limiter Effect")

The Limiter prevents audio signals from exceeding a specified threshold, using soft limiting algorithms to maintain transparency while providing absolute level control.

### Parameters

**Audio**  
*Type*: Dynamic audio bus  
Main audio input with multi-channel support.

**Sidechain**  
*Type*: Dynamic audio bus (optional)  
External trigger for sidechain limiting effects.

**Makeup**  
*Type*: Knob (0 - 30 dB)  
*Default*: 0 dB  
Pre-limiting gain boost. Use carefully as it increases the signal before limiting.

**Attack**  
*Type*: Knob (0.0 - 1.0 seconds)  
*Default*: 0.0001 seconds  
Extremely fast attack for transparent limiting. Values too high may cause pumping.

**Release**  
*Type*: Knob (0.0 - 1.0 seconds)  
*Default*: 0.08 seconds  
Release time affects how quickly limiting stops after peaks. Faster release maintains loudness but may cause distortion.

**Threshold**  
*Type*: Knob (0.0 - 1.0)  
*Default*: 0.98  
Maximum allowed signal level. Signals above this level are limited using soft-limiting curves.

**Lookahead**  
*Type*: Knob (0.001 - 0.005 seconds)  
*Default*: 0.003 seconds  
Critical for transparent limiting. Allows the limiter to anticipate peaks and apply smooth gain reduction.

### Technical Features

- **Soft limiting algorithm**: Uses hyperbolic tangent curves instead of hard clipping
- **Infinite ratio compression**: Ratio set to ~10 billion for true limiting behavior
- **Lookahead processing**: Prevents inter-sample peaks and aliasing
- **Multi-channel linking**: All channels limited together to preserve stereo image

### Usage Examples

**Master Bus Limiting:**
- Threshold: 0.95
- Attack: 0.0001s
- Release: 0.05s
- Lookahead: 0.003s
- Makeup: 1 dB

**Broadcast Limiting:**
- Threshold: 0.85
- Attack: 0.0001s
- Release: 0.1s
- Lookahead: 0.005s
- Makeup: 3 dB

## Bitcrush {#bitcrush}

![Bitcrush]({{ site.img }}/reference/processes/bitcrush.png "Bitcrush Effect")

The Bitcrush effect creates digital distortion by reducing sample rate and bit depth, producing lo-fi, retro digital artifacts popular in electronic music.

### Parameters

**Rate**  
*Type*: Horizontal slider (10 - 22,000 Hz)  
*Default*: 4,000 Hz  
Sample rate reduction. Lower values create more aggressive digital artifacts and aliasing.

**Crush**  
*Type*: Horizontal slider (0.0 - 1.0)  
*Default*: 0.5  
Bit depth reduction intensity. Higher values create more quantization noise and digital distortion.

### Technical Implementation

- **Sample rate reduction**: Uses the Gamma library's quantizer for accurate downsampling
- **Bit quantization**: Reduces effective bit depth through stepped quantization
- **Aliasing preservation**: Maintains aliasing artifacts for authentic lo-fi sound
- **Efficient processing**: Optimized for real-time use with minimal CPU overhead

### Usage Examples

**Subtle Lo-fi:**
- Rate: 8,000 Hz
- Crush: 0.2

**Aggressive 8-bit:**
- Rate: 2,000 Hz
- Crush: 0.8

**Telephone Effect:**
- Rate: 3,400 Hz
- Crush: 0.4

**Extreme Digital Destruction:**
- Rate: 100 Hz
- Crush: 0.9

## Related Processes

- **Audio Utilities**: Gain, mixing, and routing tools
- **CLAP Plugins**: Third-party audio effects
- **Faust**: Custom DSP programming
- **Audio Looper**: Sampling and loop-based effects