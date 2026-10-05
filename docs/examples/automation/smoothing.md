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

A Perlin-noise expression, `noise(pos * a * 10, b * 10, c) * 100`, feeds several parallel filters. Signal and Value displays let you compare the input, a One Euro filter, three exponential averages and a calibrated result.

## Compare the results

1. Start playback in nodal view. No external sensor, media file or audio output is required: the noisy input is generated in the patch.
2. Compare the raw Signal display with the three Exp Smoothing displays. Their saved Alpha values are 0.5, 0.3 and 0.01; lower Alpha smooths more strongly and responds more slowly.
3. Inspect Smooth, initially using OneEuro with frequency 300, cutoff 0.04 and beta about 4.661. Adjust its settings while comparing its display with the raw input.
4. Follow Smooth into Calibrator, set to Shape mode with output Range approximately `[0.404, 0.797]`. Compare the calibrated Value and Signal displays with the unscaled smoothed values.
5. Change a noise parameter and use Calibrator's Reset to observe it learning the changed input range.

Smoothing reduces rapid variation; calibration adapts the range. They are separate stages in this example, rather than two names for the same operation.

[Download this example]({{ site.scores }}{{ page.score }})

## Learn more

- [[Smooth]] - Smooth process
- [[Smooth|Exp Smoothing]] - Simple exponential average
- [[Calibrator]] - Adapt to live input with unknown or variable range over a time span