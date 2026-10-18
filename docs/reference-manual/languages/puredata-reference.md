---
layout: default
title: Pure Data patch language
description: "Pure Data's visual language and the audio, MIDI and message interface exposed by score."
parent: Languages
grand_parent: Reference
permalink: /reference/languages/puredata.html
---

# Pure Data patch language

Pure Data is a visual dataflow language. Object and message boxes, joined by patch cords, describe message processing and audio signal processing. A `.pd` file stores this graph; it is normally authored in Pure Data rather than typed into score's script editor. score hosts the patch through [libpd](https://github.com/libpd/libpd).

## Language and object reference

- [Pure Data manual](https://msp.ucsd.edu/Pd_documentation/index.htm): the upstream language and environment manual.
- [Theory of operation](https://msp.ucsd.edu/Pd_documentation/2.theory.of.operation.htm): boxes, messages, signal connections, scheduling, abstractions and arrays.
- [Messages and evaluation order](https://msp.ucsd.edu/Pd_documentation/2.theory.of.operation.htm#s2.4): message types, hot/cold inlets and right-to-left outlet ordering.
- [Audio signals](https://msp.ucsd.edu/Pd_documentation/2.theory.of.operation.htm#s2.5): tilde objects, DSP blocks and conversions between signals and messages.
- [Externals](https://msp.ucsd.edu/Pd_documentation/4.externals.htm): abstractions, compiled objects and their dependencies.

For an individual object, open its **Help** patch in Pure Data. A library installed in your standalone Pd environment is not automatically available in score's embedded runtime; keep that distinction in mind when choosing externals.

## Audio, MIDI and message ports

The following is score's host interface, relocated from the [Pure Data process page]({{ site.baseurl }}/processes/puredata.html):

| Pd objects | score interface |
|---|---|
| `[adc~]`, `[dac~]` | Audio input and output ports. Set the required channel counts in the inspector; channels share a single audio port in each direction. |
| `[midiin]`, `[notein]`, `[ctlin]` | MIDI input. |
| `[midiout]`, `[noteout]`, `[ctlout]` | MIDI output. |
| `[r]` / `[receive]`, `[s]` / `[send]` | Value input and output. |

A Pd audio connection and a message connection are not interchangeable. Use Pd's signal/message conversion objects when crossing that boundary; changing a score port's destination does not change the semantics inside the patch.

## Receive annotations and controls

Receive names can use the [libossia parameter annotation syntax](https://ossia.io/ossia-docs/?plaintext--pd#creating-parameters) to describe a control. This integration remains work in progress: not every annotation combination is implemented.

The documented `widget` names are `intslider`, `floatslider`, `logfloatslider`, `intspinbox`, `toggle`, `button`, `lineedit`, `xyslider` and `hsvslider`.

The existing examples of annotations are:

```text
[r myInput @type float @range -1 1]
[r myInput @widget intslider @min 0 1000]
[r myInput @type impulse]
[r myInput @type bool @default true]
[r myInput @unit color.hsv]
```

These are host annotations on receive objects, not new built-in Pd object classes. Check the resulting score controls before relying on a particular annotation in a performance.

## Execution and editing

Do not use score's **Parallel** execution mode with Pd patches. For loading patches, opening their external editor and closing that editor safely, see [[Pure Data integration]]. For a working sound patch, see [Pure Data integration example]({{ site.baseurl }}/examples/audio/pd-integration.html).
