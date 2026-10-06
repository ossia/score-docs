---
layout: default
title: "Mapping Tool Range Study"
description: "Explore how mapping changes the shape and range of a signal."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/mapping-tool.html
score: "/reference/processes/mapping-tool.score"
---

# Mapping Tool Range Study

![LFO branching to Mapping tool and a signal display, with a second display plotting the shaped output.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-mapping-tool.png)

Mapping can change more than a signal's scale. This example compares an LFO with a folded and curved version of the same movement, using two displays to show the difference.

The LFO extends beyond the mapping's input range. **Mapping tool** folds those out-of-range values back into the range, applies Tanh shaping and produces a 0–1 output. Learn min and Learn max are initially off.

## Try it

Start playback and compare the two displays. Switch Fold to clipping to see how the treatment of out-of-range values differs. Enable range learning while the LFO runs, then turn it off to freeze the observed bounds. Adjust Curve to compare nonlinear shaping against the original signal.

The source and displays are internal; no external files or addresses are required. See [[Mapping tool]].

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

