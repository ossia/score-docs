---
layout: default
title: OSC values controlling a native 3D scene
description: "Map rotation and indexed touch messages onto a textured cube and image effects."
parent: Device Examples
grand_parent: Examples
permalink: /examples/devices/osc.html
score: /examples/devices/osc.score
---

# OSC values controlling a native 3D scene

The `sensors2OSC` device receives OSC on UDP port **9000**, bound to `0.0.0.0`. It is configured for Sensors2OSC messages, but another sender can supply the same addresses and argument shapes. Its saved outgoing destination, `127.0.0.1:9996`, is not the destination to configure on a remote sender.

## Send control data

1. Point your OSC sender at the computer's reachable IP address and port 9000. Allow incoming UDP traffic through the firewall.
2. Start playback and send `/rotationvector` with numeric components. Smooth applies a One Euro filter; Arraymap multiplies each component by 360 before driving Cube's Rotation. Signal display shows the mapped values. This is a direct component-to-angle mapping, not quaternion-to-Euler conversion.
3. Send `/touch` as `[index, x, y]`. Three Object filters select indices 0, 1 and 2 and display their coordinate pairs.
4. For touch 0 and 1, the first coordinate is mapped by `0.05(x+1)` and `0.2(x+1)` into Noise Displace's horizontal and vertical amounts. Touch 2 is displayed but does not drive an effect.

Random Characters supplies Cube's texture. Model Display renders the geometry, followed by Noise Displace and Color Controls, with the result sent to `Window:/`. Hue reads `sensors2OSC:/rotationvector@[0]` directly, illustrating element selection in an address.

This is score's native Model Display and ISF pipeline, not Qt Quick 3D. Geometry and textures are generated internally; Object filter support and graphics rendering are required, but no external model or image files are needed. For a phone-specific walkthrough and extra mapped-value displays, see [Sensors2OSC phone control]({{ site.baseurl }}/examples/devices/sensors2osc.html).

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

