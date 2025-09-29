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

*score* comes with a built-in collection of professional audio effects that you can drag'n'drop directly into your projects. These effects are based on established DSP libraries including Lance Putnam's Gamma library.

You'll find five main types of audio processing:
- **Flanger** - Classic jet-like sweeping effects
- **Echo** - Delays and ambient spaces  
- **Compressor** - Dynamic range control with sidechain support
- **Limiter** - Transparent level limiting
- **Bitcrush** - Lo-fi digital destruction

All effects are optimized for real-time performance and can be combined with [[Faust]] processes or [[Audio Plugins]] to create complex audio processing chains.

## Flanger {#flanger}

![Flanger]({{ site.img }}/reference/processes/flanger.png "Flanger Effect")

The classic flanger effect that you hear on countless recordings. This process mixes your original signal with a delayed copy, using an [[LFO]] to continuously modulate the delay time. The result is that signature "whoosh" sound - think jet planes or the intro to "Itchycoo Park".

You can shape the flanging effect with these controls:

**Amount** (0.0 - 0.01)  
How deep the delay modulation goes. Start around 0.001 for subtle effects, push to 0.003+ for dramatic swooshes.

**Delay** (0.0 - 10.0 ms)  
The center delay time that the LFO sweeps around. Short delays (0.5-2ms) give tight flanging, longer delays approach chorus territory.

**Frequency** (0.001 - 100.0 Hz)  
Speed of the sweep. Try 0.2 Hz for slow, hypnotic sweeps or crank it up to 5+ Hz for tremolo-like effects.

**Feed-forward** (-0.99 - 0.99)  
Mixes the delayed signal with the original. Positive values create upward sweeps, negative creates downward swooshes.

**Feed-back** (-0.99 - 0.99)  
Sends the output back into the delay line for resonance and emphasis. Higher values make the effect more pronounced.

Try these settings: For that classic jet plane sound, use Amount: 0.003, Delay: 2.0ms, Frequency: 0.2Hz, Feed-forward: 0.8, Feed-back: 0.6. For a subtle chorus-like effect, dial back to Amount: 0.001, Delay: 8.0ms, Frequency: 0.1Hz, Feed-forward: 0.3, Feed-back: 0.1.

## Echo {#echo}

![Echo]({{ site.img }}/reference/processes/echo.png "Echo Effect")

This echo effect gives you everything from tight slap delays to massive ambient washes. Unlike simple repeats, it includes filtering and soft saturation to make the echoes sound natural and musical.

**Delay** (0.001 - 30 seconds)  
How long to wait before the echo appears. You get a massive range here - from short slap-back delays at 80ms up to 30-second ambient textures.

**Feedback** (0.0 - 1.0)  
How much of the echo gets fed back for more repeats. Keep it low (0.2-0.3) for single echoes, push it higher for long tails that fade into ambient washes.

**Filter** (0.0 - 1.0)  
A low-pass filter that makes echoes sound more natural. Lower values give you darker, warmer repeats that sit nicely in the mix without getting harsh.

**Dry/Wet** (0.0 - 1.0)  
Balances your original signal with the echoes. Start around 0.2-0.3 for musical delays, or push higher for special effects.

The echo includes soft saturation (using 10x tanh limiting) to prevent harsh digital clipping, and the filter sweeps from 200Hz to 3000Hz for natural-sounding repeats.

Try a short slap echo with Delay: 0.08s, Feedback: 0.3, Filter: 0.7, Dry/Wet: 0.3. For massive ambient spaces, try Delay: 2.5s, Feedback: 0.6, Filter: 0.3, Dry/Wet: 0.4.

## Compressor {#compressor}

![Compressor]({{ site.img }}/reference/processes/compressor.png "Compressor Effect")

A full-featured compressor that evens out your audio levels. It makes quiet parts louder and loud parts quieter, plus it supports sidechain compression for pumping effects.

You get standard compressor controls: **Threshold** sets where compression kicks in, **Ratio** controls how hard it compresses (2:1 is gentle, 10:1+ is heavy limiting), **Attack** and **Release** shape the timing, and **Makeup** gain compensates for level reduction.

The **Sidechain** input lets you trigger compression from external sources - connect a kick drum here for that classic pumping EDM sound. **Lookahead** (0.001-0.005s) helps catch fast transients transparently.

Try these settings: For vocals, use Threshold: 0.6, Ratio: 3:1, Attack: 0.003s, Release: 0.1s. For sidechain pumping, connect your kick to the sidechain input and try Ratio: 8:1 with fast Attack and slower Release around 0.2s.

## Limiter {#limiter}

![Limiter]({{ site.img }}/reference/processes/limiter.png "Limiter Effect")

A transparent brick-wall limiter that prevents clipping while maintaining musical character. Perfect for mastering chains or protecting your speakers from unexpected peaks.

This uses soft limiting algorithms with hyperbolic tangent curves instead of harsh clipping. The **Threshold** (default 0.98) sets the maximum level, while **Lookahead** (0.001-0.005s) lets it anticipate peaks for smooth gain reduction.

**Attack** should stay very fast (0.0001s) for transparent limiting, and **Release** (around 0.05-0.08s) controls how quickly it lets go. The **Makeup** gain boosts the signal before limiting - use it carefully.

For master bus limiting, try Threshold: 0.95, Release: 0.05s, Lookahead: 0.003s with minimal Makeup gain.

## Bitcrush {#bitcrush}

![Bitcrush]({{ site.img }}/reference/processes/bitcrush.png "Bitcrush Effect")

Lo-fi digital destruction for that crunchy 8-bit sound. This process reduces sample rate and bit depth to create authentic digital artifacts and aliasing.

**Rate** (10-22,000 Hz) controls sample rate reduction - lower values give more aggressive digital artifacts. **Crush** (0.0-1.0) adds bit quantization for that stepped, digital distortion sound.

Try Rate: 8000Hz, Crush: 0.2 for subtle lo-fi character. For extreme 8-bit destruction, push Rate down to 2000Hz and Crush up to 0.8. At Rate: 100Hz and Crush: 0.9, you get complete digital chaos.

## Related processes

These audio effects work great with [[Audio Utilities]], [[Audio Plugins]], and [[Faust]] processes. 
