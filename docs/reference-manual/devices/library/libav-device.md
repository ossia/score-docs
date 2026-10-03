---
layout: default

title: Libav device
description: "Receive media streams or encode audio and video through FFmpeg"

parent: Devices
grand_parent: Reference

permalink: /devices/libav-device.html
---

# Libav device

The Libav device opens media through FFmpeg or encodes score's output to a file or URL. The **Direction** setting selects **Input** or **Output**. Current development builds expose both directions; available demuxers, protocols, encoders and muxers depend on the linked FFmpeg build.

## Input

Set **Path / URL** to a file, network stream such as RTSP, or an image-sequence pattern such as `/path/to/frames_%05d.png`. **Options** accepts `key=value` entries, one per line, passed to the input. For an image sequence, options such as `framerate=30` and `start_number=0` describe how the files form a stream.

Select the resulting device as a texture inlet's source. Unlike a timeline Video process, this is a streaming input; placing the consuming process on an interval does not make a live source seekable.

If the input contains audio, its `/Audio` endpoint can feed an audio inlet independently of the texture. A `/path` parameter also exposes the source path for control.

## Output

Choose **Path / URL**, **Width**, **Height**, **Rate**, and **Audio Channels**. Then select the **Muxer**, **Video Encoder**, **Audio Encoder**, **Pixel Format** and **Sample Format** appropriate for the destination. The encoder and format lists are derived from FFmpeg capabilities; an encoder being listed does not prove its hardware or runtime dependencies are available.

Assign the device's video endpoint to the final texture outlet. When audio channels and an audio encoder are configured, route audio to `/Audio` as well. Video pixels and audio samples are converted for the selected encoders before muxing; GPU pixel conversion is not the same as hardware codec encoding.

Use **Options** and **Show options...** for additional encoder/muxer configuration. **Input Transfer** describes the incoming graph texture: **sRGB (default)**, **Linear**, **HDR10 (PQ)**, **HLG** or **Passthrough**. Match this to the preceding processes rather than using it as a substitute for correct source metadata.

The dialog checks named muxers and encoders, but destination permissions, network connectivity and format compatibility can still fail at runtime. Test the intended output and inspect the resulting media before a performance.

See [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html), [GStreamer]({{ site.baseurl }}/devices/gstreamer-device.html) for explicit pipelines, and [Livestreaming]({{ site.baseurl }}/common-practices/10-livestreaming.html).