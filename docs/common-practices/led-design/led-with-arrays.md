---
layout: default
title: Generate LED arrays with expressions
description: "Compose an LED strip from differently phased numerical patterns, without rendering textures."
parent: LED design
grand_parent: Common practices
nav_exclude: true
permalink: /common-practices/led-design/led-with-arrays.html
score: /common-practices/led-design/led-with-arrays.score
---

# Generate LED arrays with expressions

![R, G and B array generators passing through Array tools into Array Combiner and a final reshaping stage.]({{ site.baseurl }}/assets/scores/thumbnails/common-practices-led-design-led-with-arrays.png)

Create a changing color strip from numbers instead of images, without a shader-rendering stage. Three sine expressions produce related patterns with different phases and lengths; joining them makes a sequence whose sections develop differently over time.

[Download the example]({{ site.baseurl }}/assets/scores/common-practices/led-design/led-with-arrays.score)

{% include try-on-web.html %}

## Try it

Start playback and watch **LED View**. Each **Arraygen** calculates values from time and position in its list, while the **Array tool** stages provide places to reshape the values before and after joining.

Change a phase offset in one expression: its section shifts out of step with the others. Then increase that generator's Size by three: it contributes one more complete RGB triple to the sequence. The generator names R, G and B can be misleading here: **Array Combiner** is in Append mode, joining whole lists end to end, and the preview reads each consecutive triple as a pixel. The generators do not independently control red, green and blue.

To explore that alternative, give all three generators the same Size and switch to Intersperse. Each pixel can then take one value from each generator. This changes the relationship between the expressions and the colors, not just the strip's length.

The expressions can produce negative values. Before adapting the patch for hardware, map or clamp them to the receiver's legal range and keep the final array aligned to complete RGB triples. This score only previews the values; it does not transmit to LEDs. See [LED design]({{ site.baseurl }}/common-practices/13-led-design.html) for device-side setup.
