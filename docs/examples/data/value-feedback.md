---
layout: default
title: Delayed value feedback
description: "Generate a changing control gesture by feeding a calculation back into itself, then compare irregular motion with convergence."
parent: Data processing
grand_parent: Examples
permalink: /examples/data/value-feedback.html
score: /examples/data/value-feedback.score
---

# Delayed value feedback

![Float and Micromap connected to a Signal display showing the irregular logistic-map trace]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-value-feedback.png)

Create variation without drawing a long automation curve. Each value in this patch becomes the seed of the next calculation, producing a trace that keeps changing even though the rule stays the same. It is a starting point for autonomous animation or sound modulation; here, you inspect the control signal in a display rather than hear or render it.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/value-feedback.score)

## Try it

Start playback and watch the Signal display. Micromap repeatedly applies `3.68 x (1-x)`, beginning with the Float value as a seed. The result returns through Float and becomes the next input: the system's recent state drives its future.

1. Set a new seed strictly between zero and one. Watch the resulting trace rather than expecting a repeating LFO shape. Try a nearby seed and compare the subsequent variation.
2. Change the coefficient from 3.68 to 2.5. Watch the values settle instead of continuing their irregular motion. A small change in the rule changes the character of the gesture.
3. Restore 3.68. Before adapting the signal to a media parameter, consider the contrast you want: a system that finds a resting point, or one that continues to move.

The return cable is delayed by one tick. This makes the loop an iteration using the preceding result rather than an immediate dependency cycle. Keep that delay when replacing the expression with another recurrence.

No external files or devices are needed. If you connect the result to sound, light or motion in your own work, map it to an appropriate range first; the numerical experiment alone does not establish safe limits for a destination.
