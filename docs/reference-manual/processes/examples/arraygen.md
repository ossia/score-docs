---
layout: default
title: "Arraygen Signal Study"
description: "Generate three independently moving values from one expression."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/arraygen.html
score: "/reference/processes/arraygen.score"
---

# Arraygen Signal Study

![Arraygen feeding three changing traces into Signal display.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-arraygen.png)

One expression can generate several movements at once. This example uses **Arraygen** to create three values that oscillate at different rates, displayed together in **Signal display**.

The expression `sin((1+i)*0.00000001t)` uses the element index `i` to vary the rate. These are control values, not audio oscillators.

## Try it

Start playback and watch the three traces. Change Size from 3 to 6 to add elements, then change the multiplier of `t` to slow or accelerate the motion. Each additional element evaluates the same expression with a different index. No media files, external devices or network addresses are required.

See [Arraygen expressions]({{ site.baseurl }}/processes/exprtk.html#arraygen) for the expression variables.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

