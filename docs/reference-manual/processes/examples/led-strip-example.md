---
layout: default
title: "Generated RGB LED Strip"
description: "Create moving LED colours with a mathematical expression."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/led-view.html
score: "/reference/processes/led-view.score"
---

# Generated RGB LED Strip

![Arraygen connected to LED View, which displays rows of generated RGB pixels.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-led-view.png)

This example creates an evolving strip of colours without any physical LED hardware. **Arraygen** calculates the colour values, and **LED View** previews the pattern.

The expression `127(1+sin(i*t/1e10))` varies with time and position in the array. Every three values form one RGB pixel, so the 192 generated values describe 64 pixels.

## Try it

Start playback and observe the evolving strip in the process UI. Change the divisor `1e10` to alter the animation speed. Keep Size a multiple of three when comparing complete RGB pixels; doubling it to 384 provides 128 triples.

This is a software preview only. There is no DMX, Art-Net or serial output, and no external media is needed. See [[LED View]] for display modes.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

