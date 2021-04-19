---
layout: default

title: Audio device
description: "Using multiple sound card inputs and outputs in a score"

parent: Devices
grand_parent: Reference

permalink: /devices/audio-device.html
---

# Audio device

This device allows to expose the physical inputs and outputs of the sound card as device tree nodes,
which can then be used at any place in the score to route a part of the score to a specific sound card output for instance.

![Device setup window]({{ site.img }}/reference/devices/audio/audio-0.png)

## Audio parameters

It is possible to set a float value between 0 and 1 on the audio parameters, for instance to automate the global volume of a given output.

Multiple processes sending audio to the same parameter will be summed.

## Device tree

For a sound card with two mono inputs and outputs, creating the device would look like this:

![Device setup window]({{ site.img }}/reference/devices/audio/audio-1.png)

* The address `audio:/out/0` will refer to the first channel on the sound card.
* The addresses `audio:/in/main` and `audio:/out/main` respectively refer to the entirety of the available channels.
* In a score, the root interval is routed to `audio:/out/main`.
* The volume control at the bottom of the user interface is a shortcut to control `audio:/out/main`'s volume.

## Adding busses

It is possible to create busses, for instance to create stereo pairs.
To do so, just add a child to the device :

### Physical busses

![Device setup window]({{ site.img }}/reference/devices/audio/audio-2.png)

The matrix shows which channels from the soundcard will be mapped to which channels of the port, in ascending order.

For instance, the above screenshot creates a bus which will send its first channel to the second output of the soundcard,
and its second channel to the fourth output of the soundcard.

### Virtual busses

These are abstract busses that can be used for communication within score (for instance to send the output of a set of processes to another process, to make e.g. an aux track).

