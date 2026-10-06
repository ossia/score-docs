---
layout: default
title: Recording sensor messages and automations
description: "An example showing how to record sensor data as curves and messages"
parent: Basics
grand_parent: Examples
permalink: /examples/basics/recording.html
score: /examples/basics/recording.score
---

# Recording sensor messages and automations

![Recorded sensor curves at two simplification settings beside discrete message states]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-recording.png)

This example demonstrates recording sensor gestures as automations or discrete messages. It contains saved Sensors2OSC recordings rather than recorded audio, so you can explore the result without connecting a phone.

## Overview

Continuous movement can be replayed as a curve, while individual events such as touches can be stored in states. The examples also compare recording simplification and **Ramp to new value**, which affect how the captured gesture is represented between samples.

## Try it

Start playback and trigger a group's start. The groups wait for interaction; their positions on the page do not start them automatically.

- Compare the accelerometer, gyroscope and orientation recordings at the same zoom level. The groups labelled 3, 10 and 100 show different simplification settings; the saved ratio-100 curves are denser than ratio 3.
- Compare the magnetic-field curves with **Ramp to new value** enabled and disabled.
- Open `Recording example - Messages` to inspect the touch events as individual states rather than curves.

Play only one group writing a given address at a time. Playback sends the saved sensor values to the configured OSC destination, `127.0.0.1:9996`; use an OSC receiver there to observe them. Vector components can be automated separately, as in `Sensors2OSC:/accelerometer@[0]`. This example does not produce sound or a rendered image.

Only making a new live recording requires the phone app and network input.

## Record your own input

1. Install Sensors2OSC on an Android phone and put it on a network reachable from the computer.
2. Set the phone's destination to the computer's address, UDP port **9997**. The score device listens on `0.0.0.0:9997`; allow that traffic through the firewall.
3. Select the incoming addresses in the Device explorer. Right-click in a Scenario and choose **Record automations** for continuous sensors or **Record messages** for discrete events.
4. Send sensor data: recording starts on the first received message. Stop recording and inspect the resulting curves or states.

The saved recordings can be inspected without a phone. Only making a new live recording requires the app and network input.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

