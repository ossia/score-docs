---
layout: default
title: OSC values controlling a native 3D scene
description: "Turn OSC rotation and touch messages into a cube's movement, color and image distortion."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/osc.html
score: /examples/devices/osc.score
---

# OSC values controlling a native 3D scene

Rotate a textured cube and pull its image apart from another device or application over OSC. Rotation steers both orientation and hue, while two indexed touch inputs control distortion in different directions.

## Setup

The `sensors2OSC` device listens for OSC on UDP port **9000** on all local interfaces (`0.0.0.0`). Sensors2OSC can supply the messages, or you can use any OSC sender with the same addresses and argument shapes. Configure the sender with the score computer's reachable IP address, not the patch's saved outgoing destination.

## Send control data

1. Point your OSC sender at the computer's reachable IP address and port 9000. Allow incoming UDP traffic through the firewall.
2. Start playback and send `/rotationvector` with numeric components. They are smoothed and multiplied by 360 before controlling the cube's rotation. This is a direct component-to-angle mapping, not a quaternion-to-Euler conversion, so the cube does not reproduce the sensor's orientation exactly.
3. Send `/touch` as `[index, x, y]`. Indices 0 and 1 drive horizontal and vertical image displacement; index 2 is displayed but does not alter the image.

## Shape the response

Change rotation slowly, then abruptly. Adjust the One Euro filter settings: stronger smoothing steadies the cube when the input is still, but makes it lag behind fast changes.

Vary the two touch inputs separately before combining them. Their first coordinates are mapped by `0.05(x+1)` and `0.2(x+1)`. Change one factor and send the same input range again: the distortion becomes stronger or weaker.

Rotation's first component also controls hue through `sensors2OSC:/rotationvector@[0]`, so the color changes while rotating. Each of these mappings has its own range and filtering.

The cube and its character texture are generated internally through native Model Display and ISF rendering. You need graphics rendering and Object filter support, but no external model or image. For phone setup and displays of raw and mapped touch values, use [Sensors2OSC phone control]({{ site.baseurl }}/examples/devices/sensors2osc.html).

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

