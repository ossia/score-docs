---
layout: default

title: Time model
description: "A basic example presenting the different timeline configurations"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/timemodel.html
score: /examples/basics/timemodel.score
---


# Time Model example

![Time Model]({{ site.img }}/examples/basics/timemodel.png "Time Model") 

This example showcases the different interactive features in the *score* timeline: triggers, interactive conditions and loops.

## Overview

A timeline need not have a fixed duration. Intervals can wait for a performer, enforce a minimum time before continuing, or have a maximum duration that ensures the piece moves on. Conditions decide which branches run, while shared end points synchronize parallel activities.

This example contains no media: watch the active intervals during playback to see how these structures behave. No external setup is required.

## Try it

- Compare A1's fixed duration with A2's open-ended wait for a trigger.
- Trigger A3 early, then after its minimum duration. Notice when the interaction is accepted.
- Let A4 reach its maximum without a trigger, then restart and end it yourself. The following intervals start relative to the actual end, not just the drawn endpoint.
- Explore the false conditions, shared end triggers and the loop at the bottom. Try starting and ending the parallel intervals in different orders.

For a larger annotated collection with floating triggers and auto-retriggering, see [Temporal patterns and synchronization]({{ site.baseurl }}/examples/basics/timemodel-patterns.html).

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Scenario]] - Timeline container with triggers and conditions
- [[Execution engine]] - How interactive execution works
- [[Non-linear timeline]] - Building interactive scenarios
