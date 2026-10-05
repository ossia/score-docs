---
layout: default
title: "Mapping Tool Range Study"
description: "Compare an incoming LFO with a folded and shaped output."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/mapping-tool.html
score: "/reference/processes/mapping-tool.score"
---

# Mapping Tool Range Study

The LFO is wired to one **Signal display** and to **Mapping tool**. A second display shows the mapped result. The saved LFO has amplitude 2 and a near-zero offset, while the mapping input range is approximately −1.073 to 1.079. The signal therefore crosses the learned range rather than staying inside it.

The mapping uses Fold range behaviour, Tanh shaping and a 0–1 output range. Learn min and Learn max are initially off.

## Try it

Start playback and compare the two displays. Switch Fold to clipping to see how the treatment of out-of-range values differs. Enable range learning while the LFO runs, then turn it off to freeze the observed bounds. Adjust Curve to compare nonlinear shaping against the original signal.

The source and displays are internal; no external files or addresses are required. See [[Mapping tool]].

[Download this example]({{ site.scores }}{{ page.score }})
