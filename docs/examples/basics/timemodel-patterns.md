---
layout: default
title: Temporal patterns and synchronization
description: "An example showing interactive timing and synchronization patterns"
parent: Basics
grand_parent: Examples
permalink: /examples/basics/timemodel-patterns.html
score: /examples/basics/timemodel-patterns.score
---

# Temporal patterns and synchronization

![Annotated timeline branches comparing false conditions and synchronization joins]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-timemodel-patterns.png)

This example demonstrates temporal patterns for interactive composition: retriggering a gesture, choosing which events happen together, and waiting for several activities to finish.

## Overview

The annotated timeline is a collection of independent experiments. It contains no media; the result is visible in the intervals that become active during playback. No external files or devices are needed.

Triggers belong to time syncs, while conditions belong to their events. This distinction lets several events share a moment of interaction without necessarily all taking place.

## Try it

Start playback, read the nearby annotations, and use each group's trigger buttons while its time syncs are armed.

- Compare `Auto-trigger` and `No auto-trigger`. Try repeated interactions: auto-retrigger rearms after execution, whereas a default floating trigger alternates between triggering and cancellation.
- Trigger a time sync containing several events. Compare the unconditional events with the branch whose condition is false.
- Start both intervals leading to a join, then try ending them before and after their minimum durations. Change the maximum bounds to explore how long the join can wait.
- Compare joins containing a discarded branch with joins whose predecessor has not yet started.

The horizontal positions organize the demonstrations; disconnected examples do not automatically run when the transport reaches those positions.

To reproduce the structures, drag a selected state's small yellow cross to create another state on the same event. Hold Alt/Option while dragging to create a separate event on the same time sync.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

