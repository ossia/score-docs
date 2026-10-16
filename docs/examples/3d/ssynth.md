---
layout: default

title: Structure Synth Example
description: "Build a recursive structure, then bring it to life with rotation and changing colour."

parent: 3D Graphics
grand_parent: Examples

permalink: /examples/3d/ssynth.html
score: /examples/3d/ssynth.score
---

# Structure Synth

<video controls>
    <source src="{{ site.img }}/examples/3d/ssynth.mp4" type="video/mp4">
</video>

Build an intricate structure from a short set of rules, then let colour and rotation reveal its repeating forms. The saved NablaSystem is useful as a starting point for generative sculptures whose construction and performance can be designed separately.

[[Structure Synth]] creates the mesh on the CPU. The resulting geometry is sent to native Model Display with a changing gradient texture; an LFO rotates it slowly. Editing the grammar or requesting Regenerate changes the structure itself, whereas the texture and rotation can keep changing during playback without rebuilding the mesh.

## Changing the structure

A rule can repeat a shape while translating, rotating and shrinking each successive copy:

```
rule R1 {
  { x 1 rz 5 s 0.99 } R1
  box
}
```

This fragment describes a spiral of boxes when invoked. A runnable program also needs a bounded recursion setting and a call to `R1`; see the complete program in [[Structure Synth]]. Keep recursion bounded: generation runs on the CPU and can take time.

## Try it

Start playback and change the LFO speed to see how rotation reveals the structure. Edit the colour automation to change its palette without changing its geometry. Then modify the saved grammar and request Regenerate to compare a structural change with those surface and movement changes.

The program and shaders are embedded; no external model is needed.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Structure Synth]] - Structure Synth process reference
- [[Model display]] - 3D mesh rendering
- [[LFO]] - Low-frequency oscillator for animation
- [[Graphics pipeline]] - How rendering works in ossia score
