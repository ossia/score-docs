---
layout: default
title: Recording sensor messages and automations
description: "Capture a body's movement as editable curves, or preserve discrete touches as cues that can be replayed."
parent: Basics
grand_parent: Examples
permalink: /examples/basics/recording.html
score: /examples/basics/recording.score
---

# Recording sensor messages and automations

![Recorded sensor curves at two simplification settings beside discrete message states]({{ site.baseurl }}/assets/scores/thumbnails/examples-basics-recording.png)

Turn a performed movement into material you can edit and replay. The saved phone-sensor recordings let you study the shape of a gesture without holding the phone again; discrete touch events show how to retain actions as cues instead of smoothing them into a curve.

## Overview

Continuous sensor movement becomes automation, while individual events can be stored in states. Recording simplification changes how much detail remains in a curve. **Ramp to new value** changes what happens between captured samples. Those choices matter if you later use the recording to animate a light, a camera or a sound parameter: preserving every fluctuation is not always the same as preserving the gesture.

## Try it

Start playback and trigger a group's start. The groups wait for interaction; their positions on the page do not start them automatically.

- Compare the accelerometer, gyroscope and orientation recordings at the same zoom level. In the groups labelled 3, 10 and 100, inspect which small changes remain; the saved ratio-100 curves are denser than ratio 3.
- Compare the magnetic-field curves with **Ramp to new value** enabled and disabled. Look between samples to distinguish a continuous transition from a held value followed by a step.
- Open `Recording example - Messages` and inspect the touch events as individual states. Their event timing matters more than an interpolated path between values.

Play only one group writing a given address at a time, so two recordings do not compete. Playback sends the saved sensor values to `127.0.0.1:9996`; use an OSC receiver there to observe them. Vector components can be automated separately. This is control-data playback, not an audio recording or a rendered image.

The saved recordings need no phone. For a new gesture, follow the live setup below.

## Record your own input

1. Install Sensors2OSC on an Android phone and put it on a network reachable from the computer.
2. Set the phone's destination to the computer's address, UDP port **9997**. The score device listens on `0.0.0.0:9997`; allow that traffic through the firewall.
3. Select the incoming addresses in the Device explorer. Right-click in a Scenario and choose **Record automations** for continuous sensors or **Record messages** for discrete events.
4. Send sensor data: recording starts on the first received message. Stop recording and inspect the resulting curves or states.

After recording, replay the gesture with the phone idle. Edit one section of the curve or move one message state, then compare the playback: the captured action is now compositional material rather than a live dependency.

[Download this example]({{ site.scores }}{{ page.score }})

{% include try-on-web.html %}

