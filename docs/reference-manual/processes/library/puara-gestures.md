---
layout: default
title: Puara Gestures
parent: Processes
grand_parent: Reference


nav_order: 60
---

# Puara Gestures

This section describes the processes ported from the [Puara-gestures](https://github.com/Puara/puara-gestures/) library. This library provides a powerful toolkit for creating and managing high-level gestural descriptors from sensor data.

---

## Leaky Integrator

The **Leaky Integrator** process applies a smoothing algorithm to an input signal. It's particularly useful for reducing jitter from noisy sensors or creating smooth transitions in parameter values. The amount of smoothing can be controlled in real-time by adjusting the leak factor and the update frequency.

### Parameters

| Parameter               | Description                                                                                                                              |
| :---------------------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
| **Inputs**              |                                                                                                                                          |
| `Input`                 | The incoming signal to be smoothed.                                                                                                      |
| `Leak Factor`           | A `float` from 0.0 to 1.0 that controls the amount of smoothing. A value of `0.0` means the output immediately jumps to the new input (no smoothing), while a value of `1.0` means the output does not change (full smoothing). Default is `0.5`. |
| `Leak Frequency (Hz)`   | A `float` from 0.0 to 200.0 Hz that sets the rate at which the integrator updates its value. The control uses a logarithmic mapping for more intuitive musical control. Default is `100.0`. |
| **Outputs**             |                                                                                                                                          |
| `Output`                | The smoothed output signal.                                                                                                              |


---

## Roll

The **Roll** process calculates the side-to-side tilt (roll angle) of a device. It uses a combination of accelerometer, gyroscope, and magnetometer data for a stable and accurate orientation reading. This is ideal for gestural control where you want to map the rotation of a device (like a phone) to a parameter.

The process includes built-in options for transforming the output:
- **Unwrap:** Prevents the angle from jumping when it crosses the -π to +π boundary, allowing for continuous rotation tracking.
- **Smooth:** Averages recent values to reduce jitter from noisy sensors.
- **Wrap:** Confines the final output to a specific range (e.g., 0 to 2π).

### Parameters

| Parameter          | Description                                                                                             |
| :----------------- | :------------------------------------------------------------------------------------------------------ |
| **Inputs**         |                                                                                                         |
| `Acceleration`     | Expects 3D coordinate data (`{x, y, z}`) from an accelerometer.                                         |
| `Gyroscope`        | Expects 3D coordinate data (`{x, y, z}`) from a gyroscope.                                              |
| `Magnetometer`     | Expects 3D coordinate data (`{x, y, z}`) from a magnetometer.                                           |
| `Enable Unwrap`    | A boolean toggle. When `true`, allows the output angle to increase or decrease indefinitely. Default is `true`.  |
| `Enable Smooth`    | A boolean toggle. When `true`, applies a smoothing filter to the output. Default is `true`.                    |
| `Enable Wrap`      | A boolean toggle. When `true`, wraps the final output to a specific range (e.g., 0 to 2π). Default is `false`. |
| **Outputs**        |                                                                                                         |
| `Output`           | The calculated roll angle in radians.                                                                   |



---

## Tilt

The **Tilt** process calculates the forward-and-backward tilt (also known as "pitch") of a device. It uses a combination of accelerometer, gyroscope, and magnetometer data to provide a stable and accurate orientation reading. This is useful for gestural control where you want to map the forward/backward tilting of a device to a parameter.

### Parameters

| Parameter      | Description                                                                     |
| :------------- | :------------------------------------------------------------------------------ |
| **Inputs**     |                                                                                 |
| `Acceleration` | Expects 3D coordinate data (`{x, y, z}`) from an accelerometer.                 |
| `Gyroscope`    | Expects 3D coordinate data (`{x, y, z}`) from a gyroscope.                      |
| `Magnetometer` | Expects 3D coordinate data (`{x, y, z}`) from a magnetometer.                   |
| **Outputs**    |                                                                                 |
| `Output`       | The calculated tilt (pitch) angle in radians, ranging from `-π/2` to `+π/2`.    |




---

## Shake

The **Shake** process detects shaking gestures from 3D accelerometer data. It calculates the overall magnitude of the shake, making it ideal for triggering events or controlling parameters based on energetic motion. The detection algorithm's sensitivity and response curve can be finely tuned using the provided parameters.

### Parameters

| Parameter                   | Description                                                                                                                              |
| :-------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
| **Inputs**                  |                                                                                                                                          |
| `Acceleration`              | Expects 3D coordinate data (`{x, y, z}`) from an accelerometer.                                                                          |
| `Integrator Frequency (Hz)` | A `float` from 0.0 to 200.0 Hz that sets the update rate of the internal smoothing filter. Higher values are more responsive. Default is `10.0`. |
| `Fast Leak`                 | A `float` from 0.0 to 1.0. This controls how quickly the shake value increases when a shake is detected (i.e., when motion exceeds the `Activation Threshold`). A lower value means a faster rise. Default is `0.6`. |
| `Slow Leak`                 | A `float` from 0.0 to 1.0. This controls how quickly the shake value decays when the device is still. A lower value means a faster decay. Default is `0.3`. |
| `Activation Threshold`      | A `float` from 0.0 to 1.0 that sets the motion sensitivity. Acceleration above this threshold is considered a shake. Default is `0.1`. |
| **Outputs**                 |                                                                                                                                          |
| `Output`                    | The calculated shake magnitude, a single `float` value.                                                                                  |