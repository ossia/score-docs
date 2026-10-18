---
layout: default
title: "FFmpeg input and output streams"
description: "Process live video for another application while keeping a separate local visual treatment."
parent: Video Examples
grand_parent: Examples
permalink: /examples/video/ffmpeg-streaming.html
score: /examples/video/ffmpeg-streaming.score
---

# FFmpeg input and output streams

![Separate local distortion and outgoing color-adjustment paths for a live stream]({{ site.baseurl }}/assets/scores/thumbnails/examples-video-ffmpeg-streaming.png)

Receive a live video stream, transform it in score and send a treated image to another application without recording an intermediate file. A separate local view shows a different treatment from the one your receiver sees.

## Local and outgoing paths

The incoming UDP video splits into two paths. Hyperspace creates the scrolling treatment in score's output window; Color Controls changes the image sent to the external receiver. Adjusting the local Hyperspace effect does not change the outgoing picture.

The test runs entirely on your machine: input arrives on UDP port 5000 and output leaves on port 5001.

## Run the stream

Use a score build with the FFmpeg device and an external FFmpeg installation with libx264 and AAC encoding. Keep ports 5000 and 5001 available. Start this local test source:

```sh
ffmpeg -re -f lavfi -i testsrc=size=1280x720:rate=30 -re -f lavfi -i sine=frequency=1000:sample_rate=44100 -c:v libx264 -preset ultrafast -pix_fmt yuv420p -c:a aac -b:a 96k -f mpegts udp://127.0.0.1:5000
```

Open the score and start playback. Run a receiver for its processed output:

```sh
ffplay udp://127.0.0.1:5001
```

Change Color Controls brightness or saturation: only the receiver's image changes. Then change the LFO driving Hyperspace: only the local window changes.

The saved output is video-only: MJPEG encoding with the MJPEG muxer at 1280×720, 30 fps. It is not MPEG-TS like the test input, and the test tone is not forwarded. Stop the external sender and receiver when finished.

{% include try-on-web.html %}

[Download this example]({{ site.scores }}{{ page.score }})
