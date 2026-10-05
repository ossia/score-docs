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

The patch connects **Arraygen** directly to **Signal display**. Its expression, `sin((1+i)*0.00000001t)`, uses the element index `i` to give each of the three values a different rate. It is a value-array example, not an audio oscillator.

## Try it

Start playback and watch the three traces. Change Size from 3 to 6 to add elements, then change the multiplier of `t` to slow or accelerate the motion. Each additional element evaluates the same expression with a different index. No media files, external devices or network addresses are required.

See [Arraygen expressions]({{ site.baseurl }}/processes/exprtk.html#arraygen) for the expression variables.

[Download this example]({{ site.scores }}{{ page.score }})
