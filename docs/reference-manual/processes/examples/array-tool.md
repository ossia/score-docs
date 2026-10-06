---
layout: default
title: "Array Tool LED Reshaping"
description: "Explore how rearranging numbers changes an LED pattern."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/array-tool.html
score: "/reference/processes/array-tool.score"
---

# Array Tool LED Reshaping

![Arraygen connected through Array tool to a red LED preview and numeric value display.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-array-tool.png)

This example shows how a list of numbers can become an LED pattern. **Array tool** reshapes a generated array, while a numeric display and **LED View** let you compare the values with their colours.

The generator produces 14 values with `100(i+1)`. Folding them into the 0–255 range, spacing them with a stride of 3 and Zero fill, and adding three padding elements on either side changes both the colours and their arrangement.

## Try it

Start playback, inspect the resulting numbers, then change Fold to another range behaviour. Toggle Reverse or vary Rotate to see how ordering changes without changing the generator. Remove the left and right padding to see which dark positions were introduced by the tool. LED View is an in-document preview: this score does not send DMX or require an LED controller.

See [[Array utilities]] and [[LED View]].

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

