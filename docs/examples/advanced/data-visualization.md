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

Follow the same data by eye and ear: a changing curve builds a history of points on screen while controlling synthesized sound.

{% include try-on-web.html %}

[Download the example]({{ site.baseurl }}/assets/scores/examples/advanced/data-visualization.zip)

## From data to control values

An imported greenhouse-gas data column plays as an Automation. Statistics expose its mean, variance and consecutive differences, while smoothing turns variation into a more gradual control signal. Calibrators map statistical changes onto the ranges of the color and delay settings.

The GPU history retains earlier points through a delayed feedback connection. The sound is synthesized from the curve, not a recording of the phenomenon being measured: both sound and image are interpretations shaped by the chosen mappings.

## Setup

Open the ZIP directly in score. The data curve is already imported, so the original CSV is not required. Use a compute-capable graphics backend and Airwindows for TapeDelay2; the history shaders are embedded and use score's native rendering.

## Try it

- Start at a low listening level. Watch the history grow and match changes in the sound to the curve and statistical displays.
- Increase smoothing: short fluctuations fade from the sound, leaving the slower trend.
- Lower point size to pick out individual points, or raise it to see the overall shape of the history.
- Import your own data as a replacement curve and reconsider its mappings: a meaningful range for one dataset need not reveal another.

Keep the delayed feedback connection when adapting the visual history; it carries the past values that make the accumulating view possible.
