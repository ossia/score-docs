---
layout: default
title: Temporal patterns and synchronization
description: "Rehearse repeatable gestures, conditional participation and rendezvous between independent parts of a performance."
parent: Basics
grand_parent: Examples
permalink: /examples/basics/timemodel-patterns.html
score: /examples/basics/timemodel-patterns.score
---

# Temporal patterns and synchronization

![Annotated timeline branches comparing false conditions and synchronization joins]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-timemodel-patterns.png)

An interactive piece may need to repeat a gesture on demand, let one branch sit out, or wait until several activities are ready. These annotated, silent experiments let you watch those timing decisions before attaching sounds, images or stage actions to them.

## Overview

Each group is an independent experiment; active intervals are the visible result. No media or external device is needed. Use the groups as small structures to reuse in a performance rather than as one continuous composition.

A trigger acts on a time sync, while conditions decide which of its events take place. Several branches can therefore share a moment of interaction without all participating. At a join, the state of the incoming branches determines whether the composition can continue together.

## Try it

Start playback, read the nearby annotations, and use each group's trigger buttons while its time syncs are armed.

- Compare `Auto-trigger` and `No auto-trigger` with repeated interactions. Auto-retrigger rearms after execution; a default floating trigger alternates between triggering and cancellation. Notice which behavior would let a performer repeat one gesture without a separate reset.
- Trigger a time sync containing several events. Watch which branches start, then change the false condition and repeat. Sharing a trigger need not mean playing every layer.
- Start both intervals leading to a join. Try ending them before and after their minimum durations, then change the maximum bounds. Observe how the limits change the amount of freedom before the parts must reunite.
- Compare a join with a discarded branch against one whose predecessor has not yet started. A branch that will not run is different from an activity that has not arrived yet.

The horizontal positions organize the demonstrations; disconnected examples do not automatically run when the transport reaches those positions.

To reproduce the structures, drag a selected state's small yellow cross to create another state on the same event. Hold Alt/Option while dragging to create a separate event on the same time sync.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

