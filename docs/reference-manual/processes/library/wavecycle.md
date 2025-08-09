---
layout: default

title: Wavecycle
description: "Wavetable oscillator with hand-drawn waveforms"

parent: Processes
grand_parent: Reference

permalink: /processes/wavecycle.html
---
# Wavecycle

![Wavecycle]({{ site.img }}/reference/processes/wavecycle.png "Wavecycle")

Draw your own waveforms and hear them immediately. Wavecycle turns hand-drawn curves into audio oscillators, letting you sculpt sound by sculpting waves.

Perfect for creating custom timbres, experimental synthesis, or when you want total control over your oscillator's harmonic content. Draw harsh sawtooths, smooth sines, or impossible shapes that only exist in your imagination.

## How it works

Wavecycle reads the curve you draw and uses it as a wavetable - cycling through your waveform at audio rate to generate sound. The faster the frequency, the higher the pitch.

**Curve** - Your waveform design  
Click and drag to draw any shape you want. The horizontal axis is one complete cycle, the vertical axis is amplitude. Sharp corners create harsh harmonics, smooth curves sound gentle.

**Frequency** (1-20000 Hz, default 1000)  
How fast to cycle through your waveform. Low frequencies for bass tones, high frequencies for piercing leads. The frequency parameter includes smoothing to prevent clicks when adjusting.

## Drawing techniques

**Sine wave**: Draw a smooth S-curve for classic sine wave tones

**Sawtooth**: Draw a ramp that rises linearly then drops sharply for buzzy sawtooth sounds

**Square wave**: Draw flat high and low sections for hollow square wave tones

**Custom harmonics**: Create complex shapes with multiple peaks and valleys for rich, unique timbres

**Asymmetrical waves**: Draw shapes that aren't symmetrical for even-order harmonics and distinctive character

## Creative applications

**Morphing synthesis**: Automate the curve parameter to morph between different waveforms in real-time - create evolving, living tones.

**Harmonic design**: Draw waveforms based on specific harmonic series for mathematically precise timbres.

**Texture creation**: Use very complex, noisy waveforms for textural synthesis and atmospheric sounds.

**Percussive elements**: Draw sharp attack shapes for percussive, pluck-like sounds.

## Technical details

Wavecycle automatically removes DC offset (subtracts 0.5 from your curve values) to prevent unwanted low-frequency rumble. The frequency parameter uses 20ms smoothing to prevent clicks and pops when adjusting pitch in real-time.

The process uses sample-accurate phase tracking for pristine audio quality and perfect pitch stability. Your drawn curve is evaluated in real-time, so you can modify waveforms while listening and hear the changes immediately.

Works great in combination with [[Audio Effects]] for further sound shaping, or use multiple Wavecycle processes with slightly different frequencies for rich detuned textures.

## Related processes

Chain with [[Envelope Follower]] to create responsive dynamics, combine with [[LFO]] to modulate frequency for vibrato effects, or feed into [[Audio Effects]] for processing. Use [[Faust]] for more complex wavetable synthesis techniques.