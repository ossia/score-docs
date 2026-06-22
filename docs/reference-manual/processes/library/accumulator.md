---
layout: default

title: Accumulator
description: "Accumulate running statistics (sum, mean, variance, …) of a value stream"

parent: Processes
grand_parent: Reference

permalink: /processes/accumulator.html
---
# Accumulator

<!-- TODO screenshot: ![Accumulator]({{ site.img }}/reference/processes/accumulator.png "Accumulator") -->

Keeps running statistics over the stream of numeric values it receives. Each time a new
value comes in, every statistic is updated and emitted, so the Accumulator can drive other
parameters from the behaviour of an input over time (e.g. smoothing, normalisation,
analysis).

## In

The incoming `float` values to accumulate.

## Reset

A toggle that clears all accumulated statistics and starts over.

## Outputs

For the values received since the last reset:

* **Sum** — total of all values.
* **Count** — number of values received.
* **Consecutive difference** — difference between the last two values.
* **Mean** — running average.
* **Variance** — running variance.
* **Median** — running median.
* **Kurtosis** — distribution shape.
* **Min** / **Max** — smallest and largest values seen.
