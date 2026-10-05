---
layout: default
title: "Array Tool LED Reshaping"
description: "Fold and rearrange a generated array before viewing its RGB values."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/array-tool.html
score: "/reference/processes/array-tool.score"
---

# Array Tool LED Reshaping

![Arraygen connected through Array tool to a red LED preview and numeric value display.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-array-tool.png)

Arraygen evaluates `100(i+1)` for 14 elements. Its output passes through **Array tool** and then branches to **Value display** and **LED View**, so the numeric result and its colour interpretation can be compared.

The saved Array tool uses a 0–255 range with Fold behaviour, a stride of 3 with Zero fill, and three elements of post-padding on each side. This is deliberately not a simple one-to-one display of the source array.

## Try it

Start playback, inspect the resulting numbers, then change Fold to another range behaviour. Toggle Reverse or vary Rotate to see how ordering changes without changing the generator. Remove the left and right padding to see which dark positions were introduced by the tool. LED View is an in-document preview: this score does not send DMX or require an LED controller.

See [[Array utilities]] and [[LED View]].

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

