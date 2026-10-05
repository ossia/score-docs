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

This scenario contains no media processes, cables or devices. Its output is the timeline's execution state: watch which intervals become active as you exercise their triggers.

## Compare A1–A4

Start playback and inspect the four labelled branches:

- A1 has a fixed duration of about 3.28 seconds, then starts B1 and C1.
- A2 waits for an end trigger with minimum zero and no finite maximum.
- A3 rejects an early end trigger until its minimum of about 1.65 seconds has elapsed.
- A4 permits interaction after about 1.72 seconds but has a maximum around 4.53 seconds, ensuring progression to B4 and C4 even without a trigger.

Restart and try triggering A3 and A4 at different times. Their downstream branches start relative to the actual trigger time, not just the drawn endpoint.

## Conditions and joins

Further branches compare unconditional events with `true == false` conditions, and join two intervals at a shared end trigger. Inspect each predecessor's minimum and maximum bounds before trying the join. At the bottom, a zero-duration interval returns to an earlier time sync, demonstrating a loop rather than a forward-only arrangement.

No external setup is required. For a larger annotated collection with floating triggers and auto-retriggering, see [Temporal patterns and synchronization]({{ site.baseurl }}/examples/basics/timemodel-patterns.html).

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Scenario]] - Timeline container with triggers and conditions
- [[Execution engine]] - How interactive execution works
- [[Non-linear timeline]] - Building interactive scenarios
