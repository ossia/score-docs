---
layout: default
title: 'Smoothing Data with Puara'
parent: Common practices
nav_order: 25
---

# Smoothing Data with the Leaky Integrator

Rapidly changing data from sensors or generative algorithms can sometimes be too "jittery" for direct use in controlling sound or visuals. We often want to smooth this data to get more organic, gradual changes.

This tutorial demonstrates how to use the **Leaky Integrator** process from the Puara Gestures library to smooth a noisy signal.

### The Goal

We will generate a noisy, random signal and pass it through the Leaky Integrator to see how it smooths the output.

### Setting up the Score

1.  From the Process Library, add the following three objects to your scenario:
    *   `Control/Generators/Expression Value Generator`
    *   `Utilities/Puara/Leaky Integrator`
    *   `Monitoring/Signal display`

2.  Configure the `Expression Value Generator`. Set its expression to something that creates noise, for example, `random()`.

3.  Connect the processes as shown below. The output of the generator feeds the `Input` of the integrator, and the `Output` of the integrator is visualized by the display.

<img src="/assets/images/reference/processes/puara/leaky-integrator-example-image.png" alt="Leaky Integrator Example" width="80%">

### Running and Experimenting

Now, run the scenario. The `Signal Display` will show the smoothed output from the `Leaky Integrator`.

*   **Adjust the `Leak Factor`:**
    *   Set it close to `1.0`. The output signal will become very flat and change very slowly, as it is "leaking" very little of the new information.
    *   Set it close to `0.0`. The output signal will closely follow the noisy input, as it is "leaking" almost all of the old value on each step.

*   **Adjust the `Leak Frequency (Hz)`:**
    *   Lower this value to see the integration happen at a slower rate, resulting in a more stepped, less responsive output.

By combining these two parameters, you can precisely control the character of your smoothed signal.

You can download a complete example score here: [/assets/scores/reference/processes/LeakyIntegratorExample.score](/assets/scores/reference/processes/LeakyIntegratorExample.score)