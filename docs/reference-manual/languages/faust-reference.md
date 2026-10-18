---
layout: default
title: Faust language
description: "Faust syntax, signal composition, libraries and score integration"
parent: Languages
grand_parent: Reference
nav_order: 16
permalink: /reference/languages/faust.html
---

# Faust language reference

[Faust](https://faust.grame.fr) is a functional language for digital signal processing, developed at [GRAME](https://grame.fr) with an international community. A program describes a signal-processing graph rather than a sequence of per-sample imperative statements. score compiles this graph and uses it as an audio processor.

For loading DSP files, editing and compiling them, import paths, portable projects and packages, see the [Faust process]({{ site.baseurl }}/processes/faust.html). This page separates language constructs from the interface provided by score.

## Definitions and program entry point

A runnable DSP defines `process`. Definitions end in `;`; `//` and `/* ... */` introduce comments. Definitions name expressions, not mutable variables. Functions can take named parameters:

```faust
// One input, one output: halve the incoming signal.
half(x) = x * 0.5;
process = half;
```

The identity block `_` passes a signal unchanged; `!` discards one. Numeric expressions can operate on signals. For example, `process = _ * 0.5;` describes the same gain operation. Local definitions can be grouped with `with { ... };`. Metadata such as `declare name "My effect";` describes the program rather than adding a signal connection.

See the authoritative [Faust syntax manual](https://faustdoc.grame.fr/manual/syntax/) for definitions, lexical environments, pattern matching, numeric operators and primitives.

## Signal composition

Faust expressions are block diagrams with a known number of inputs and outputs. Wiring must match their arities; composition operators do not represent imperative statement order.

| Operator | Meaning | Connection rule |
|---|---|---|
| `A, B` | Parallel composition | Place the blocks side by side; retain both sets of inputs and outputs. |
| `A : B` | Sequential composition | Connect each output of `A` to an input of `B`; their counts must match. |
| `A <: B` | Split composition | Repeat the outputs of `A` across the inputs of `B`; the input count of `B` must be a multiple of the output count of `A`. |
| `A :> B` | Merge composition | Sum groups of outputs of `A` into the inputs of `B`; the output count of `A` must be a multiple of the input count of `B`. |
| `A ~ B` | Recursive composition | Feed outputs back through `B` to inputs of `A`, with an implicit one-sample delay in the feedback connection; feedback arities must be compatible. |

Use parentheses to make grouping explicit. For example:

```faust
// Two independently processed channels: two inputs and two outputs.
process = *(0.5), *(0.5);
```

```faust
// Duplicate a single input into two outputs.
process = _ <: _, _;
```

The [diagram-composition reference](https://faustdoc.grame.fr/manual/syntax/#diagram-composition-operations) gives exact arity constraints, precedence, recursion and iteration forms such as `par` and `seq`. Explicit delay primitives and feedback are how signal state is represented; an ordinary definition is not an assignment to stored state.

## Controls

Control primitives produce signals. Slider and numeric-entry arguments are a label, initial value, minimum, maximum and step:

```faust
level = hslider("level", 0.5, 0, 1, 0.01);
process = _ * level;
```

Related primitives include `vslider`, `nentry`, `button` and `checkbox`. Labels name the controls; Faust also supports label metadata and grouping primitives. See the [user-interface primitives](https://faustdoc.grame.fr/manual/syntax/#user-interface-primitives) for the language-level contract. A host chooses how to expose these controls: a Faust UI declaration does not itself create a score QML interface.

## Standard library

Import the standard library to access its namespaced DSP functions:

```faust
import("stdfaust.lib");
level = hslider("level", 0.1, 0, 1, 0.01);
process = os.osc(440) * level;
```

This is a mono generator with no audio input. `os.osc` comes from the oscillator library; the import provides library environments such as `os` rather than requiring every function to be defined in the DSP file.

Common library families include:

* [`os` — oscillators](https://faustlibraries.grame.fr/libs/oscillators/): periodic signal generators.
* [`fi` — filters](https://faustlibraries.grame.fr/libs/filters/): filtering building blocks.
* [`en` — envelopes](https://faustlibraries.grame.fr/libs/envelopes/): amplitude and control envelopes.
* [`de` — delays](https://faustlibraries.grame.fr/libs/delays/): delay-line functions.
* [`ba` — basics](https://faustlibraries.grame.fr/libs/basics/): common DSP utilities.
* [`ma` — maths](https://faustlibraries.grame.fr/libs/maths/): mathematical helpers and constants.

Consult the [full library index](https://faustlibraries.grame.fr/libs/) and [standard functions reference](https://faustlibraries.grame.fr/standardFunctions/) for signatures and examples. Library functions and language primitives are different layers; available library versions depend on the installation and import search path.

## score integration contract

* The compiled DSP determines the process's audio channel counts. A graph with no audio inputs is a generator; an effect consumes its declared input channels.
* Faust sliders, numeric entries, buttons and checkboxes become score controls. Recompiling a different program can therefore change the process interface.
* A synthesizer using the conventional `freq`, `gain` and `gate` controls is detected as MIDI-driven. These names are a score integration convention, not keywords required by the Faust language.
* Editing the source in score does not immediately replace the running DSP: use **Compile** in the process editor.
* score embeds the loaded DSP source, not the entire transitive set of imported libraries. An `import("my-library.lib");` still requires that file to be available through the import search path.
* Compilation requires a score build with Faust support and usable libraries. See the process page for `FAUST_LIB_PATH`, relative import directories and packaging; this is not a guarantee that every external Faust architecture or standalone compiler option is exposed in score.

The [process workflow and portability guide]({{ site.baseurl }}/processes/faust.html#imports-and-portable-projects) is the canonical guide to locating and distributing imported files. Ready-made score DSPs are available in the [Faust user-library presets](https://github.com/ossia/score-user-library/tree/master/Presets/Faust).

## Upstream references

* [Faust documentation](https://faustdoc.grame.fr/)
* [Language syntax and primitives](https://faustdoc.grame.fr/manual/syntax/)
* [Faust standard DSP libraries](https://faustlibraries.grame.fr/)
* [Faust online IDE](https://faustide.grame.fr/) for experimenting with the language outside score; host integration remains different.
