---
layout: default
title: "Array Tool LED Reshaping"
description: "Turn a rising list of values into a red LED pattern, then reshape its brightness and spacing."
parent: Processes
grand_parent: Reference
nav_exclude: true
permalink: /reference/process-examples/array-tool.html
score: "/reference/processes/array-tool.score"
---

# Array Tool LED Reshaping

![Arraygen connected through Array tool to a red LED preview and numeric value display.]({{ site.baseurl }}/assets/scores/thumbnails/reference-processes-array-tool.png)

A row of red lights can come from nothing more than a rising list of numbers. Here, **Array tool** turns that list into a pattern with controlled brightness, spacing and dark ends. Compare the numeric display with **LED View** to understand how array operations translate into the placement of light.

The generator produces 14 values with `100(i+1)`, quickly exceeding an LED channel's 0–255 range. Folding brings them back into that range. A stride of 3 with Zero fill places each value in the red channel of an RGB triple, leaving green and blue dark; three padding elements at either end add a black pixel.

## Try it

Start playback, then switch Fold to another range behaviour and compare the red intensities. Toggle Reverse to turn the pattern around without changing its source. Remove the left and right post-padding to remove the dark end pixels. Each operation changes a different aspect of the same list, making this a useful preparation stage between pattern generation and LED output.

LED View is an in-document preview; no LED controller is needed, and this score does not transmit to hardware.

See [[Array utilities]] and [[LED View]].

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

