---
layout: default

title: "Livestreaming"
description: "How to stream a performance over the network"

nav_order: 10
parent: Common practices

permalink: /common-practices/10-livestreaming.html
---

# Livestreaming

This page explains how to set-up a livestream in various manners. [OBS](https://obs.studio) to stream an audio-visual performance made with *score*.


## Livestreaming with shmdata and PipeWire under Linux

### Livestreaming through RTP with GStreamer

RTP is the standard network protocol for streaming media data.

To stream to RTP as efficiently as possible from score, we are going to leverage the [[shmdata]] plug-in, and GStreamer.

First, create a Shmdata video output (writing on the `/tmp/score_shm_video` path) on score and some video content to stream, then hit play.

#### Low-latency RTP video with MJPEG 

Run GStreamer (the [[shmdata]] plug-in is needed):

```
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

```
v=0
m=video 5000 RTP/AVP 26
a=rtpmap:26 JPEG/90000;
a=decode_buf=300;
c=IN IP4 127.0.0.1
```

You can now read the stream, for instance with `ffplay`, `vlc`, `mpv`... 

```
$ ffplay mjpeg.sdp
```

Note: the format of SDP is:

```
v=<version>
o= <owner> IN IP4 <IP4 ADDRESS>
c=IN IP4 <IP4 ADDRESS>
s=<STREAM "HUMAN" DESCRIPTION>
m=<media> <udp port> RTP/AVP <payload>
a=rtpmap:<payload> <encoding-name>/<clock-rate>[/<encoding-params>]
a=fmtp:<payload> <param>=<value>;...
```

#### Streaming H.264 and audio to Twitch (and other RTMP systems)

Here is an example pipeline:
```
$ export STREAM_URL="rtmp://mrs02.contribute.live-video.net/app/<YOUR_TWITCH_KEY>"
$ export FPS=30
$ export CHANNELS=2
$ export BITRATE=3000

$ gst-launch-1.0 shmdatasrc socket-path=/tmp/score_shm_video \
    ! queue \
    ! video/x-raw,framerate=$FPS/1 \
    ! videoconvert \
    ! video/x-raw, format=NV12 \
    ! x264enc bitrate=$BITRATE tune=zerolatency key-int-max=30 \
    ! queue \
    ! flvmux streamable=true name=flvmux \
    ! rtmpsink location="$STREAM_URL" \
      pipewiresrc client-name=my-stream \
    ! audio/x-raw,format=F32LE,channels=$CHANNELS \
    ! audioconvert \
    ! faac \
    ! flvmux.
```

Use the following link to choose a correct stream url: [https://stream.twitch.tv/ingests](https://stream.twitch.tv/ingests).