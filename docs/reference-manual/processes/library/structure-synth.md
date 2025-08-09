---
layout: default

title: Structure Synth
description: "Procedural 3D geometry generation with EisenScript"

parent: Processes
grand_parent: Reference

permalink: /processes/structure-synth.html
---
# Structure Synth

![Structure Synth]({{ site.img }}/reference/processes/structure-synth.png "Structure Synth")

Generate complex 3D geometry using rule-based procedural algorithms. Write programs in EisenScript (a simple domain-specific language) and watch as recursive rules create intricate 3D structures, organic forms, and architectural patterns.

Perfect for procedural art, architectural visualization, generative design, or any project where you need complex 3D geometry that would be tedious to model by hand.

## How it works

Structure Synth interprets EisenScript programs that define recursive rules for generating 3D geometry. You write rules that describe how shapes should transform, combine, and multiply, then the system executes these rules to build complex 3D meshes.

**EisenScript input** - A text program defining geometric rules  
**Rule execution** - Recursive rule application with transformations  
**3D output** - Generated mesh with position and normal data  
**Real-time generation** - Changes to the script trigger immediate regeneration

## EisenScript basics

EisenScript is a straightforward language focused on geometric transformations and rule-based generation:

```eisenscript
set maxdepth 2000

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

**Settings**: Control generation parameters like `maxdepth` for recursion limits  
**Rules**: Define patterns with `rule RuleName w weight { commands }`  
**Transformations**: `x` (translate), `ry` `rz` (rotate), `s` (scale)  
**Color**: `hue`, `sat` (saturation), `a` (alpha) for HSV coloring  
**Primitives**: `box` and other basic 3D shapes

## Rule-based generation

The power of Structure Synth comes from recursive rule application:

**Rule weights**: Multiple rules with the same name create probabilistic choices - `rule R1 w 10` means this version has weight 10.

**Recursive calls**: Rules can call themselves or other rules, creating self-similar structures with variations.

**Transformation context**: Each rule execution maintains its own transformation state, allowing complex nested transformations.

**Termination**: Rules stop recursing when `maxdepth` is reached or when geometry becomes too small to matter.

## Creative applications

**Procedural architecture**: Generate building-like structures, cities, or architectural details that would take hours to model manually.

**Organic forms**: Create tree-like structures, coral patterns, or other natural-looking forms through recursive growth rules.

**Abstract art**: Build complex geometric sculptures with mathematical precision and organic variation.

**Installation design**: Generate unique 3D forms for each performance or exhibition, ensuring your installations are always fresh.

**Animation base**: Use Structure Synth to create base geometry, then animate parameters over time for evolving 3D structures.

## Advanced EisenScript features

**Color systems**: Full HSV color control with hue, saturation, and alpha parameters that can be inherited and modified by child rules.

**Random variations**: Built-in randomization ensures that weighted rules create natural-looking variation in generated structures.

**Complex transformations**: Combine multiple transformations in single commands for sophisticated geometric operations.

**Nested structures**: Rules can create both primitive shapes and recursive sub-structures in the same execution.

## Integration with score

Structure Synth integrates perfectly with *score*'s 3D pipeline for visual installations and performances.

**Parameter animation**: Use [[Automation]] to change script parameters over time for animated geometry generation.

**Interactive control**: Connect sensor data or [[OSC]] input to modify generation parameters in real-time.

**3D rendering**: Generated geometry works with all of *score*'s 3D rendering and lighting systems.

**Performance optimization**: Generation happens on background threads to avoid blocking the main interface.

## Workflow and performance

**Start simple**: Begin with basic rules and single primitives before building complex recursive systems.

**Manage recursion**: Use appropriate `maxdepth` values - too high can create millions of polygons and freeze the system.

**Test incrementally**: Build rules step by step, testing each addition before making the system more complex.

**Performance monitoring**: Watch polygon counts and generation times to keep your projects running smoothly during performances.

## File management

**Script saving**: Structure Synth programs save with your *score* projects and can be edited directly in the interface.

**Library integration**: Save `.es` EisenScript files to your library for reuse across projects.

**Drag and drop**: Drop `.es` files directly into *score* to load them into Structure Synth processes.

**Version control**: Since scripts are text-based, they work well with version control systems for collaborative projects.

## Troubleshooting

**Empty output**: Check your rule names match between definitions and calls - typos prevent rule execution.

**System freezing**: Reduce `maxdepth` if generation takes too long or creates too many polygons.

**Unexpected results**: Remember that rules with the same name combine probabilistically - multiple definitions create random choices.

**Color issues**: HSV values outside normal ranges (hue 0-360, saturation/alpha 0-1) can create unexpected coloring.

## Related processes

Structure Synth works alongside other 3D processes for complete visual installations. Combine with [[3D Model]] for static elements, use [[Video]] processes for texturing, or integrate with spatial audio systems like [[DBAP]] for immersive audiovisual experiences.