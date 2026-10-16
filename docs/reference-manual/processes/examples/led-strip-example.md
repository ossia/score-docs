---
layout: default
title: "Generated RGB LED Strip"
description: "Preview a changing strip of 64 RGB pixels generated from time and position."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/led-view.html
score: "/reference/processes/led-view.score"
---

# Generated RGB LED Strip

![Arraygen connected to LED View, which displays rows of generated RGB pixels.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-led-view.png)

Watch a strip of colours evolve from a single expression, without an image source or physical LEDs. This is a compact way to sketch a lighting rhythm before adapting it to a strip or a larger installation.

**Arraygen** calculates `127(1+sin(i*t/1e10))` for every element of a list. Time changes the values, while the element index gives each one a different rhythm. **LED View** reads consecutive groups of three as red, green and blue: 192 values become 64 coloured pixels.

## Try it

Start playback and watch the preview in the process UI. Increase the divisor `1e10` to slow the changes, or decrease it to accelerate them. Remove the `i*` factor to make all channels move together; the contrast reveals how variation across the list creates colour and spatial detail.

To extend the pattern, change Size to another multiple of three; 384 values provide 128 complete RGB pixels. This score only previews those values. Sending them to physical LEDs requires a separately configured output; see [[LED View]] for preview modes.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

