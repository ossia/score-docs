---
layout: default
title: 'Creating Roll Gestures'
parent: Common practices
nav_order: 26
---

# Creating Roll Gestures

The Puara **Roll** processor is a powerful tool for interpreting real-world motion as a rotational gesture. It intelligently combines data from multiple sensors to calculate a device's side-to-side tilt (its "roll" angle).

This tutorial will guide you through a complete example. We will use a smartphone as a live sensor to provide data to the Roll processor and visualize its output, but the same principles apply to any hardware that provides accelerometer, gyroscope, and magnetometer data.

### Part 1: Setting Up the Live Sensor Data

To see the Roll processor in action, we first need a source of motion data. We'll use the [Sensors2OSC](https://sensors2.org) app to stream data from a phone over Wi-Fi.

1.  **Configure the App:** In the Sensors2OSC settings, set the **Host** to your computer's IP address and the **Port** to `9997`.
    <img src="/assets/images/reference/processes/puara/sensors-to-osc-settings.jpeg" alt="Sensors2OSC Settings" width="40%">

2.  **Enable Required Sensors:** On the app's main screen, enable the toggles for **Accelerometer**, **Gyroscope**, and **Magnetic Field**. Then, enable the main **Send data** toggle at the top.
    <img src="/assets/images/reference/processes/puara/sensors-to-osc-main.jpeg" alt="Sensors Enabled" width="40%">

3.  **Set up OSC in score:** In the Device Explorer, add a new OSC device. Set its **`score listening port`** to `9997`.
    <img src="/assets/images/reference/processes/puara/score-to-osc-adddevice.png" alt="Add OSC Device" width="70%">

4.  **Learn OSC Addresses:** Right-click the new OSC device and select `Learn`. Move your phone around until you see `/accelerometer`, `/gyroscope`, and `/magneticfield` appear, then click OK.
    <img src="/assets/images/reference/processes/puara/score-to-osc-learn.png" alt="OSC Learning" width="50%">

### Part 2: Building the Roll Gesture Patch

Now that score is receiving sensor data, we can use our processor.

1.  **Add Processes:** From the Process Library, add a `Gestures/Roll` processor and a `Monitoring/Signal display`.

2.  **Connect Inputs:** Drag the learned OSC addresses from the Device Explorer directly onto the corresponding inputs of the Roll processor in the Inspector.
    *   `/accelerometer` -> `Acceleration` input
    *   `/gyroscope` -> `Gyroscope` input
    *   `/magneticfield` -> `Magnetometer` input

3.  **Visualize the Output:** Connect the `Output` of the Roll processor to the `Signal display`.

4.  **Run and Test!** Run the scenario. As you tilt your phone side-to-side, you will see the signal display draw a curve representing the roll angle in radians. Experiment with the `Enable Smooth` and `Enable Unwrap` toggles to see how they provide a cleaner, more continuous gestural controller.

<img src="/assets/images/reference/processes/puara/roll-processor-example.png" alt="Roll Processor Example" width="100%">

You can download a complete example score here: [/assets/scores/reference/processes/RollExample.score](/assets/scores/reference/processes/RollExample.score)