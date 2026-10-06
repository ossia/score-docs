---
layout: default
title: Delayed value feedback
description: "An example showing how feedback can generate evolving control signals"
parent: Data processing
grand_parent: Examples
permalink: /examples/data/value-feedback.html
score: /examples/data/value-feedback.score
---

# Delayed value feedback

![Float and Micromap connected to a Signal display showing the irregular logistic-map trace]({{ site.baseurl }}/assets/scores/thumbnails/examples-data-value-feedback.png)

This example demonstrates feedback in a numerical process: each result becomes the input for the next calculation. A logistic map makes the evolving behavior visible, from convergence to irregular changes.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/data/value-feedback.score)

## Try it

Start playback and watch the Signal display. The expression `3.68 x (1-x)` is applied repeatedly, beginning with the Float value as a seed.

Try a different seed between zero and one and compare the evolving trace. Then reduce the coefficient from 3.68 to a value such as 2.5 to contrast irregular behavior with convergence.

The return cable is delayed by one tick. This is what makes the calculation an iteration: it uses the preceding result instead of creating an immediate dependency cycle. Keep that delay when adapting the example to another recurrence.

No external files or devices are needed. The result is shown numerically in the Signal display; the saved Window device has no image routed to it.
