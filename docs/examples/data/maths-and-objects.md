---
layout: default
title: Math expressions and structured objects
description: "An example showing how to transform numbers, lists and structured data"
parent: Data processing
grand_parent: Examples
permalink: /examples/data/maths-and-objects.html
score: /examples/data/maths-and-objects.score
---

# Math expressions and structured objects

![An expression filter producing signal traces above Object filter queries and value displays]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-maths-and-objects.png)

This example demonstrates two ways to transform data: mathematical expressions for numerical signals, and queries for lists and structured objects. The displays let you compare each input with its result before using the same ideas to control media or devices.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/maths-and-objects.score)

## Try numerical expressions

Start playback and explore one example at a time. Change a generator's parameter to shift its waveform, then compare that with scaling an incoming signal using `x*a+b`.

Arraygen applies an expression to each index `i`, with `n` representing the array size. Try changing its expression, then use Arraymap to transform the resulting values. The array examples also compare current values (`xv`) with previous values (`pxv`), allowing an expression to describe change rather than just a current position. Keep the indexed filter's input at least five elements long unless you also change its expressions.

The trigger example detects a falling value with `x < px` and turns that comparison into an impulse for an envelope. Watch the input, boolean result and envelope together; this demonstrates control data rather than audible synthesis.

## Try structured data

With the Jk Object filter add-on available, compare the queries applied to a small object. Select a field with `.foo`, combine fields arithmetically, or build a list from them. The saved arithmetic example produces 589.5.

The list examples show the difference between selecting an index, taking a slice and emitting elements separately. In particular, compare `.` with `.[]`: one retains the whole input, while the other produces individual elements. Edit one query at a time to keep the difference between a list and several messages visible.

No devices or media files are required. The unconnected audio, MIDI and shader processes do not produce an audiovisual output. For syntax, see [ExprTK expressions]({{ site.baseurl }}/processes/exprtk.html).
