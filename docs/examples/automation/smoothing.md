---
layout: default

title: Smoothing and filtering
description: "Compare how filters steady a noisy control signal, how much response they sacrifice, and how calibration fits the result to a useful range."

parent: Automation
grand_parent: Examples

permalink: /examples/automation/smoothing.html
score: /examples/automation/smoothing-and-filtering.score
---

# Smoothing and filtering

![Raw and filtered control curves beside calibrated value displays]({{ site.img }}/examples/automation/smoothing-and-filtering.png "Smoothing and filtering")

A responsive instrument should follow an intentional gesture without amplifying every small fluctuation. Here, several displays show the same noisy signal with different amounts of smoothing. Compare how much motion disappears and how much delay the filtering introduces before using the technique with a sensor or controller.

## Steadiness and range are different decisions

Generated noise stands in for live input. Parallel filters let you compare the raw signal with a One Euro filter and three exponential averages. A separate calibration stage takes the One Euro result and adapts it to an output range. Smoothing changes how the signal moves; calibration changes the range it occupies.

## Compare the results

1. Start playback in nodal view. The example needs no sensor, media or audio output: the result is visible in the Signal and Value displays.
2. Compare the three Exp Smoothing curves with the raw input. Their Alpha values are 0.5, 0.3 and 0.01. Lower Alpha removes more rapid variation but follows changes more slowly. Choose which balance would suit a sustained lighting fade and which would suit a quick gesture.
3. Adjust Smooth's One Euro settings while watching its curve beside the raw signal. Look for a setting that suppresses small fluctuations without losing larger changes you want to retain.
4. Change Calibrator's output Range and compare the numeric values before and after it. The movement can stay recognizable while being fitted to a destination's usable limits.
5. Change a noise parameter, then press Calibrator's Reset. Watch the calibrated result as it learns the changed input range instead of assuming the old range still applies.

To adapt this to an installation, replace the generated noise with your sensor data and compare the raw and filtered paths before connecting the final control. The saved score does not control a sound or light; its displays help you make that mapping decision.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

## Learn more

- [[Smooth]] - Smooth process
- [[Smooth|Exp Smoothing]] - Simple exponential average
- [[Calibrator]] - Adapt to live input with unknown or variable range over a time span