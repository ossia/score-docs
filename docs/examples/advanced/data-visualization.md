---
layout: default
title: Data visualization and sonification
description: "See a data curve build a point history while hearing its variations drive synthesized sound."
parent: Advanced
grand_parent: Examples
permalink: /examples/advanced/data-visualization.html
score: /examples/advanced/data-visualization.zip
---

# Data visualization and sonification

![A data curve connected to synthesized sound and a growing visual history]({{ site.baseurl }}/assets/scores/thumbnails/examples-advanced-data-visualization.png)

Follow the same data by eye and ear: a changing curve builds a history of points on screen while controlling synthesized sound. This is a way to explore whether a trend or fluctuation becomes more apparent as motion, as a musical gesture or through the contrast between them.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/data-visualization.zip)

## From measurements to gestures

An imported greenhouse-gas data column plays as an Automation. Statistics expose its mean, variance and consecutive differences, while smoothing turns variation into a more gradual control gesture. Calibrators map statistical changes into useful ranges for colour and delay settings.

The GPU history retains earlier points through a delayed feedback connection. The sound is synthesized from the curve, not a recording of the phenomenon being measured: both sound and image are interpretations shaped by the chosen mappings.

## Setup

Open the ZIP directly in score. The data curve is already imported, so the original CSV is not required. Use a compute-capable graphics backend and Airwindows for TapeDelay2; the history shaders are embedded and use score's native rendering.

## Try it

- Start at a low listening level. Watch the history grow while comparing changes in the sound with the curve and statistical displays.
- Adjust smoothing to compare short fluctuations with a steadier musical gesture. Notice which variations become less prominent.
- Change point size or the colour treatment to compare individual points with the overall shape of the history.
- Import your own data as a replacement curve and reconsider its mappings: a meaningful range for one dataset need not reveal another.

Keep the delayed feedback connection when adapting the visual history; it carries the past values that make the accumulating view possible.
