---
layout: default

title: Structure Synth
description: "Procedural 3D geometry generation with EisenScript"

parent: Processes
grand_parent: Reference

permalink: /processes/structure-synth.html
---
# Structure Synth

![Structure Synth]({{ site.img }}/reference/processes/structuresynth.png "Structure Synth")

Generate complex 3D geometry using rule-based procedural algorithms. Write programs in [EisenScript](https://structuresynth.sourceforge.net/reference.php) (a simple domain-specific language) and watch as recursive rules create intricate 3D structures, organic forms, and architectural patterns.

Perfect for procedural art, architectural visualization, generative design, or any project where you need complex 3D geometry that would be tedious to model by hand.

This is based on the code from the original [Structure Synth](https://structuresynth.sourceforge.net) software, which was ported to ossia.

## How it works

Structure Synth interprets EisenScript programs that define recursive rules for generating 3D geometry. You write rules that describe how shapes should transform, combine, and multiply, then the system executes these rules to build complex 3D meshes.

Be careful about having too much recursion: this will cause the mesh generation to take sometimes multiple seconds.

## EisenScript basics

EisenScript is a straightforward language focused on geometric transformations and rule-based generation:

```eisenscript
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


## Try it!

Try it by downloading this [simple example!]({{ site.scores }}/reference/processes/structure-synth.score)