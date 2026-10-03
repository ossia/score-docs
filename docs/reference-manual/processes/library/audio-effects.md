---
layout: default

title: Audio Effects
description: "Real-time audio processing effects for creative sound design"

parent: Processes
grand_parent: Reference

permalink: /processes/audio-effects.html
---
# Audio Effects


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

The **Flanger** mixes audio with a short, continuously modulated delay. Connect an audio source to its audio input and route its audio output onward.

The current development-build version (v2) replaces the sweep's Frequency control with a tempo-syncable **Period**.

| Control | Range; default | Meaning |
|---|---|---|
| **Amount** | 0–0.01; **0.001** | Delay modulation depth, in seconds. |
| **Delay** | Free 0–0.02 seconds; **0.002 seconds** | Centre of the delay sweep; a time chooser. |
| **Period** | Free 0.01–60 seconds; **2 seconds** | Duration of one modulation cycle; a time chooser. |
| **Feed-forward** | −0.99–0.99; **0.7** | Delayed-signal contribution; the sign changes its polarity. |
| **Feed-back** | −0.99–0.99; **0.7** | Recirculates delayed audio for resonance; the sign changes its polarity. |

Click Period's [time chooser]({{ site.baseurl }}/reference/time-chooser.html) readout to synchronize the sweep to straight, dotted or triplet notes. Period controls cycle length, not a bar-locked phase reset. Delay can also use a note value, but the actual sweep is clamped within the **50 ms delay line**, with a two-sample safety margin at either end. A long synchronized Delay therefore does not turn this into a long echo.

**Flanger (old)** remains registered for saved scores and retains its Frequency control and earlier delay settings. It is not automatically replaced with v2; do not copy a frequency number directly into Period.

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

The **Compressor** reduces the gain of audio above a threshold. Connect the signal to **Audio** and take the result from **Output**. An optional **Sidechain** audio input supplies the detector signal instead of the main input; without it, the compressor detects the main audio's peaks across its channels.

The current development-build version (v2) has tempo-syncable Attack and Release controls:

| Control | Range; default | Meaning |
|---|---|---|
| **Threshold** | 0–1; **0.5** | Linear amplitude at which gain reduction begins, not decibels. |
| **Ratio** | 0.05–50; **1** | Compression ratio; 1 leaves the detected level unchanged. Values above 1 compress. |
| **Attack** | Free 0–1 second; **0.001 seconds** | Response time when the level rises; time chooser. |
| **Release** | Free 0–2 seconds; **0.05 seconds** | Recovery time when the level falls; time chooser. |
| **Makeup** | 0–30; **0** | Post-compression multiplier is `1 + Makeup`, not a dB gain. |
| **Lookahead** | 0.001–0.005 seconds; **0.001 seconds** | Delays the audio relative to detection to anticipate transients. This remains a seconds-based knob. |

For tempo-related sidechain pumping, connect a rhythmic source to Sidechain and select a note value on Release. This sets the recovery duration at the current tempo; it does not quantize the incoming audio or force recovery to start on a grid point.

**Compressor (old)** keeps its plain Attack and release knobs when loading older scores; those processes are not automatically migrated. The new control is spelled **Release** rather than the older **Relase**.

## Limiter {#limiter}

![Limiter]({{ site.img }}/reference/processes/limiter.png "Limiter Effect")

The **Limiter** is a lookahead, sample-peak limiter. Its **Audio** input is delayed and gain-reduced so that the absolute output sample value does not exceed **Threshold**. Take the result from **Output**. **Sidechain** is optional: its peaks can request additional attenuation, while the main signal remains included in peak detection.

| Control | Range; default | Meaning |
|---|---|---|
| **Threshold** | 0–1; **0.98** | Output sample-peak ceiling in linear amplitude. |
| **Makeup** | 0–30; **0** | Input drive multiplier `1 + Makeup`, before limiting; not a dB value. |
| **Attack** | Free 0–1 second; **0.003 seconds** | Gain-ramp duration; time chooser in the current v2 process. |
| **Release** | Free 0–2 seconds; **0.08 seconds** | Gain recovery duration; time chooser in v2. |
| **Lookahead** | 0.001–0.005 seconds; **0.003 seconds** | Audio delay used to anticipate peaks; a seconds-based knob. |

The effective Attack ramp cannot exceed the Lookahead duration plus one sample. Choosing a long note value for Attack therefore does not produce a beat-long ramp. Release is useful for tempo-related recovery through the [time chooser]({{ site.baseurl }}/reference/time-chooser.html).

This is a sample-peak ceiling, not a claim of inter-sample true-peak protection or a substitute for safe monitoring levels. The current implementation uses peak-based gain reduction and a final ceiling clamp, not the previously described hyperbolic-tangent soft saturation.

**Limiter (old)** remains loadable with its earlier plain timing controls and **Relase** spelling. It also uses the current peak-limiter engine; retaining a saved process identity does not mean every historical DSP implementation is frozen. To use the new timing controls, insert the current Limiter explicitly.

## Bitcrush {#bitcrush}

![Bitcrush]({{ site.img }}/reference/processes/bitcrush.png "Bitcrush Effect")

Lo-fi digital destruction for that crunchy 8-bit sound. This process reduces sample rate and bit depth to create authentic digital artifacts and aliasing.

**Rate** (10-22,000 Hz) controls sample rate reduction - lower values give more aggressive digital artifacts. **Crush** (0.0-1.0) adds bit quantization for that stepped, digital distortion sound.

Try Rate: 8000Hz, Crush: 0.2 for subtle lo-fi character. For extreme 8-bit destruction, push Rate down to 2000Hz and Crush up to 0.8. At Rate: 100Hz and Crush: 0.9, you get complete digital chaos.

## Related processes

These audio effects work great with [[Audio Utilities]] and [[Audio Plugins]]. 
