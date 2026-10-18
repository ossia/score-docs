---
layout: default
title: EisenScript
description: "Rules, transformations and termination in Structure Synth's geometry language."
parent: Languages
grand_parent: Reference
permalink: /reference/languages/eisenscript.html
---

# EisenScript

EisenScript describes a 3D structure as a set of shape-producing rules. score's [[Structure Synth]] process interprets the program and outputs geometry. It is a geometry-building language, not GLSL: rendering and materials belong to the downstream graphics processes.

The [upstream EisenScript reference](https://structuresynth.sourceforge.net/reference.php) documents the complete grammar, transformations, rule modifiers and primitives. Its standalone application also has export and rendering features; those should not be confused with score's process controls.

## Program structure

A program contains top-level actions and named `rule` blocks. Calling a rule at the top level starts generation; there is no separate `startshape` directive as in [Context Free]({{ site.baseurl }}/reference/languages/context-free.html).

This example, previously on the Structure Synth process page, grows a chain of flattened boxes with two equally weighted ways to turn:

```text
set maxdepth 200

{ a 0.9 hue 30 } R1

rule R1 w 10 {
  { x 1 rz 3 ry 5 } R1
  { s 1 1 0.1 sat 0.9 } box
}

rule R1 w 10 {
  { x 1 rz -3 ry 5 } R1
  { s 1 1 0.1 } box
}
```

`box` emits a primitive. `R1` invokes another rule. Both definitions of `R1` are alternatives: the interpreter chooses one according to its weight, rather than executing both bodies. The recursive call transforms the coordinate frame inherited by the next invocation.

## Transformations and rules

| Construct | Meaning |
|---|---|
| `{ ... } shape` | Apply a local transformation and invoke a primitive or rule. |
| `x`, `y`, `z` | Translate along the local axes. |
| `rx`, `ry`, `rz` | Rotate about the local axes, in degrees. |
| `s value` / `s x y z` | Uniform / per-axis scale. |
| `h` or `hue` | Add to hue, wrapping around the hue circle. |
| `sat`, `b`, `a` | Multiply saturation, brightness or alpha. |
| `rule name { ... }` | Define a rule body. |
| `rule name w weight { ... }` | Give an alternative rule a relative selection weight. |
| `count * { ... } shape` | Repeat an invocation with an accumulated transformation. |

Transformation order matters: the upstream language applies transformations from the rightmost one. Rotation followed by translation is not generally interchangeable with translation followed by rotation. Use the upstream reference for matrix transforms, reflections and the full colour vocabulary.

## Termination and reproducibility

Recursive generation needs a stopping condition. `set maxdepth` bounds recursion, while `set maxobjects` bounds the number of generated objects. Rule-level `maxdepth` can stop one rule or substitute a finishing rule. Size limits can terminate individual branches. `set seed` selects the random seed for repeatable rule choices.

These are language controls over generation, not timeline durations. Large branching grammars can still take substantial time to build. In score, **Regenerate** requests a new mesh; moving a camera or transforming the existing mesh does not require rebuilding the grammar. See the [Structure Synth process]({{ site.baseurl }}/processes/structure-synth.html) for its file, port and rendering workflow.
