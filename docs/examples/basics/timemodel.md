---
layout: default

title: Time model
description: "Explore how a composition can wait for a performer, enforce timing limits and reunite parallel actions."

parent: Basics
grand_parent: Examples

permalink: /examples/basics/timemodel.html
score: /examples/basics/timemodel.score
---


# Time Model example

![Time Model]({{ site.img }}/examples/basics/timemodel.png "Time Model") 

How much freedom should a performer have before the next passage begins? This silent timeline lets you compare an exact duration, an open-ended wait and an interaction with time limits. Watch the active intervals rather than listening for an output; no media or external setup is required.

## Overview

A minimum duration can keep a gesture from being cut short. A maximum can keep an installation from waiting indefinitely. Between those bounds, a trigger gives the performer control of the transition. The next interval starts from the actual transition, not simply the endpoint drawn on the page.

Conditions decide whether a branch participates at all. Shared end points bring parallel activities together, and loops make it possible to revisit a passage. These are compositional decisions about freedom and coordination, not just ways of drawing a timeline.

## Try it

- Compare A1's fixed duration with A2's open-ended wait. Let A2 wait, then release it: which timing would suit a prerecorded passage, and which would suit a live action?
- Try A3's end trigger before and after its minimum duration. Watch when the interaction becomes available; this bound protects the beginning of a gesture.
- Leave A4 without a trigger until its maximum, then restart and end it yourself. Compare the two starts of the following passage.
- Change a false condition and replay the branch. Then start and end parallel intervals in different orders, watching the shared end and the loop at the bottom. Separate the question “does this happen?” from “when do we move on?”

For a larger annotated collection with floating triggers and auto-retriggering, see [Temporal patterns and synchronization]({{ site.baseurl }}/examples/basics/timemodel-patterns.html).

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Scenario]] - Timeline container with triggers and conditions
- [[Execution engine]] - How interactive execution works
- [[Non-linear timeline]] - Building interactive scenarios
