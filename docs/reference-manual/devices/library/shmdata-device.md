---
layout: default

title: Shmdata device
description: "Sending and receiving textures via Shmdata"

parent: Devices
grand_parent: Reference

permalink: /devices/shmdata-device.html
---

# Shmdata device

[Shmdata](https://gitlab.com/sat-metalab/shmdata/), developed at the [SAT Metalab](https://sat.qc.ca/fr/recherche/metalab), is a Unix-oriented protocol for sharing memory between applications easily.  
It is mainly used to share video frames.

Thanks to it, score can easily send and receive video data from and to GStreamer for instance.

## Compiling and installing shmdata

Refer to the latest instructions on the shmdata [Readme](https://gitlab.com/sat-metalab/shmdata/).
Score comes built-in with shmdata support on Linux and macOS (Windows does not support the necessary Unix primitives).

Test that it works correctly with the gst commands given in that Readme.

## Using shmdata in score

Shmdata can currently be used as a video input and output device.
Simply create the devices you need, and set your video input / output to the shmdata device's name.

## Examples

These examples assume that the shmdata GStreamer plug-in is installed in `/opt/shmdata`.

Sending data from GStreamer to score: 

```bash
$ gst-launch-1.0 --gst-plugin-path=/opt/shmdata videotestsrc pattern=snow ! queue ! videoconvert ! shmdatasink socket-path=/tmp/score_shmdata_input
```

Sending data from score to GStreamer:

```bash
$ gst-launch-1.0 --gst-plugin-path=/opt/shmdata shmdatasrc socket-path=/tmp/score_shmdata_output ! videoconvert ! xvimagesink
```

Here is a score that would process the input and write it to the output.

- Input device (receives the GStreamer feed):
![Shmdata input window]({{ site.img }}/reference/devices/shmdata/input.png "shmdata input")

- Output device (sends the feed to GStreamer):
![Shmdata output window]({{ site.img }}/reference/devices/shmdata/output.png "shmdata output")

- The score and the GStreamer output which shows the processing done by score:
![Score and shmdata output]({{ site.img }}/reference/devices/shmdata/shmdata.png "score")