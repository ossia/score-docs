---
layout: default
title: Sensors2OSC phone control
description: "An example showing how to control visuals with an Android phone's sensors"
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/sensors2osc.html
score: /examples/devices/sensors2osc.score
---

# Sensors2OSC phone control

![Character-textured cube preview beneath Model Display, with touch filtering and mapping nodes]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-sensors2osc.png)

This example demonstrates using an Android phone as a controller for live visuals. Rotating the phone moves a textured cube, while multitouch gestures distort the image.

It is a variant of the [OSC scene example]({{ site.baseurl }}/examples/devices/osc.html), with extra displays to help compare incoming touch values with their mapped results. Rendering uses score's native Model Display and ISF effects, not Qt Quick 3D.

## Connect the phone

1. Install [Sensors2OSC](https://sensors2.org/osc/) on Android and connect the phone to a network that can reach the computer.
2. In the app, set the destination to the computer's LAN address and UDP port **9000**. Do not use `127.0.0.1` on the phone: that refers to the phone itself. score's `sensors2OSC` device listens on `0.0.0.0:9000`; allow this port through the firewall.
3. Enable sensor transmission, including rotation vector and touch. Check `sensors2OSC:/rotationvector` and `/touch` in the Device explorer for incoming values.
4. Start playback and rotate the phone. Smooth filters the rotation components with One Euro smoothing; Arraymap multiplies them by 360 and sends them directly to Cube's Rotation. It does not convert a quaternion into Euler angles.
5. Use the app's multitouch surface. `/touch` messages have the shape `[finger index, x, y]`. Object filters separate fingers 0, 1 and 2. The first two drive Noise Displace via Micromap; the third is shown only in a Value display.

## Try it

Rotate the phone slowly, then make a quick gesture. Change the One Euro smoothing settings and compare how closely the cube follows your movement with how much it suppresses small fluctuations.

Move one finger at a time on the touch surface, then combine two fingers. The first two control horizontal and vertical displacement; the third is only displayed. Compare the raw coordinates with the mapped Value displays when adapting the response to your gestures.

The cube's character texture is generated internally, and rotation also changes its hue. No image or 3D model file is required. The saved remote OSC destination `127.0.0.1:9996` is unused by these input mappings.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

