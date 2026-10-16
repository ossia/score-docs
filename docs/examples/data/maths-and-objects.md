---
layout: default
title: Math expressions and structured objects
description: "Reshape a control gesture, detect its direction and extract useful fields from structured input before connecting it to media."
parent: Data processing
grand_parent: Examples
permalink: /examples/data/maths-and-objects.html
score: /examples/data/maths-and-objects.score
---

# Math expressions and structured objects

![An expression filter producing signal traces above Object filter queries and value displays]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-maths-and-objects.png)

Make a control signal fit the response you want: enlarge its movement, shift its range, detect a downward change, or extract one useful field from a larger message. The plots and value displays expose each transformation before you adapt it to a sound parameter, animation or light. The score itself produces control data, not an audiovisual performance.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/maths-and-objects.score)

## Try numerical expressions

Start playback and explore one branch at a time. In the generator, change parameter `a` and watch the waveform shift. Then use the `x*a+b` filter to change an incoming signal: `a` scales its movement and `b` shifts its baseline. Compare the input and output before choosing a range for a media parameter.

Arraygen makes a family of values by evaluating an expression at each index `i`; `n` is the array size. Change an expression and watch the traces separate or move together, then compare the result after Arraymap's `pow(x,3)` transformation. This is a useful way to design related movements rather than duplicate a single gesture across every destination.

The indexed filter also compares current values (`xv`) with previous values (`pxv`). Keep its input at least five elements long unless you change the expressions too. A previous value lets you describe *change*, not just position.

In the trigger branch, `x < px` detects a falling value and produces an impulse for an envelope. Watch the input, comparison and envelope together. Change the comparison to `x > px` and observe the response move to rising changes: the direction of a gesture can become a cue.

## Try structured data

The structured-data branch requires the Jk Object filter add-on. Compare `.foo`, which selects one field, with queries that combine fields or build a list. Change a value in the source object and follow only the outputs that depend on it. This is the same preparation you would need before using part of a sensor or network message as a control.

In the list examples, compare `.` with `.[]`: the former keeps the whole input together; the latter emits its elements separately. Then compare selecting an index with taking a slice. Decide whether your destination needs one value, a group, or a sequence of events before choosing a query.

No devices or media files are required. For expression syntax, see [ExprTK expressions]({{ site.baseurl }}/processes/exprtk.html).
