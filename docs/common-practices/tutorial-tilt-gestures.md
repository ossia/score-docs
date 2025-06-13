---
layout: default
title: 'Creating Tilt Gestures'
parent: Common practices
nav_order: 27
---

# Creating Tilt Gestures

The Puara **Tilt** processor is a powerful tool for interpreting real-world motion as a rotational gesture. It intelligently combines data from multiple sensors to calculate a device's forward-and-backward tilt (its "pitch" angle).

This tutorial will guide you through a complete example. We will use a smartphone as a live sensor to provide data to the Tilt processor and visualize its output. The principles apply to any hardware that provides accelerometer and gyroscope.

### Part 1: Setting Up the Live Sensor Data

To see the Tilt processor in action, we first need a source of motion data. We'll use a smartphone app to stream sensor data over Wi-Fi. This tutorial uses **[Sensors2OSC](https://sensors2.org) (Android)**, but the setup is similar for iPhone apps like **[GyroOSC](https://www.bitshapesoftware.com/instruments/gyrosc/)**.

1.  **Configure the App:** In the Sensors2OSC settings, set the **Host** to your computer's IP address and the **Port** to `9997`.
    <img src="/assets/images/reference/processes/puara/sensors-to-osc-settings.jpeg" alt="Sensors2OSC Settings" width="40%">

2.  **Enable Required Sensors:** On the app's main screen, enable the toggles for **Accelerometer** and  **Gyroscope**. Then, enable the main **Send data** toggle at the top.
    <img src="/assets/images/reference/processes/puara/sensors-to-osc-main.jpeg" alt="Sensors Enabled" width="40%">

3.  **Set up OSC in score:** In the Device Explorer, add a new OSC device. Set its **`score listening port`** to `9997`.
    <img src="/assets/images/reference/processes/puara/score-to-osc-adddevice.png" alt="Add OSC Device" width="70%">

4.  **Learn OSC Addresses:** Right-click the new OSC device and select `Learn`. Move your phone around until you see `/accelerometer` and `/gyroscope` appear, then click OK.
    <img src="/assets/images/reference/processes/puara/sensor-to-osc-learn-ag.png" alt="OSC Learning" width="50%">

### Part 2: Building the Tilt Gesture Patch

Now that score is receiving sensor data, we can use our processor.

1.  **Add Processes:** From the Process Library, add a `Gestures/Tilt` processor and a `Monitoring/Signal display`.

2.  **Connect Inputs:** Drag the learned OSC addresses from the Device Explorer directly onto the corresponding inputs of the Tilt processor in the Inspector.
    *   `/accelerometer` -> `Acceleration` input
    *   `/gyroscope` -> `Gyroscope` input

3.  **Visualize the Output:** Connect the `Output` of the Tilt processor to the `Signal display`.

4.  **Run and Test!** Run the scenario. As you tilt your phone forward and backward, you will see the signal display draw a curve representing the tilt angle in radians.

<img src="/assets/images/reference/processes/puara/tilt-processor-example.png" alt="Tilt Processor Example" width="100%">

You can download a complete example score here: [Download the score example here](/assets/scores/reference/processes/TiltExample.score)