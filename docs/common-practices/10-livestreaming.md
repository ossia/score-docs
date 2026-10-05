---
layout: default

title: Livestreaming
description: "How to stream a performance over the network"

nav_order: 10
parent: Common practices

permalink: /common-practices/10-livestreaming.html
---

# Livestreaming

score can stream audio and video directly through its GStreamer and FFmpeg devices. A separate encoder application is not required. OBS remains useful when you want to combine score with other sources.

* TOC
{:toc}

## Streaming with FFmpeg

FFmpeg is built into score. Its device is documented under [Libav]({{ site.baseurl }}/devices/libav-device.html).

To send an H.264/AAC stream to an RTMP service:

1. Add an FFmpeg device in the [[Device explorer]] and set Direction to Output.
2. Enter the service's ingest URL, including the stream key, in Path / URL. For a local RTMP server this might be `rtmp://localhost/live/stream`.
3. Set the following output fields:

   | Field | Value |
   |---|---|
   | Width | `1280` |
   | Height | `720` |
   | Rate | `30` |
   | Audio Channels | `2` |
   | Muxer | `flv` |
   | Video Encoder | `libx264` |
   | Audio Encoder | `aac` |
   | Pixel Format | `yuv420p` |
   | Sample Format | `fltp` |

4. Enter these Options, one per line:

   ```text
   preset=veryfast
   tune=zerolatency
   g=60
   ```

   These are the settings used by score's RTMP output recipe. `g=60` sets a 60-frame keyframe interval: two seconds at 30 fps. Use Show options... to inspect the encoder and muxer options and adapt them to your streaming service.
5. Create the device. Assign `FFmpeg:/Video` to the last texture outlet in your video effect chain. Assign `FFmpeg:/Audio` to the audio outlet carrying the mix to stream. Replace `FFmpeg` with your device name if you changed it.
6. Start playback and check the stream at the receiving service.

The audio route is separate from the video route: selecting the video destination does not capture score's main audio output. Set Audio Channels to `0` for video-only output. The Audio address is created when both an audio encoder and a positive channel count are selected.

Width and Height set the encoded image size; Rate is frames per second. Input Transfer describes the incoming texture: keep sRGB for ordinary SDR content, or choose the appropriate transfer for your source. See [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html).

## Streaming with GStreamer

score loads GStreamer dynamically. Install [GStreamer](https://gstreamer.freedesktop.org/download/) on your machine, including the plug-ins used by your pipeline. Unlike FFmpeg, the GStreamer runtime is not built into score.

Add a [GStreamer device]({{ site.baseurl }}/devices/gstreamer-device.html) in the Device explorer. Enter a pipeline in its Pipeline field, without the `gst-launch-1.0` command. Output pipelines receive score's video through `appsrc name=video` and audio through `appsrc name=audio`.

### RTP video

For an MJPEG stream over RTP, enter:

```text
appsrc name=video ! videoconvert ! video/x-raw,format=I420 ! jpegenc ! rtpjpegpay ! udpsink host=127.0.0.1 port=5000 sync=false
```

Set Width to `1280`, Height to `720`, Rate to `30` and Audio Channels to `0`. Change `host` to the receiver's IP address when streaming to another machine.

Create the device and assign `GStreamer:/Video` to the final texture outlet. Start playback to feed the pipeline.

You can receive the stream in another score instance with a GStreamer device using:

```text
udpsrc port=5000 caps="application/x-rtp,media=video,encoding-name=JPEG,payload=26,clock-rate=90000" ! rtpjpegdepay ! jpegdec ! videoconvert ! video/x-raw,format=RGBA ! appsink name=video sync=false
```

On this input device, `GStreamer:/video` is a texture source. Assign it to a texture inlet and route the process's output to a window. The lowercase `video` comes from the appsink name; output devices expose the uppercase `Video` address.

### Audio and video in one pipeline

To send H.264 video and AAC audio to an RTMP service, use:

```text
appsrc name=video ! queue ! videoconvert ! video/x-raw,format=I420 ! x264enc bitrate=6000 tune=zerolatency key-int-max=60 ! h264parse ! queue ! mux.
appsrc name=audio ! queue ! audioconvert ! audioresample ! audio/x-raw,rate=48000,channels=2 ! avenc_aac ! aacparse ! queue ! mux.
flvmux name=mux streamable=true ! rtmpsink location="rtmp://SERVER/app/STREAM_KEY"
```

Replace the URL with the service's ingest address. Install the `x264enc`, `avenc_aac` (from gst-libav), parser, FLV muxer and RTMP sink plug-ins. `voaacenc` is another AAC encoder you can use in place of `avenc_aac` if your GStreamer installation provides it.

Set Rate to `30` and Audio Channels to `2`. Route the final texture outlet to `GStreamer:/Video` and your audio mix to `GStreamer:/Audio`, then start playback. `bitrate=6000` is the x264 encoder's video bitrate in kbit/s; `key-int-max=60` limits the keyframe interval to two seconds at this rate.

score supplies floating-point audio at the audio engine's sample rate. The `audioresample` element converts it before the pipeline requests 48 kHz. Setting Audio Channels alone does not connect an audio source: the Audio address must also receive the mix.

## Livestreaming with OBS Studio

[OBS Studio](https://obsproject.com/) can combine score's output with cameras, desktop capture and other sources.

### Windows

1. Install the [OBS Spout2 plug-in](https://github.com/Off-World-Live/obs-spout2-plugin/releases).
2. In score, add a [Spout output]({{ site.baseurl }}/devices/spout-device.html) and assign it to the final texture outlet.
3. In OBS, add a Spout2 Input source and select score's output.
4. For audio, use score's WASAPI output and an Audio Output Capture source in OBS. ASIO output may not be available through loopback capture.

![Livestream to OBS from Win32]({{ site.img }}/common-practices/livestream-win32.gif "OBS studio")

### macOS

Add a [Syphon output]({{ site.baseurl }}/devices/syphon-device.html) in score and route the final texture outlet to it. Select that server through an OBS Syphon input plug-in or a compatible bridge such as [Syphon Virtual Webcam](https://troikatronix.com/add-ons/syphon-virtual-webcam/). Route audio separately.

### Linux

For receivers that accept PipeWire video nodes, use score's [PipeWire Video Output]({{ site.baseurl }}/devices/pipewire-device.html) and connect the nodes.

For an OBS Video Capture Device source, create a virtual camera with [v4l2loopback](https://github.com/umlaeute/v4l2loopback):

```bash
sudo modprobe v4l2loopback video_nr=10 card_label="score" exclusive_caps=1
```

Then create a GStreamer device in score with this Pipeline:

```text
appsrc name=video ! videoconvert ! video/x-raw,format=YUY2 ! v4l2sink device=/dev/video10
```

Set Audio Channels to `0`, assign `GStreamer:/Video` to your texture outlet and start playback. Select `/dev/video10` in OBS. This sends score's video to the virtual camera without a separate GStreamer process.

For audio, use JACK or PipeWire routing to connect score to OBS's JACK Input Client source.

# Configuring Jitsi for high-quality streams

If you use [Jitsi](https://meet.jit.si), by default the sound and video quality may be low and optimized for talking rather than music.

You can open your Jitsi room with the following set of parameters after the room name to increase the available video and audio quality, and enable stereo sound (if the browsers used support it):

```
https://meet.jit.si/<JITSI_ROOM_NAME>#config.disableAP=true&config.disableAEC=true&config.disableNS=true&config.disableAGC=true&config.disableHPF=true&config.stereo=true&config.enableLipSync=false&config.p2p.enabled=false&config.prejoinPageEnabled=false&config.resolution=1080
```

Note that for these parameters to be taken into account, the room must not have been created yet (that is, no one must have joined `https://meet.jit.si/<JITSI_ROOM_NAME>` already).