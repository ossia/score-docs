---
layout: default
title: OSC values controlling a native 3D scene
description: "An example showing how to control a 3D scene with OSC"
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/osc.html
score: /examples/devices/osc.score
---

# OSC values controlling a native 3D scene

This example demonstrates controlling a 3D scene with OSC messages. Rotation and touch gestures move a textured cube and distort its image, providing a starting point for a network-controlled visual instrument.

## Setup

The `sensors2OSC` device receives OSC on UDP port **9000**, bound to `0.0.0.0`. It is configured for Sensors2OSC messages, but another sender can supply the same addresses and argument shapes. Its saved outgoing destination, `127.0.0.1:9996`, is not the destination to configure on a remote sender.

## Send control data

1. Point your OSC sender at the computer's reachable IP address and port 9000. Allow incoming UDP traffic through the firewall.
2. Start playback and send `/rotationvector` with numeric components to rotate the cube. The values are smoothed and multiplied by 360: this is a direct component-to-angle mapping, not quaternion-to-Euler conversion.
3. Send `/touch` as `[index, x, y]`. Fingers 0 and 1 control horizontal and vertical image displacement. Finger 2 is displayed but does not drive an effect.

## Try it

Change rotation slowly, then make a sudden change and compare the smoothed movement. Try varying the One Euro filter settings to balance responsiveness with stability.

Use the two touch controls separately, then together, to compare directional distortions. Their first coordinates are mapped by `0.05(x+1)` and `0.2(x+1)`; change these factors to adjust the gesture's visual range.

The cube's character texture is generated internally. Rotation also affects hue: the color control reads the first component through `sensors2OSC:/rotationvector@[0]`, illustrating how one part of an OSC list can control another aspect of the scene.

This is score's native Model Display and ISF pipeline, not Qt Quick 3D. Geometry and textures are generated internally; Object filter support and graphics rendering are required, but no external model or image files are needed. For a phone-specific walkthrough and extra mapped-value displays, see [Sensors2OSC phone control]({{ site.baseurl }}/examples/devices/sensors2osc.html).

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

