---
layout: default

title: Audio Particles
description: "Granular synthesis with folder-based sample triggering"

parent: Processes
grand_parent: Reference

permalink: /processes/audio-particles.html
---
# Audio Particles

![Audio Particles]({{ site.img }}/reference/processes/audio-particles.png "Audio Particles")

A granular synthesizer that creates swarms of audio particles by randomly triggering samples from a folder. Think of it as controlled chaos: you set the rules, and Audio Particles creates organic, ever-changing textures.

Perfect for ambient soundscapes, percussive textures, or any time you want to transform a collection of samples into something completely new and alive.

## How it works

Audio Particles scans a folder for `.wav` files and randomly triggers them across multiple output channels. Each "particle" is a brief playback of one of your samples, scattered across time and space according to your settings.

**Folder** - Point this to any folder containing `.wav` files  
Your samples become the raw material for particle generation. Mix and match different types of sounds - percussion hits, field recordings, vocal fragments, synth stabs.

**Channels** (0-128, default 16)  
How many output channels to scatter particles across. More channels = wider spatial distribution. Perfect for surround sound or feeding into [[DBAP]] spatialization.

**Frequency** (0.001-30 Hz, default 0.2)  
Rate of particle generation. Low values create sparse, meditative textures. High values build dense clouds of sound.

**Density** (0.001-1.0, default 0.7)  
Probability that a particle actually triggers when scheduled. Lower density creates more irregular, organic timing patterns.

## Creative applications

**Ambient textures**: Load a folder of field recordings, set Frequency to 0.1Hz, Density to 0.3, and let it create sparse, atmospheric soundscapes.

**Rhythmic elements**: Use short percussion samples with higher Frequency (2-5Hz) and high Density (0.9) for polyrhythmic patterns.

**Vocal clouds**: Process speech recordings into ethereal, whispered textures by fragmenting words into particles.

**Orchestral dispersion**: Take orchestral samples and scatter them across many channels for impossible ensemble effects.

## Technical details

Audio Particles uses exponential distribution for organic timing - particles don't arrive on a rigid grid but with natural, breathing rhythms. Each sample gets randomly assigned to output channels, and multiple samples can play simultaneously for rich polyphonic textures.

The process automatically monitors your folder for changes, so you can add new samples while performing and they'll become part of the particle pool immediately.

Works beautifully with [[Matrix]] routing for sending particles to different speaker arrays, or chain with [[Audio Effects]] for processed particle clouds.
