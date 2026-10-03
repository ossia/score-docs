---
layout: default
title: Accumulator
description: "Collect running statistics and control when they are emitted"
parent: Processes
grand_parent: Reference
permalink: /processes/accumulator.html
---

# Accumulator

**Accumulator** collects statistics over numeric values arriving at **In**, from startup or the most recent reset. It is a running accumulator, not a fixed-size rolling window. Ticks without an input value do not add samples.

## Controls and emission

| Control | Meaning |
|---|---|
| Reset | Clears all accumulated samples and restarts the alternating difference. Updating this control triggers the reset; it is not a pause switch. |
| Output | Impulse requesting emission in Manually mode. It does not clear the statistics. |
| Send | EveryTick, OnInput or Manually. |

- **EveryTick** emits the current statistics every processing tick, including ticks with no new sample.
- **OnInput** emits when a sample arrives, and once following a reset. A reset with no new sample emits zeros.
- **Manually** continues collecting samples but emits only when **Output** is triggered. Trigger **Output** after a reset to read the cleared state.

All nine outlets are emitted together. Before any sample has been collected, emission produces zeros. Suppressed ticks produce no new output events rather than repeated values.

## Statistics

| Output | Meaning |
|---|---|
| Sum | Sum of the collected samples. |
| Count | Number of samples, carried by a numeric float outlet. |
| Mean | Arithmetic mean. |
| Variance | Running variance estimate. |
| Median | Running median estimate. |
| Kurtosis | Running kurtosis statistic. |
| Min / Max | Smallest and largest collected values. |
| Consecutive difference | Alternating cumulative sum: `x1 - x2 + x3 - x4 + …`. |

Despite its name, **Consecutive difference is not the difference between the last two values**. For inputs `10, 3, 8`, it successively reports `10, 7, 15`; **Sum** becomes `21` and **Count** becomes `3`. Reset starts again with a positive term. Statistics such as kurtosis should not be treated as meaningful for an insufficient or degenerate sample set.

## Example

To measure a sensor gesture, reset at its beginning, feed samples into **In**, select **Manually**, and trigger **Output** at its end. Use **Min**, **Max** and **Mean** to characterize the gesture without streaming reports on every tick. For other value transformations, see [[Mapping utilities]].
