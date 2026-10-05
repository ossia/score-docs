---
layout: default
title: Delayed value feedback
description: "Iterate a logistic map with an explicit one-tick feedback cable."
parent: Data processing
grand_parent: Examples
permalink: /examples/data/value-feedback.html
score: /examples/data/value-feedback.score
---

# Delayed value feedback

![Float and Micromap connected to a Signal display showing the irregular logistic-map trace]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-value-feedback.png)

Iterate a logistic map with an explicit one-tick feedback cable.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/value-feedback.score)

## Run the recurrence

Start playback and inspect Signal display. Float starts at 0.95 and feeds Micromap's `3.68 x (1-x)`. The result goes both to the display and back to Float's Value inlet over a delayed cable, so each tick computes from the preceding iteration rather than creating an immediate dependency cycle.

Try a different Float seed between zero and one, then compare the evolving trace. You can also change 3.68 to a lower coefficient, such as 2.5, to contrast irregular behavior with convergence. Keep the return cable delayed when modifying the graph: that delay is the mechanism demonstrated here, not an incidental display setting.

No external files or devices are needed for the calculation. A Window device is saved in the document but no texture is routed to it; the expected output is the numerical Signal display, not a rendered image.
