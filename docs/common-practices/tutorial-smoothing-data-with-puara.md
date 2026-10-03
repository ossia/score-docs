---
layout: default
title: Accumulation and decay with Puara
description: "Explore the Leaky Integrator with a pulse followed by zero input"
parent: Common practices
nav_order: 25
permalink: /common-practices/tutorial-smoothing-data-with-puara.html
score: /reference/processes/LeakyIntegratorExample.score
---

# Accumulation and decay with Puara

The [Leaky Integrator]({{ site.baseurl }}/processes/gestures.html#leaky-integrator) adds incoming values to a stored accumulator and periodically retains only a fraction of its previous value. It can soften a signal's changes, but it is **not a normalized smoothing filter**: repeated positive input increases the result.

This example needs no sensor or network device. It replaces a constant-input demonstration with an explicit **pulse followed by zero**, so you can distinguish accumulation from decay.

[Download LeakyIntegratorExample.score]({{ site.baseurl }}/assets/scores/reference/processes/LeakyIntegratorExample.score)

## Build or open the graph

The download already contains these connected processes in the base interval:

```
Expression Value Generator → Leaky Integrator → Signal display
```

To construct it yourself, use these process-library entries:

- `Control > Generators > Expression Value Generator`
- `Control > Filtering > Leaky Integrator`
- `Monitoring > Signal display`

Connect generator outlet 0 to **Input**, then the integrator's **Output** to the display's input. Put them in the same interval, with a nominal duration of 15 seconds.

Set the generator's **Expression (ExprTK)** to:

```text
if(pos < 0.1, 1, 0)
```

`pos` is the process's relative position. The generator sends 1 during the first tenth of the interval (about 1.5 seconds here), then continues sending 0. This is a sustained short pulse, not a single-sample impulse. The generator must remain running during the zero phase.

Set **Leak Factor** to `0.99` and **Leak Frequency (Hz)** to `0`, as in the download. Zero frequency is the special mode that applies the retention factor on **every evaluation**, making the recurrence independent of the wall-clock leak timer:

```text
output = input + 0.99 * previous_output
```

## Run and compare

1. Press Play from the beginning. The display should rise during the 1-input phase and fall after the input becomes 0. Its peak depends on how many evaluations occurred; it is not constrained to 1. With these settings and a zero initial state it stays below 100.
2. Stop, reopen the example for a fresh accumulator, change **Leak Factor** to `1`, and replay. The accumulator rises during the pulse and then holds its accumulated value during the zero phase. A factor of 1 does **not** hold the output constant while nonzero input is arriving.
3. Reopen, set the factor to `0` (still at frequency 0), and replay. Each evaluation now discards history: the output follows the pulse, then becomes zero.
4. Reopen, set the factor to `0.5` and frequency to `10`, and replay. Leakage now happens on a timed cadence, while values continue to accumulate between leak steps. Lowering a positive frequency allows more additions between those steps; it does not reduce the generator's update rate.

For a numerical check in the every-evaluation mode, a fresh integrator with factor `0.5` and inputs `1, 0, 0, 0` produces `1, 0.5, 0.25, 0.125`. Playback may evaluate many times during the pulse, so do not mistake that four-call check for the exact trace of this 15-second score.

If nothing appears, confirm playback is active, the generator expression is unchanged, and both cables are present. No OSC device or phone is needed.

*Adapted from the tutorial and example contributed by [yashtiwari9182](https://github.com/ossia/score-docs/pull/71).* 
