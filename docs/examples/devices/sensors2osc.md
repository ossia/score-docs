---
layout: default
title: Sensors2OSC phone control
description: "Use phone rotation and multitouch as a handheld visual instrument, balancing responsive gestures with stable motion."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/sensors2osc.html
score: /examples/devices/sensors2osc.score
---

# Sensors2OSC phone control

![Character-textured cube preview beneath Model Display, with touch filtering and mapping nodes]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-sensors2osc.png)

Turn an Android phone into a handheld visual instrument: rotating it moves a character-textured cube and changes its hue, while touch gestures distort the image. Rotation gives the performer a broad physical action; touch provides a second layer of control without needing another device.

This variant of the [OSC scene example]({{ site.baseurl }}/examples/devices/osc.html) adds displays for comparing raw touch input with mapped values. Use those displays to understand the response before adjusting it to your own gestures.

## Connect the phone

1. Install [Sensors2OSC](https://sensors2.org/osc/) on Android and connect the phone to a network that can reach the computer.
2. In the app, set the destination to the computer's LAN address and UDP port **9000**. Do not use `127.0.0.1` on the phone: that refers to the phone itself. score's `sensors2OSC` device listens on `0.0.0.0:9000`; allow this port through the firewall.
3. Enable sensor transmission, including rotation vector and touch. Check `sensors2OSC:/rotationvector` and `/touch` in the Device explorer for incoming values.
4. Start playback and rotate the phone. One Euro smoothing reduces fluctuations, then the components are multiplied by 360 and used directly as the cube's rotation angles. This is not a quaternion-to-Euler conversion: do not expect an exact digital copy of the phone's orientation.
5. Use the app's multitouch surface. Each `/touch` message contains `[finger index, x, y]`. Fingers 0 and 1 control the two displacement directions; finger 2 is displayed but does not drive an effect.

## Find a comfortable gesture range

Rotate slowly, pause, then make a quick movement. Adjust the One Euro smoothing settings and compare how still the cube appears during the pause with how promptly it follows the quick gesture. The goal is a deliberate balance between suppressing sensor fluctuations and preserving the performer's timing.

Move one finger at a time, then combine two fingers. Compare the raw and mapped Value displays: a small touch movement can produce a large visual change if the mapping scales it strongly. Try changing one touch mapping while keeping the other fixed, so you can judge the new range without changing the whole instrument at once.

The cube and texture are generated internally with native Model Display and ISF effects; no image or 3D model is needed. Object filter support is required to separate touch messages. The saved remote destination `127.0.0.1:9996` is unused by these incoming controls, so it does not need to match the phone.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

