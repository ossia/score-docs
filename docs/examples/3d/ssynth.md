---
layout: default

title: Structure Synth Example
description: "An example showing generative 3D meshes with Structure Synth"

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/ssynth.html
score: /examples/3d/ssynth.score
---

# Structure Synth

<video controls>
    <source src="{{ site.img }}/examples/3d/ssynth.mp4" type="video/mp4">
</video>

This example demonstrates using Structure Synth for procedural 3D geometry generation.

## Overview

[[Structure Synth]] is a tool for creating complex 3D structures using a simple rule-based grammar. 
*score* integrates Structure Synth as a geometry producer. Editing the program or requesting Regenerate builds a new mesh; this is not a per-frame GPU grammar evaluation. Keep recursion bounded when changing the program during playback.

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

The rule describes a spiral of boxes when invoked. A runnable program also needs a bounded recursion setting and a call to `R1`; see the complete program in [[Structure Synth]].

## Try it

Start playback to view the saved NablaSystem structure. Its geometry goes to native Model Display; Sine Warp Gradient passes through Exposure Adjust to provide the texture. A looping colour automation changes the gradient, while an LFO mapped through `360x` rotates the structure. Adjust the LFO speed to separate rotation from regeneration, then edit the bounded Structure Synth program and request Regenerate to rebuild it.

The result is sent to `Window:/`. The program and shaders are embedded and need no external model file. This uses native Model Display, not Qt Quick 3D.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Structure Synth]] - Structure Synth process reference
- [[Model display]] - 3D mesh rendering
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
