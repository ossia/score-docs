---
layout: default

title: Smoothing and filtering
description: "An example showing how to smooth data"

parent: Automation
grand_parent: Examples

permalink: /examples/automation/smoothing.html
score: /examples/automation/smoothing-and-filtering.score
---

# Smoothing and filtering

![Smoothing]({{ site.img }}/examples/automation/smoothing-and-filtering.png "Smoothing and filtering")

This example demonstrates how to turn noisy, uncontrolled data into data that is easier to use for mappings.

## Overview

Smoothing can make a sensor or controller feel steadier, but too much smoothing also delays its response. Here, generated noise stands in for a live input so you can compare several filters without connecting hardware. Signal and Value displays show the raw input, a One Euro filter, exponential averages and a calibrated result.

## Compare the results

1. Start playback in nodal view. No external sensor, media file or audio output is required: the noisy input is generated in the patch.
2. Compare the raw Signal display with the three Exp Smoothing displays. Their saved Alpha values are 0.5, 0.3 and 0.01; lower Alpha smooths more strongly and responds more slowly.
3. Adjust Smooth's One Euro settings while comparing its display with the raw input. Look for a balance between following larger changes and suppressing rapid fluctuations.
4. Compare the calibrated displays with the unscaled smoothed values. Change Calibrator's output Range to see how the same movement can be adapted to a parameter with a different usable range.
5. Change a noise parameter and use Calibrator's Reset to observe it learning the changed input range.

Smoothing reduces rapid variation; calibration adapts the range. They are separate stages in this example, rather than two names for the same operation.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Smooth]] - Smooth process
- [[Smooth|Exp Smoothing]] - Simple exponential average
- [[Calibrator]] - Adapt to live input with unknown or variable range over a time span