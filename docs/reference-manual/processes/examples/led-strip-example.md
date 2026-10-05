---
layout: default
title: "Generated RGB LED Strip"
description: "Preview a 192-value colour array without physical LED hardware."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/led-view.html
score: "/reference/processes/led-view.score"
---

# Generated RGB LED Strip

![Arraygen connected to LED View, which displays rows of generated RGB pixels.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-led-view.png)

**Arraygen** feeds **LED View** with 192 values from `127(1+sin(i*t/1e10))`. The expression changes over time and across the element index. LED View is set to RGB, so successive triples form red, green and blue components: the 192 values describe 64 RGB pixels.

## Try it

Start playback and observe the evolving strip in the process UI. Change the divisor `1e10` to alter the animation speed. Keep Size a multiple of three when comparing complete RGB pixels; doubling it to 384 provides 128 triples.

This is a software preview only. There is no DMX, Art-Net or serial output, and no external media is needed. See [[LED View]] for display modes.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

