---
layout: default
title: "Arraygen Signal Study"
description: "Build a family of related control movements by varying one expression across an array."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/arraygen.html
score: "/reference/processes/arraygen.score"
---

# Arraygen Signal Study

![Arraygen feeding three changing traces into Signal display.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-arraygen.png)

Make several related movements without drawing a separate automation curve for each one. **Arraygen** evaluates one expression for every element of a list; here, three oscillations run at different rates and appear together in **Signal display**. The same technique could give a group of lights or visual parameters a shared rhythm with individual variation.

In `sin((1+i)*0.00000001t)`, time `t` drives the motion and the element index `i` changes its rate. These are control values, not audio oscillators.

## Try it

Start playback and compare the three traces: later elements oscillate faster. Change Size from 3 to 6 to extend that family of movements, then reduce the multiplier of `t` to slow them all together. Finally, remove the `(1+i)*` factor to make every element follow the same motion. That contrast shows what the index contributes.

See the [ExprTK variable reference]({{ site.baseurl }}/reference/languages/exprtk.html#available-variables) for the variables supplied to Arraygen and the other expression processes.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

