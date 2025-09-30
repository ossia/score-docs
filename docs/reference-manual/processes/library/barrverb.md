---
layout: default

title: BarrVerb
description: "Vintage-inspired reverb based on Alesis MIDIVerb"

parent: Processes
grand_parent: Reference

permalink: /processes/barrverb.html
---
# BarrVerb

![BarrVerb]({{ site.img }}/reference/processes/barrverb.png "BarrVerb Reverb Effect")

BarrVerb is a vintage-inspired digital reverb effect based on the classic Alesis MIDIVerb algorithms. It recreates the distinctive sound of 1980s digital reverbs, perfect for retro aesthetics, creative sound design, and adding character to modern productions.

## Overview

BarrVerb provides:
- Authentic vintage digital reverb algorithms
- Multiple reverb types and settings
- Real-time parameter control
- CPU-efficient implementation
- Classic 1980s digital reverb character

Based on the open-source [BarrVerb project](https://github.com/ErroneousBosh/BarrVerb), which recreates the algorithms from the legendary Alesis MIDIVerb series.

## Inputs

| Port | Type | Description |
|------|------|-------------|
| Audio In | Audio | Input audio signal |
| Program | Dropdown | Reverb algorithm/preset | "Hall 1" | See Programs |
| Dry/Wet | Float (0-1) | Balance between dry and reverb signal |

## Outputs

| Port | Type | Description |
|------|------|-------------|
| Audio Out | Audio | Processed audio with reverb |

## Historical Context

The Alesis MIDIVerb series (1987-1990s) was revolutionary for making digital reverb affordable for home studios. BarrVerb preserves this legacy while adding modern convenience and automation capabilities.

## Related Processes

- [Audio Effects]({{ site.baseurl }}/processes/audio-effects.html) - Other reverb and effects
- [Delay]({{ site.baseurl }}/processes/delay.html) - Echo and delay effects  
- [Chorus]({{ site.baseurl }}/processes/chorus.html) - Modulated effects
- [BitCrusher]({{ site.baseurl }}/processes/bitcrusher.html) - Vintage digital artifacts