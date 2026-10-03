---
layout: default

title: Gestures
description: "Puara leaky integration, roll, tilt and shake descriptors"

parent: Processes
grand_parent: Reference

permalink: /processes/gestures.html
---
# Gestures

These native processes use the [Puara Gestures](https://github.com/Puara/puara-gestures) library. They produce continuous values, not named gesture events. Install or enable the Puara add-on if they are absent from the process library.

## Leaky Integrator

**Library:** `Control > Filtering > Leaky Integrator`

The Leaky Integrator is a **timed accumulator**, not a normalized exponential moving average. Each evaluation adds the input to the stored value. When a leak step is due, the old value is first multiplied by the **Leak Factor**:

```
leak step:      output = input + leak_factor * previous_output
between steps: output = input + previous_output
```

| Port or control | Type / range | Default | Meaning |
|---|---|---|---|
| Input | Float | — | Value added on each evaluation. |
| Leak Factor | 0–1 | 0.5 | Fraction of the old accumulator retained at a leak step. |
| Leak Frequency (Hz) | 0–200 | 100 | Timed leakage cadence, not the input sampling rate or output rate. Fractional values are truncated to an integer. At 0, leakage is applied on every evaluation. |
| Output | Float | — | Accumulated value; not constrained to 0–1. |

A factor of **1** does not freeze the output: it disables decay, so nonzero input keeps accumulating. A factor of **0** discards history on leak steps, but still accumulates between those steps. With zero input, a factor below 1 and continued evaluations let the state decay. Lowering a positive leakage frequency allows more additions between leak steps; it does not simply make the process update less often.

The result depends on the number of evaluations as well as the wall-clock leakage cadence. Do not interpret it as normalized energy or an integral scaled by elapsed time.

See [Accumulation and decay with Puara]({{ site.baseurl }}/common-practices/tutorial-smoothing-data-with-puara.html) for a pulse-then-zero example.

## Roll

**Library:** `Analysis > Gestures > Roll`

Roll estimates side-to-side orientation from three motion-sensor vectors. Inputs must use the same device axes, in **x, y, z** order.

| Port or control | Type / units | Default | Meaning |
|---|---|---|---|
| Acceleration | Three components, g | — | Accelerometer including gravity. |
| Gyroscope | Three components, degrees/second | — | Angular velocity, not an orientation angle. |
| Magnetometer | Three components, gauss | — | Magnetic field. |
| Enable Unwrap | Toggle | On | Tracks crossings of the raw −π to π boundary. |
| Enable Smooth | Toggle | On | Averages a 50-value history. |
| Enable Wrap | Toggle | Off | Applies the fixed 0 to 2π wrapping range. There are no range controls. |
| Output | Float, radians | — | Roll after the enabled processing stages. |

The order is **raw roll → optional unwrap → optional smooth → optional wrap**. Enable Unwrap can produce angles beyond one turn only while final wrapping is disabled. With all three toggles off, the raw output is in −π to π. Smoothing is a sample-history average, not a user-adjustable time constant.

Android physical-unit streams need explicit conversions: acceleration in m/s² ÷ 9.80665, gyroscope in rad/s × 180/π, and magnetic field in µT ÷ 100. A vector connection alone does not perform these conversions.

**Validation limit:** a synthetic three-stream OSC check exercised Roll successfully, but the shared orientation implementation requires further investigation after the Tilt failure described below. The phone tutorial and downloadable orientation examples are withheld rather than presented as dependable tracking workflows.

## Tilt

**Library:** `Analysis > Gestures > Tilt`

Tilt derives a tilt descriptor from **all three** sensor vectors. The native wrapper passes acceleration, gyroscope and magnetometer to the orientation algorithm on each evaluation; it does not expose a two-sensor mode.

| Port | Type / units | Meaning |
|---|---|---|
| Acceleration | Three components, g | Accelerometer including gravity, x/y/z. |
| Gyroscope | Three components, degrees/second | Angular velocity, x/y/z. The current UI spells this inlet **Gyrosocope**. |
| Magnetometer | Three components, gauss | Magnetic field, x/y/z. |
| Output | Float | Scaled vertical component of the orientation's rotated axis, not an `asin`-derived pitch angle. Do not rely on the nominal −π/2 to π/2 range; see the runtime limitation below. |

There are no unwrap, wrap or smoothing controls on this process. The implementation computes `euler.tilt = c_temp.z * π/2`, so it should not be treated as a calibrated pitch angle. Input units and conversions are the same as Roll.

**Runtime limitation:** a Linux development-build check using three synthetic OSC streams produced unstable Tilt output outside the nominal −π/2 to π/2 range. The sensor-fusion constructor initializes its quaternion but leaves its Euler and gyro-bias fields uninitialized; the exact cause of the observed failure has not been established. The tutorial and download are withheld pending an application-side investigation, not hidden behind output clamping or a selected passing input.

Source: `score-addon-puara/Puara/Tilt.cpp`, `include/puara/descriptors/tilt.h` and the vendored `IMU_Sensor_Fusion/imu_orientation.{h,cpp}`. Source inspection of the intended equations does not supersede the failed runtime check.

## Shake

**Library:** `Analysis > Gestures > Shake`

Shake takes acceleration in **m/s²**, unlike Roll and Tilt. For each axis, the algorithm adds `abs(acceleration) / 10` to an accumulator when the absolute input exceeds its internal threshold; otherwise it adds zero and uses the slow leak. The output is the Euclidean magnitude of the three axis accumulators.

| Port or control | Type / range | Default | Meaning |
|---|---|---|---|
| Acceleration | Three components, m/s² | — | x/y/z acceleration. Gravity is **not** removed internally. |
| Integrator Frequency (Hz) | 0–200 | 10 | Timed leakage cadence; truncated to an integer. At 0, every evaluation is a leak step. Not the sensor sampling rate. |
| Fast Leak | 0–1 | 0.6 | Old-state fraction retained on leak steps while that axis is above threshold. Lower values retain less accumulated activity. |
| Slow Leak | 0–1 | 0.3 | Old-state fraction retained on leak steps while that axis is at or below threshold. Lower values decay faster. |
| Activation Threshold | 0–1 | 0.1 | **Currently ineffective:** exposed in the UI, but not forwarded by the native wrapper. The internal per-axis threshold remains 0.1 m/s². |
| Output | Float, nonnegative | — | Magnitude, not a boolean trigger or a normalized 0–1 value. |

**Current limitations:** changing Activation Threshold does not change sensitivity. Raw phone accelerometer readings include gravity, so a stationary phone can still produce sustained output. For example, constant `(0, 0, 9.80665)` input with frequency 0 and the default fast leak tends towards a magnitude of about 2.45166, not zero.

A motion-only application needs independently verified gravity-removed acceleration in m/s² before Shake. Learn that stream from the chosen device; do not assume the raw accelerometer address provides it. Add an explicit comparison downstream if a discrete trigger is required. The threshold-tuning / “stop moving to reach zero” phone exercise is not provided because the current wrapper and raw-gravity input do not support those claims.