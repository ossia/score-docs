---
layout: default

title: Sh4lt devices
description: "Sending and receiving textures via Sh4lt"

parent: Devices
grand_parent: Reference

permalink: /devices/sh4lt-devices.html
---

# Sh4lt

[Sh4lt](https://gitlab.com/sh4lt/sh4lt/), the successor of the [[Shmdata]] protocol originally developed at the [SAT Metalab](https://sat.qc.ca/fr/recherche/metalab), is a Unix-oriented protocol for sharing memory between applications easily.  
It is mainly used to share video frames.

Thanks to it, score can easily send and receive video data from and to GStreamer for instance.

## Compiling and installing Sh4lt

Refer to the latest instructions on the Sh4lt [Readme](https://gitlab.com/sh4lt/sh4lt/).
Score comes built-in with Sh4lt support on Linux and macOS (Windows does not support the necessary Unix primitives).

Test that it works correctly with the `gst-launch` commands given in that Readme.

## Using Sh4lt in score

Sh4lt can currently be used as a video input and output device.
Simply create the devices you need, and set your video input / output to the Sh4lt device's name.

These examples assume that the Sh4lt GStreamer plug-in is installed in `/opt/sh4lt`:

Sending data from GStreamer to score: 

```bash
$ gst-launch-1.0 --gst-plugin-path=/opt/sh4lt videotestsrc pattern=snow ! queue ! videoconvert ! sh4ltsink socket-path=/tmp/score_sh4lt_input
```

Sending data from score to GStreamer:

```bash
$ gst-launch-1.0 --gst-plugin-path=/opt/sh4lt sh4ltsrc socket-path=/tmp/score_sh4lt_output ! videoconvert ! xvimagesink
```

Here is a score that would process the input and write it to the output.

- Input device (receives the GStreamer feed):
![Sh4lt input window]({{ site.img }}/reference/devices/sh4lt/input.png "sh4lt input")

- Output device (sends the feed to GStreamer):
![Sh4lt output window]({{ site.img }}/reference/devices/sh4lt/output.png "sh4lt output")

- The score and the GStreamer output which shows the processing done by score:
![Score and sh4lt output]({{ site.img }}/reference/devices/sh4lt/sh4lt.png "score")

## Recording score's video output

Here is a GStreamer command-line which will encode the sh4lt output as .mkv with relatively low quality: 

```bash
$ gst-launch-1.0 -e \
      sh4ltsrc socket-path=/tmp/score_shm_video \
    ! queue \
    ! videoconvert \
    ! videorate \
    ! video/x-raw,framerate=60/1 \
    ! x264enc \
    ! matroskamux \
    ! filesink location=foo.mkv
```

Or as .mov encoded in Apple ProRes (warning: very, very CPU hungry):

```bash
$ gst-launch-1.0 -e \
      sh4ltsrc socket-path=/tmp/score_shm_video \
    ! queue \
    ! videoconvert \
    ! videorate \
    ! video/x-raw,framerate=60/1 \
    ! avenc_prores_ks \
    ! qtmux \
    ! filesink location=foo.mov 
```