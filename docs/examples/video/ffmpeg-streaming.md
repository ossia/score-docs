---
layout: default
title: "FFmpeg input and output streams"
description: "An example showing how to process and exchange live video with another application."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/ffmpeg-streaming.html
score: /examples/video/ffmpeg-streaming.score
---

# FFmpeg input and output streams

![An LFO driving Hyperspace above the separate Color Controls streaming branch]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-ffmpeg-streaming.png)

This example demonstrates receiving, processing and sending live video over a local network connection.

## Overview

A local UDP source provides the video. Two treatments let you compare a scrolling Hyperspace effect in score's output window with colour adjustments sent to a separate receiver. This is a starting point for exchanging video with another application, without first recording it to a file.

The input uses UDP port 5000 and the processed output uses port 5001. The two treatments are independent: changes to the local Hyperspace view do not affect the outgoing Color Controls stream.

## Run the stream

Use a score build with the FFmpeg device and an external FFmpeg installation with libx264 and AAC encoding. Start this local test source:

```sh
ffmpeg -re -f lavfi -i testsrc=size=1280x720:rate=30 -re -f lavfi -i sine=frequency=1000:sample_rate=44100 -c:v libx264 -preset ultrafast -pix_fmt yuv420p -c:a aac -b:a 96k -f mpegts udp://127.0.0.1:5000
```

Open the score and start playback. Run a receiver for its processed output:

```sh
ffplay udp://127.0.0.1:5001
```

Change Color Controls brightness or saturation and compare the receiver with the Hyperspace window. The saved output is video-only, using MJPEG encoding and the MJPEG muxer at 1280×720, 30 fps. It is not MPEG-TS, unlike the test input above, and the test tone is not forwarded. Keep ports 5000 and 5001 available, and stop the external sender and receiver when finished. No media file is required.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
