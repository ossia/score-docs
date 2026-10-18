---
layout: default
title: Delayed value feedback
description: "Generate a changing control signal by feeding a calculation back into itself, and switch it between irregular motion and convergence."
parent: Data processing
grand_parent: Examples
permalink: /examples/data/value-feedback.html
score: /examples/data/value-feedback.score
---

# Delayed value feedback

![Float and Micromap connected to a Signal display showing the irregular logistic-map trace]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-value-feedback.png)

Create variation without drawing a long automation curve. Each value in this patch becomes the seed of the next calculation, producing a trace that keeps changing even though the rule stays the same. The signal is shown in a display; nothing is heard or rendered.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/value-feedback.score)

## Try it

Start playback and watch the Signal display. Micromap repeatedly applies `3.68 x (1-x)`, beginning with the Float value as a seed. The result returns through Float and becomes the next input: the system's recent state drives its future.

1. Set a new seed strictly between zero and one. The trace never repeats like an LFO. Try a nearby seed: after a few steps the two traces diverge completely.
2. Change the coefficient from 3.68 to 2.5. The values settle to a resting point instead of continuing their irregular motion.
3. Restore 3.68 to bring back the continuous movement.

The return cable is delayed by one tick. This makes the loop an iteration using the preceding result instead of an immediate dependency cycle. Keep that delay when replacing the expression with another recurrence.

No external files or devices are needed. If you connect the result to sound, light or motion in your own work, map it to an appropriate range first; the numerical experiment alone does not establish safe limits for a destination.
