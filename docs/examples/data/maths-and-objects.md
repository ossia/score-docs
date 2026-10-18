---
layout: default
title: Math expressions and structured objects
description: "Reshape a control signal, detect its direction and extract fields from structured input before connecting it to media."
parent: Data processing
grand_parent: Examples
permalink: /examples/data/maths-and-objects.html
score: /examples/data/maths-and-objects.score
---

# Math expressions and structured objects

![An expression filter producing signal traces above Object filter queries and value displays]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-maths-and-objects.png)

Make a control signal fit the response you want: enlarge its movement, shift its range, detect a downward change, or extract one field from a larger message. Plots and value displays show each transformation. The score itself produces control data, not an audiovisual performance.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/maths-and-objects.score)

## Try numerical expressions

Start playback and explore one branch at a time. In the generator, change parameter `a` and watch the waveform shift. Then use the `x*a+b` filter to change an incoming signal: `a` scales its movement and `b` shifts its baseline, as the input and output plots show.

Arraygen makes a family of values by evaluating an expression at each index `i`; `n` is the array size. Change an expression and watch the traces separate or move together, then watch how Arraymap's `pow(x,3)` reshapes them. Each destination gets a related but distinct movement.

The indexed filter also compares current values (`xv`) with previous values (`pxv`). Keep its input at least five elements long unless you change the expressions too. A previous value lets you describe *change*, not just position.

In the trigger branch, `x < px` detects a falling value and produces an impulse for an envelope. Watch the input, comparison and envelope together. Change the comparison to `x > px` and the envelope now fires on rising changes instead.

## Try structured data

The structured-data branch requires the Jk Object filter add-on. `.foo` selects one field; other queries combine fields or build a list. Change a value in the source object: only the outputs that depend on it update.

In the list examples, `.` keeps the whole input together, while `.[]` emits its elements separately. Selecting an index gives one value; taking a slice gives a shorter list.

No devices or media files are required. For expression syntax, see [ExprTK expressions]({{ site.baseurl }}/processes/exprtk.html).
