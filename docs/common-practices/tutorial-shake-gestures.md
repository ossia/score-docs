---
layout: default
title: 'Detecting Shake Gestures'
parent: Common practices
nav_order: 28
---

# Detecting Shake Gestures

The Puara **Shake** processor is designed to detect energetic shaking motions from a device. Unlike the `Roll` or `Tilt` processors, it only requires accelerometer data, making it a simple yet powerful tool for gestural interaction.

This tutorial will show you how to set up the `Shake` processor using a smartphone as a sensor and how to tune its parameters to customize the gesture detection.

### Part 1: Setting Up the Live Sensor Data

We'll use a smartphone app to stream accelerometer data from a phone. This tutorial uses **[Sensors2OSC](https://sensors2.org) (Android)**, but the setup is similar for iPhone apps like **[GyroOSC](https://www.bitshapesoftware.com/instruments/gyrosc/)**.

1.  **Configure the App:** In the Sensors2OSC settings, set the **Host** to your computer's IP address and the **Port** to `9997`.
    <img src="/assets/images/reference/processes/puara/sensors-to-osc-settings.jpeg" alt="Sensors2OSC Settings" width="40%">

2.  **Enable the Accelerometer:** On the app's main screen, you only need to enable the **Accelerometer**. Then, enable the main **Send data** toggle at the top.
    <img src="/assets/images/reference/processes/puara/sensors-to-osc-main.jpeg" alt="Sensors Enabled" width="40%">

3.  **Set up OSC in score:** In the Device Explorer, add a new OSC device and set its **`score listening port`** to `9997`.

4.  **Learn the OSC Address:** Right-click the new OSC device and select `Learn`. Shake your phone until you see the `/accelerometer` address appear, then click OK.
    <img src="/assets/images/reference/processes/puara/score-to-osc-learn-accelerometer.png" alt="OSC Learning Accelerometer" width="50%">
    *(Note: You can reuse the general learning image, but this one is more specific to the task)*

### Part 2: Building the Shake Gesture Patch

With the sensor data streaming, we can build our scenario.

1.  **Add Processes:** From the Process Library, add a `Gestures/Shake` processor and a `Monitoring/Signal display`.

2.  **Connect the Input:** Drag the `/accelerometer` address from the Device Explorer directly onto the `Acceleration` input of the Shake processor.

3.  **Visualize the Output:** Connect the `Output` of the Shake processor to the `Signal display`.

4.  **Run and Test!** Run the scenario. Shake your phone and watch the signal display. You'll see the output value rise and fall with your motion.

<img src="/assets/images/reference/processes/puara/shake-processor-example.png" alt="Shake Processor Example" width="100%">

### Part 3: Tuning the Response

The power of the Shake processor lies in its parameters. Try adjusting them while the scenario is running:
*   **Activation Threshold:** Increase this to make the detector less sensitive, requiring a more vigorous shake to trigger a response.
*   **Fast Leak:** Lower this value to make the output rise much more sharply when you shake the device.
*   **Slow Leak:** Lower this value to make the output drop to zero almost instantly when you stop shaking. Increase it to make the value fade out more slowly.

You can download a complete example score here: [/assets/scores/reference/processes/ShakeExample.score](/assets/scores/reference/processes/ShakeExample.score)