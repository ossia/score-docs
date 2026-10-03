---
layout: default
title: GStreamer device
description: "Receive or publish audio and video through a GStreamer pipeline"
parent: Devices
grand_parent: Reference
permalink: /devices/gstreamer-device.html
---

# GStreamer device

The GStreamer device runs a pipeline inside score. It can receive video and audio through named `appsink` elements, or publish score's output through `appsrc`. This integration requires a current development build with GStreamer support and the runtime libraries and plug-ins used by your pipeline. It is separate from launching `gst-launch-1.0` outside score.

## Input pipeline

Add a **GStreamer** device and enter the pipeline description in **Pipeline**, without a `gst-launch-1.0` prefix. Give every receiving `appsink` a distinct name, using letters, digits and underscores. Named sinks become endpoints in the device tree; select the video endpoint in a texture inlet's inspector, or route the audio endpoint to an audio input.

A simple video-source description is:

```text
videotestsrc is-live=true ! videoconvert ! video/x-raw,format=RGBA,width=1280,height=720,framerate=30/1 ! appsink name=video
```

The input can discover multiple named audio/video sinks. Explicit raw caps near each sink are particularly useful for live sources, which may not have negotiated caps when the device is first created. Do not feed encoded H.264 or JPEG packets directly into a raw-video sink: add the corresponding decoder upstream.

For audio, score inserts conversion/resampling for recognized audio sinks so they deliver floating-point samples at the **audio engine's sample rate**. The pipeline still needs the GStreamer audio conversion/resampling plug-ins. An input example is:

```text
audiotestsrc is-live=true ! audioconvert ! audio/x-raw,format=F32LE,channels=2 ! appsink name=audio
```

Writable properties of named pipeline elements can also appear as device parameters. This depends on the element's GObject properties; it is not a universal remote control interface for every plug-in.

## Output pipeline

A pipeline containing `appsrc` is treated as an output pipeline. Use **`appsrc name=video`** for video and/or **`appsrc name=audio`** for audio. These names are required by the output implementation; arbitrary appsrc names are not discovered like input sinks.

For example, this description sends video to a GStreamer display sink:

```text
appsrc name=video ! videoconvert ! autovideosink
```

Set **Width**, **Height**, **Rate** and **Audio Channels**, then assign the device's video endpoint as the destination of the final texture outlet. Route audio separately to its audio endpoint if the pipeline contains `appsrc name=audio`.

Video starts with RGBA caps. Supported downstream raw-format requests can select GPU conversion before readback; others need a GStreamer converter. This output is not a blanket zero-copy GPU-sharing interface. Set explicit downstream caps when an encoder requires a particular format.

Audio is supplied as interleaved floating-point samples at the engine rate. To encode at another rate, include `audioconvert ! audioresample` followed by the desired `audio/x-raw,rate=...` caps. Merely labeling samples with another rate changes their interpretation rather than resampling them.

**Input Transfer** describes the texture received from score: **sRGB (default)**, **Linear**, **HDR10 (PQ)**, **HLG** or **Passthrough**. Match this to upstream processing; see [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html).

## Validation and limitations

The dialog reports whether the pipeline can be parsed and whether GStreamer is available. **Pipeline valid** does not prove that a camera, network peer, encoder, output file or caps negotiation will work at runtime. Required plug-ins must be installed, and media/device permissions still apply.

Input pixel-format conversion and output encoders have distinct capabilities. For example, a GPU converter elsewhere in score does not make every GStreamer raw format valid as an input. Prefer explicit common raw caps while diagnosing a pipeline. A slow output consumer can cause dropped video frames rather than an indefinitely growing output queue.

See also [Libav]({{ site.baseurl }}/devices/libav-device.html), [PipeWire video]({{ site.baseurl }}/devices/pipewire-device.html), [Shmdata]({{ site.baseurl }}/devices/shmdata-device.html), [Sh4lt]({{ site.baseurl }}/devices/sh4lt-device.html), and [Livestreaming]({{ site.baseurl }}/common-practices/10-livestreaming.html). The descriptions above are configuration examples, not tested pipelines for every installation.
