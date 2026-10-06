---
layout: default
title: Generate LED arrays with expressions
description: "Create LED colour patterns with mathematical expressions."
parent: LED design
grand_parent: Common practices
nav_exclude: true
permalink: /common-practices/led-design/led-with-arrays.html
score: /common-practices/led-design/led-with-arrays.score
---

# Generate LED arrays with expressions

![R, G and B array generators passing through Array tools into Array Combiner and a final reshaping stage.]({{ site.baseurl }}/assets/scores/thumbnails/common-practices-led-design-led-with-arrays.png)

This example creates moving LED colours from numbers alone. Three expressions produce changing arrays, which are combined and reshaped into a colour pattern without using images or shaders.

[Download the example]({{ site.baseurl }}/assets/scores/common-practices/led-design/led-with-arrays.score)

{% include try-on-web.html %}

## Try it

Start playback and inspect the three **Arraygen** processes named R, G and B. Their sine expressions use different phase offsets and generate arrays of different lengths. **Array tool** reshapes the values before and after they are joined, and **LED View** previews the result in RGB mode.

Despite the generator names, Append does not interleave three equal-sized red, green and blue planes. The saved patch concatenates differently sized arrays and LED View consumes consecutive triples as RGB pixels. Change the expressions' phase offsets or generator sizes to see the resulting color pattern; use a suitable combining/reordering operation if you want one separate plane per color channel.

The sine expressions can produce negative values. Before sending the list to hardware, adapt the mapping or Array tool clamping to the receiver's legal range and ensure the final length is a multiple of three.

No devices, textures or media files are required for the numerical effect. The document only previews the array; it does not transmit to LEDs. See [LED design]({{ site.baseurl }}/common-practices/13-led-design.html) for device-side setup.
