---
layout: default

title: Sh4lt devices
description: "Sending and receiving textures via Sh4lt"

parent: Devices
grand_parent: Reference

permalink: /devices/sh4lt-device.html
---

# Sh4lt

[Sh4lt](https://gitlab.com/sh4lt/sh4lt/) , is a Unix-oriented protocol for sharing data frames between applications easily. It is developped by the [Lab148 coop](https://lab148.ca), and is the successor of the [[Shmdata]] protocol originally developed at the [SAT Metalab](https://sat.qc.ca/fr/recherche/metalab).
Its integration in Ossia supports video frames sharing.

It can exchange video with GStreamer and other Sh4lt-enabled software. See the [Sh4lt projects](https://gitlab.com/sh4lt/) for available integrations.

## Compiling and installing Sh4lt

Sh4lt support depends on the score build and is intended for Unix systems, notably Linux. Check that **Sh4lt Input** / **Sh4lt Output** appear in the device chooser. External GStreamer examples also require the [Sh4lt GStreamer elements](https://gitlab.com/sh4lt/gst-sh4lt); support in score does not install those elements for other applications.

Test that it works correctly with the `gst-launch` commands given in that Readme.

## Using Sh4lt in score

Create a **Sh4lt Input**, select the producer, and assign it to a texture inlet. For **Sh4lt Output**, set **Sh4lt label**, **Width**, **Height** and **Rate**, then assign it as the destination of the final texture outlet. The producer/consumer labels must agree.

The output publishes raw RGBA frames via shared memory after GPU readback. This is not a compressed stream or a zero-copy GPU transport. Input caps can describe different supported pixel formats; do not infer output format support from the input converter.

See [GStreamer]({{ site.baseurl }}/devices/gstreamer-device.html), [PipeWire video]({{ site.baseurl }}/devices/pipewire-device.html) and [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html) for other routes and their limitations.

These examples assume that the Sh4lt GStreamer plug-in is installed in `/opt/sh4lt`:

Sending data from GStreamer to score: 

```bash
$ gst-launch-1.0 --gst-plugin-path=/opt/sh4lt videotestsrc pattern=snow ! queue ! videoconvert ! sh4ltsink label=to_score
```

Sending data from score to GStreamer:

```bash
$ gst-launch-1.0 --gst-plugin-path=/opt/sh4lt sh4ltsrc label=score_output ! videoconvert ! autovideosink
```

Here is a score that would process the input and write it to the output.

- Input device (receives the GStreamer feed):
![Sh4lt input window]({{ site.img }}/reference/devices/sh4lt/input.png "sh4lt input")

- Output device (sends the feed to GStreamer):
![Sh4lt output window]({{ site.img }}/reference/devices/sh4lt/output.png "sh4lt output")

- The score and the GStreamer output which shows the processing done by score:
![Score and sh4lt output]({{ site.img }}/reference/devices/shmdata/shmdata.png "score")

## Recording score's video output

Here is a GStreamer command-line which will encode the sh4lt output as .mkv with relatively low quality: 

```bash
$ gst-launch-1.0 -e \
      sh4ltsrc label=score_output \
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
      sh4ltsrc label=score_output \
    ! queue \
    ! videoconvert \
    ! videorate \
    ! video/x-raw,framerate=60/1 \
    ! avenc_prores_ks \
    ! qtmux \
    ! filesink location=foo.mov 
```
