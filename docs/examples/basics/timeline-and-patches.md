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

This archive contrasts a patch contained inside one interval with audio cables crossing between independently triggered intervals.

## Prepare and follow the routing

Open the ZIP directly in score. It includes `comping1.wav` and `lick2.wav`. Their process labels retain older names; these are the files actually loaded. Configure audio output and ensure Faust and Airwindows are available.

1. Start playback. The interval labelled `Patches are within timelines` loops `comping1.wav` through ChorusEnsemble and Lowpass. RMS measures the chorus output, and Micromap's `1000x+200` drives the lowpass cutoff.
2. Activate `Trigger me first` to start the separate `lick2.wav` source. It is cabled to both FX1 and FX2, but those effect intervals must also be active to process it.
3. Activate `Then me` to start FX1: AngleFilter → Chamber2. Its output enters the parent mix.
4. Activate `Finally me` to end FX1 and start FX2: CrunchCoat → Faust smoothDelay. A linked looping sequence automates CrunchCoat's Dry/Wet, delay time and feedback.
5. Trigger the source and effect intervals' ends independently. Notice that a cable does not extend a process's lifetime beyond its interval.

Lowpass, Chamber2 and smoothDelay use parent-mix routing, ultimately reaching `audio:/out/main`; there is no separate DAC process.

Switching between timeline and nodal views changes how the same processes are presented: the timeline controls when an interval runs, while cables define the connections between processes. A connected process in an inactive interval does not run merely because its cables are visible.

Use **Ctrl+click** or **Ctrl+drag** in the nodal view to select several processes, then move or copy them together. Cable drags can start from a port's name as well as its circle. See [Editing workflow]({{ site.baseurl }}/reference/editing-workflow.html) for replacement, auto-scrolling and nested paste behavior.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Scenario]] - Timeline and scenario container reference
- [[Audio routing]] - How audio signals flow through the system
- [[Audio plugins]] - VST, Faust, JSFX and other effect formats
- [[Automation]] - Parameter automation over time
