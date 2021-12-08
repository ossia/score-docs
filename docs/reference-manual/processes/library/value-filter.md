---
layout: default

title: Value Fliter
description: "Applies filtering to smooth out noisy value streams"

parent: Processes
grand_parent: Reference

permalink: /processes/value-fliter.html
---
# Value Filter

![Value Filter]({{ site.img }}/reference/processes/value-filter.png "Noise from LFO smooth out by the value filter")

The Value Filter can be used to tame a noisy input stream, from a very sensitive sensor for exemple. The output of this process may be more usable than the raw stream to control other parameters.

## Amount

0 applies the least amount of filtering, 1 the most.

## Type

There are 4 different filters available : 
* _OneEuro_ for the [one euro filter](https://cristal.univ-lille.fr/~casiez/1euro/) 
* _LowPass_ that only uses the low pass implementation from the one euro filter
* _Average_ for a floating average
* _Medain_ for a floating median

## Freq (1e/LP)

Minimum cutoff frequency for OneEuro and LowPass, between 0 and 300.

## Cutoff (1e/LP)

Cutoff frequency of the derivative for OneEuro and LowPass, between 0 and 10.

## Beta (1e only)

Cutoff slope for OneEuro, betwee 0 and 10.