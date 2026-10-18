---
layout: default
title: Sensors2OSC phone control
description: "Use phone rotation and multitouch as a handheld visual instrument, with smoothing to balance responsiveness and stability."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/sensors2osc.html
score: /examples/devices/sensors2osc.score
---

# Sensors2OSC phone control

![Character-textured cube preview beneath Model Display, with touch filtering and mapping nodes]({{ site.baseurl }}/assets/scores/thumbnails/examples-devices-sensors2osc.png)

Turn an Android phone into a handheld visual instrument: rotating it moves a character-textured cube and changes its hue, while touching the screen distorts the image.

This variant of the [OSC scene example]({{ site.baseurl }}/examples/devices/osc.html) adds displays of raw touch input next to the mapped values.

## Connect the phone

1. Install [Sensors2OSC](https://sensors2.org/osc/) on Android and connect the phone to a network that can reach the computer.
2. In the app, set the destination to the computer's LAN address and UDP port **9000**. Do not use `127.0.0.1` on the phone: that refers to the phone itself. score's `sensors2OSC` device listens on `0.0.0.0:9000`; allow this port through the firewall.
3. Enable sensor transmission, including rotation vector and touch. Check `sensors2OSC:/rotationvector` and `/touch` in the Device explorer for incoming values.
4. Start playback and rotate the phone. One Euro smoothing reduces fluctuations, then the components are multiplied by 360 and used directly as the cube's rotation angles. This is not a quaternion-to-Euler conversion: do not expect an exact digital copy of the phone's orientation.
5. Use the app's multitouch surface. Each `/touch` message contains `[finger index, x, y]`. Fingers 0 and 1 control the two displacement directions; finger 2 is displayed but does not drive an effect.

## Tune smoothing and ranges

Rotate slowly, pause, then make a quick movement. Adjust the One Euro smoothing settings until the cube stays still during the pause but still follows the quick movement promptly.

Move one finger at a time, then combine two fingers. The raw and mapped Value displays show how strongly each mapping scales a touch: a small movement can produce a large visual change. Change one touch mapping at a time, keeping the other fixed.

The cube and texture are generated internally with native Model Display and ISF effects; no image or 3D model is needed. Object filter support is required to separate touch messages. The saved remote destination `127.0.0.1:9996` is unused by these incoming controls, so it does not need to match the phone.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

