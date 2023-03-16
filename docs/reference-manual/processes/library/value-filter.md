---
layout: default

title: Smooth
description: "Applies filtering to smooth out noisy value streams"

parent: Processes
grand_parent: Reference

permalink: /processes/smooth.html
---
# Smooth

![Smooth]({{ site.img }}/reference/processes/value-filter.png "Noise from LFO smoothed out by the filter")

The Smooth process can be used to tame a noisy input stream, coming from a very sensitive sensor for example. The output of this process may be more usable than the raw stream to control other parameters.

## Continuous

This setting will keep smoothing the signal at a regular rate even if there is no input, by assuming that the last input value is being continuously fed in.
This allows to transform a signal with a slow data rate, for instance with a new value every two seconds, into a smooth control signal.

## Amount

0 applies the least amount of filtering, 1 the most.

## Type

There are 4 different filters available: 
* _OneEuro_ for the [1€ filter](https://cristal.univ-lille.fr/~casiez/1euro/).
* _LowPass_ that only uses the low pass implementation from the one euro filter.
* _Average_ for a floating average.
* _Median_ for a floating median.

## Freq (1e/LP)

Minimum cutoff frequency for OneEuro and LowPass, between 0 and 300.

## Cutoff (1e/LP)

Cutoff frequency of the derivative for OneEuro and LowPass, between 0 and 10.

## Beta (1e only)

Cutoff slope for OneEuro, between 0 and 10.