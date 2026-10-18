---
layout: default
title: Context Free and CFDG
description: "Shape grammars, adjustments and the upstream Context Free language reference."
parent: Languages
grand_parent: Reference
nav_order: 27
permalink: /reference/languages/context-free.html
---

# Context Free and CFDG

Context Free generates an image from a *context-free design grammar* (CFDG). Rules replace a named shape with other shapes until the result consists of drawable primitives. score exposes this language through [[Context-Free Art]]; image generation is not a real-time shader operation.

## Language reference

The [official Context Free manual](https://github.com/MtnViewJohn/context-free/wiki) covers the language. Its reference sections include:

- [Startshape](https://github.com/MtnViewJohn/context-free/wiki/Startshape-Directive): the root shape from which generation begins.
- [Shape rules](https://github.com/MtnViewJohn/context-free/wiki/Shape-Rules): definitions, parameters and weighted alternatives.
- [Shape adjustments](https://github.com/MtnViewJohn/context-free/wiki/Shape-Adjustments): relative position, scale, rotation, color and opacity.
- [Expressions](https://github.com/MtnViewJohn/context-free/wiki/Expressions): arithmetic, functions and random expressions.
- [Control flow](https://github.com/MtnViewJohn/context-free/wiki/Control-Flow): loops, conditions and transformations.
- [Version 2 syntax](https://github.com/MtnViewJohn/context-free/wiki/Version-2-Syntax): the older grammar used by many existing designs.

Choose the syntax matching your program; do not combine the older `rule` form with newer `shape` syntax indiscriminately. The upstream manual also describes the standalone application's capabilities, not a promise that score exposes every renderer or export option.

## Reading a grammar

The essential elements are a starting shape, definitions for named shapes, primitive shapes such as squares or circles, and adjustments attached to each invocation. A child inherits its parent's drawing state with those adjustments applied. Reusing a shape definition therefore creates related forms at different sizes, positions and colors without duplicating the drawing instructions.

Recursion is a way to elaborate a form, not a timeline loop. A recursive branch that continually reduces its scale eventually becomes too small to draw; a design that keeps producing large visible shapes can require much more work. Establish a modest static design before trying a more expensive grammar during a performance.

## Relation to other languages in score

Use [EisenScript]({{ site.baseurl }}/reference/languages/eisenscript.html) for rule-based 3D geometry. The two languages share ideas but have different syntax, transformation rules and termination behaviour. For per-frame image effects and GPU feedback, use [ISF]({{ site.baseurl }}/reference/languages/isf.html) instead of treating CFDG as a fragment shader.
