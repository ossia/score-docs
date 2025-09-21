---
layout: default

title: Mapping tool
description: "Advanced parameter mapping with range learning and curve shaping"

parent: Processes
grand_parent: Reference

permalink: /processes/mapping-tool.html
---
# Mapping Tool

![Mapping tool]({{ site.img }}/reference/processes/mapping-tool.png "Mapping tool") 

The swiss-army knife of parameter transformation. This process takes incoming values and maps them to completely different ranges, with intelligent learning, curve shaping, and deadzone handling. Think of it as a super-powered version of the [[Mapping Utilities|Range Mapper]] with automatic calibration.

You can drag'n'drop this into your score whenever you need to:
- Calibrate sensors automatically by learning their actual ranges
- Shape controller responses with mathematical curves  
- Handle noisy inputs with deadzones
- Convert between completely different parameter scales
- Create complex, non-linear mappings on the fly

Perfect for interactive installations where you don't know exactly what ranges your sensors will produce, or when you want to fine-tune controller response curves during performance.

## How it works

Set your input range with **Min** and **Max** - or better yet, turn on **Learn Min** and **Learn Max** and let the process figure out your sensor's actual range by watching the incoming data. 

The **Deadzone** creates a quiet area around the midpoint where small variations get ignored - great for noisy sensors or joysticks with center drift.

**Shape Behaviour** lets you apply curves to the response:
- **None**: Straight linear mapping
- **Tanh**: S-curve with soft saturation at the ends
- **Sin**: Smooth S-curve
- **Asym**: Asymmetric exponential for uneven response

The **Curve** knob does power-law shaping - negative values give exponential curves (slow start, fast finish), positive values give logarithmic curves (fast start, slow finish).

**Range Behaviour** controls what happens to out-of-bounds values:
- **Clip**: Hard limiting (most common)
- **Wrap**: Values wrap around like a loop
- **Fold**: Values bounce back and forth
- **Free**: Let them go wherever they want

Finally, **Out Min** and **Out Max** set your final output range. You can **Invert** the response or use **Absolute Value** for special cases.

## Common uses

**Sensor calibration**: Turn on Learn Min/Max, exercise your sensor through its full range, then turn learning off. The process automatically figures out the real-world range.

**MIDI controller shaping**: Use Curve: 0.3 with Shape: Tanh to make faders feel more musical - they'll respond more gently in the middle ranges.

**Noisy input cleanup**: Set a small Deadzone around the midpoint to ignore small variations from sensors or controllers with drift.

**Creative effects**: Try Wrap or Fold range behaviors with oscillating inputs for interesting cyclical effects.

The processing order is: Absolute Value → Deadzone → Normalize → Range Behavior → Shape → Curve → Invert → Scale to Output.

This pairs perfectly with the [[Calibrator]] for even more advanced sensor handling, or use the simpler [[Mapping Utilities|Range Mapper]] when you don't need all the bells and whistles.