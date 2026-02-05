---
layout: default

title: Structure Synth Example
description: "An example showing generative 3D meshes with Structure Synth"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/ssynth.html
---

# Structure Synth

This example demonstrates using Structure Synth for procedural 3D geometry generation.

## Overview

Structure Synth is a tool for creating complex 3D structures using a simple rule-based grammar. ossia score integrates Structure Synth, allowing real-time generative geometry.

## What is Structure Synth?

Structure Synth uses a context-free grammar to define 3D structures:

- **Rules** define transformations (rotate, scale, translate)
- **Recursion** creates complex patterns
- **Randomness** adds variation
- **Parameters** allow real-time control

## Example structure

A simple Structure Synth rule might look like:
```
rule R1 {
  { x 1 rz 5 s 0.99 } R1
  box
}
```

This creates a spiral of boxes.

## Parameters

Structure Synth processes expose parameters for:
- Iteration depth
- Transformation amounts
- Color variations
- Seed values

## Creative applications

Structure Synth is great for:
- Architectural visualizations
- Abstract art
- Music visualizations
- Generative design
- Data visualization

## Try it

Open this example to see generative 3D geometry in action. Modify the LFO to change the animation!

[Download this example]({{ site.scores }}/examples/3d/ssynth.score)

## Learn more

- [[Structure Synth]] - Structure Synth process reference
- [[Model display]] - 3D mesh rendering
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
