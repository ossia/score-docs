---
layout: default
title: "Mapping Tool Range Study"
description: "Compare folding, clipping and nonlinear shaping before applying a movement to an artwork."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/mapping-tool.html
score: "/reference/processes/mapping-tool.score"
---

# Mapping Tool Range Study

![LFO branching to Mapping tool and a signal display, with a second display plotting the shaped output.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-mapping-tool.png)

The same incoming movement can produce repeated reversals, flat plateaus or a sharply curved response. This patch places an LFO beside its remapped output so you can see how a mapping changes the character of a gesture, not just its scale. Use the technique when adapting a sensor or automation curve to a visual or sound parameter.

The LFO exceeds **Mapping tool**'s input bounds. Fold reflects the excess back into range, Tanh reshapes the response, and the output is scaled to 0–1. The source is quantized, so some steps already exist before mapping.

## Try it

Start playback and compare the two displays. Switch Fold to clipping: values beyond the bounds now stop at an edge instead of turning back. Enable Learn min and Learn max while the LFO runs, then disable them to keep the measured bounds. Compare the result with the original narrow range to see why calibration affects the movement.

Adjust Curve to vary the nonlinear response. Only the mapped display should change; the source remains a reference for what your mapping adds. See [[Mapping tool]].

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

