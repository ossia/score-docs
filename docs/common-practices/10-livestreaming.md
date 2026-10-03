---
layout: default

title: Livestreaming
description: "How to stream a performance over the network"

nav_order: 10
parent: Common practices

permalink: /common-practices/10-livestreaming.html
---

# Livestreaming

This page explains how to set-up a livestream in various manners. 

* TOC
{:toc}

## Choosing the output path

In current development builds, a window is only one possible destination for a texture outlet:

- [Spout]({{ site.baseurl }}/devices/spout-device.html) on Windows and [Syphon]({{ site.baseurl }}/devices/syphon-device.html) on macOS share video with compatible local applications. Spout includes Direct3D/Vulkan paths; Syphon includes Metal. Their availability depends on the build and graphics backend.
- [PipeWire video]({{ site.baseurl }}/devices/pipewire-device.html) publishes or receives Linux video nodes, with shared-memory fallback and optional DMA-BUF transport. A receiver must support and connect to that video node; this is not automatically an OBS source or a V4L2 camera.
- [GStreamer]({{ site.baseurl }}/devices/gstreamer-device.html) runs an input/output pipeline inside score. Output pipelines use `appsrc name=video` and optionally `appsrc name=audio`.
- [Libav]({{ site.baseurl }}/devices/libav-device.html) encodes to a file or URL using the available FFmpeg encoders and muxers.
- [Shmdata]({{ site.baseurl }}/devices/shmdata-device.html) and [Sh4lt]({{ site.baseurl }}/devices/sh4lt-device.html) remain useful bridges to external GStreamer pipelines.

Choose the output first, then assign it to the **last texture outlet** in the effect chain. Audio is a separate route: texture-sharing protocols do not automatically carry score's audio mix. For GStreamer audio outputs, the source caps use the audio engine's rate; insert `audioresample` before requesting a different rate.

Check alpha, color space and full/limited range at the receiver, not only in score's preview. For HDR, match the upstream texture representation to the encoder's **Input Transfer** and the destination; see [Video formats and color]({{ site.baseurl }}/processes/video-formats-color.html). The following external-pipeline recipes require their named plug-ins and are not a guarantee for every installation.

# Livestreaming with OBS Studio

[OBS Studio](https://obs.studio) is a leading free software streaming solution, which is supported on Linux, Windows and macOS.

## On Windows

On Windows, we recommend using Spout (available since *score 3.0.4*) to stream a video output to
OBS.

1. This requires the following OBS plug-in: [Off-World-Live/obs-spout2-plugin](https://github.com/Off-World-Live/obs-spout2-plugin/releases).
2. Once OBS is launched, add a "Spout2 Input" source.
3. In *score*, add a Spout2 output, and set it as the output of the video effect chain you are working on. 
4. For streaming audio to OBS, the WASAPI audio output of score should be used, as ASIO drivers may not have loopback capabilities, 
making OBS unable to record the audio output coming from *score*.
5. Add an "Audio output capture" for getting the sound output of score into OBS.

![Livestream to OBS from Win32]({{ site.img }}/common-practices/livestream-win32.gif "OBS studio")

## On macOS

On macOS, we recommend using Syphon (available since *score 3.0.4*) to stream a video output to
OBS.

Use an OBS Syphon input plug-in or a compatible bridge such as [Syphon Virtual Webcam](https://troikatronix.com/add-ons/syphon-virtual-webcam/), according to the versions supported by your macOS and OBS installation. Create a Syphon output in score, route the final texture outlet to it, and select that server in the receiver. Route audio separately.

## On Linux
For a Linux application that accepts PipeWire video, use the native [PipeWire Video Output]({{ site.baseurl }}/devices/pipewire-device.html) and connect the nodes. For applications needing a V4L2 camera, GStreamer plus v4l2loopback remains a useful bridge. The recipe below uses shmdata as its raw-video source; the native [GStreamer device]({{ site.baseurl }}/devices/gstreamer-device.html) is another option when available.

### Streaming video outputs

* Install [v4l2loopback](https://github.com/umlaeute/v4l2loopback), gstreamer, obs-studio. They are available in most distributions' package repositories.
* Reboot or load the module: `sudo modprobe v4l2loopback card_label="Virtual camera"`.  
* Test that a simple pipeline works: 

```bash
$ sudo gst-launch-1.0 videotestsrc ! v4l2sink device=/dev/video0
```

If it fails, consider reloading the module with the additional option `max_buffers=16`.

* Install [[shmdata|Shmdata]] and add it to the GStreamer plug-ins.

> This generally means copying `libgstshmdata.so` in `/usr/lib/gstreamer-1.0/`.

* In *score*, add a Shmdata output device, and set it as the output of the video effect chain you are working on. 
* Create a GStreamer pipeline which will pipe the Shmdata output of score into a V4L2 virtual camera. Assuming `/tmp/score_shm_video`  as the shmdata socket path, this gives:

```bash
$ sudo gst-launch-1.0 shmdatasrc socket-path=/tmp/score_shm_video \
    ! videoconvert \
    ! video/x-raw, format=NV12 \
    ! queue \
    ! v4l2sink device=/dev/video0
```

### Streaming audio outputs

Simply using JACK or PipeWire works ; OBS is able to take such audio input streams through the "JACK input client" source.
Then use your favorite routing GUI to route *score*'s output into OBS.

# Livestreaming from the command line under Linux

## Livestreaming through RTP with GStreamer

RTP is the standard low-level network protocol for streaming audio and video data.

To stream to RTP as efficiently as possible from score, we are going to leverage the [[shmdata|Shmdata]] plug-in, and GStreamer. 
We will stream with the classic MJPEG codec for simplicity in this example ; depending on your system other codecs 
could be more efficient: x264, HEVC, VP8, etc. Refer to the GStreamer documentation to know how to encode in these formats. 

First, create a Shmdata video output (writing on the `/tmp/score_shm_video` path) on score and some video content to stream, then hit play.

Then run GStreamer (the [[shmdata]] plug-in is needed):

```bash
$ gst-launch-1.0 \
    shmdatasrc socket-path=/tmp/score_shm_video \
  ! videoconvert \
  ! video/x-raw, format=I420 \
  ! queue \
  ! jpegenc \
  ! rtpjpegpay \
  ! udpsink host=127.0.0.1 port=5000
```

Create the following file (`mjpeg.sdp` for instance) which represents the stream: 

```s
v=0
m=video 5000 RTP/AVP 26
a=rtpmap:26 JPEG/90000;
a=decode_buf=300;
c=IN IP4 127.0.0.1
```

You can now read the stream, for instance with `ffplay`, `vlc`, `mpv`... 

```bash
$ ffplay mjpeg.sdp
```

Note: the format of SDP is:

```s
v=<version>
o= <owner> IN IP4 <IP4 ADDRESS>
c=IN IP4 <IP4 ADDRESS>
s=<STREAM "HUMAN" DESCRIPTION>
m=<media> <udp port> RTP/AVP <payload>
a=rtpmap:<payload> <encoding-name>/<clock-rate>[/<encoding-params>]
a=fmtp:<payload> <param>=<value>;...
```

## Livestreaming audio and video to Twitch (and other RTMP systems)

Here is an example pipeline, which assumes PipeWire for audio:
```bash
$ export STREAM_URL="rtmp://mrs02.contribute.live-video.net/app/<YOUR_TWITCH_KEY>"
$ export FPS=30
$ export CHANNELS=2
$ export BITRATE=6000

$ gst-launch-1.0 shmdatasrc socket-path=/tmp/score_shm_video \
    ! videoconvert \
    ! video/x-raw, format=NV12 \
    ! queue \
    ! x264enc bitrate=$BITRATE tune=zerolatency key-int-max=30 \
    ! flvmux streamable=true name=flvmux \
    ! rtmpsink location="$STREAM_URL" \
      pipewiresrc client-name=my-stream \
    ! audio/x-raw,format=F32LE,channels=$CHANNELS \
    ! audioconvert \
    ! faac \
    ! flvmux.
```

Use the following link to choose a correct stream url: [https://stream.twitch.tv/ingests](https://stream.twitch.tv/ingests).

If you are using Jack, use `jackaudiosrc` instead of `pipewiresrc`, and do not forget to connect the score audio outputs to the PipeWire / JACK object's inputs
(called my-stream in this example).

# Configuring Jitsi for high-quality streams

If you use [Jitsi](https://meet.jit.si), by default the sound and video quality may be low and optimized for talking rather than music.

You can open your Jitsi room with the following set of parameters after the room name to increase the available video and audio quality, and enable stereo sound (if the browsers used support it):

```
https://meet.jit.si/<JITSI_ROOM_NAME>#config.disableAP=true&config.disableAEC=true&config.disableNS=true&config.disableAGC=true&config.disableHPF=true&config.stereo=true&config.enableLipSync=false&config.p2p.enabled=false&config.prejoinPageEnabled=false&config.resolution=1080
```

Note that for these parameters to be taken into account, the room must not have been created yet (that is, no one must have joined `https://meet.jit.si/<JITSI_ROOM_NAME>` already).