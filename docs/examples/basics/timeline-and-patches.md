---
layout: default

title: Timeline and patches
description: "An example showing the intersection between timeline-based composition and patch-based processing"

parent: Basics
grand_parent: Examples

permalink: /examples/basics/timeline-and-patches.html
score: /examples/basics/timeline-and-patches.zip
---

# Timeline and Patches

![Timeline and Patches]({{ site.img }}/examples/basics/timeline-and-patches.png "Combining timeline and patches in ossia score")

This example demonstrates how ossia score combines timeline-based composition with dataflow patching.

## Overview

Audio processes can be chained together using cables while still being organized temporally on a timeline. This hybrid approach lets you sequence sounds, automate effects and decide when each part of a patch runs.

The first part keeps a sound and its effects inside one interval. The second separates the source from two effect intervals, letting you activate them independently. A cable describes a connection, but does not keep a process running outside its interval.

## Try it

Open the ZIP directly in score, configure audio output, and ensure Faust and Airwindows are available. The archive includes the two sound files; their process labels retain older names.

- Play the first interval and listen to the automated filtering. Try changing an automation or effect control.
- Activate `Trigger me first`, then `Then me` to hear the source through the first effect interval.
- Activate `Finally me` to switch to the second effect interval. End the source and effects separately to explore their lifetimes.
- Switch between timeline and nodal views: both present the same processes, with emphasis on timing or connections respectively.

Use **Ctrl+click** or **Ctrl+drag** in the nodal view to select several processes, then move or copy them together. Cable drags can start from a port's name as well as its circle. See [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html) for replacement, auto-scrolling and nested paste behavior.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Scenario]] - Timeline and scenario container reference
- [[Audio routing]] - How audio signals flow through the system
- [[Audio plugins]] - VST, Faust, JSFX and other effect formats
- [[Automation]] - Parameter automation over time
