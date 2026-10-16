---
layout: default

title: Timeline and patches
description: "Bring audio effects in and out independently of a sound source, combining a fixed signal path with live timing choices."

parent: Basics
grand_parent: Examples

permalink: /examples/basics/timeline-and-patches.html
score: /examples/basics/timeline-and-patches.zip
---

# Timeline and Patches

![Timeline and Patches]({{ site.img }}/examples/basics/timeline-and-patches.png "Combining timeline and patches in ossia score")

Keep a sound playing while changing which effects are active around it. This score connects audio processing with timeline decisions, so you can compose not only an effect's settings but also when that effect becomes part of the performance.

## Overview

The first passage keeps a sound and its effects in one interval: they share a lifetime. The second separates the source from two effect intervals, letting you activate and end them independently.

Cables define where audio can go; intervals determine when the connected processes run. This distinction is useful for a live passage that moves between treatments without restarting its source, or for an installation whose processing changes with its current scene.

## Try it

Open the ZIP directly in score, configure audio output at a low level, and ensure Faust and Airwindows are available. The sounds are included.

- Play the first interval and alter its filter automation. Listen to a change within the passage while the source and effects remain active together.
- Activate `Trigger me first`, then `Then me`. Listen for the treatment that appears when the effect interval starts, even though the source already began.
- Activate `Finally me` to switch to the second effect interval. End the source and effects separately; compare removing the input with ending the processing itself.
- Switch between timeline and nodal views. Follow one audio connection in nodal view, then find the intervals that govern its source and destination in the timeline.

Use **Ctrl+click** or **Ctrl+drag** in the nodal view to select several processes, then move or copy them together. Cable drags can start from a port's name as well as its circle. See [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html) for replacement, auto-scrolling and nested paste behavior.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Scenario]] - Timeline and scenario container reference
- [[Audio routing]] - How audio signals flow through the system
- [[Audio plugins]] - VST, Faust, JSFX and other effect formats
- [[Automation]] - Parameter automation over time
