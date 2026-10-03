---
layout: default
title: "Audio recorder"
description: "Record an audio bus to a WAV file"
parent: Processes
grand_parent: Reference
permalink: /processes/audio-recorder.html
---

# Audio recorder

Connect an audio bus to **Audio**, set **File pattern**, and enable **Record** while the process is executing. Disable Record to close the recording; **Filename** emits the actual saved path after a nonempty recording is closed.

The recorder writes 16-bit WAV audio at the engine sample rate, preserving the input channel count. Keep the channel count stable during a take: changing it reopens the file. This is an audio recorder, not a recorder for device values.

Use `%t` in File pattern for the current UTC date/time (colons are replaced with underscores), or `%n` for an available numbered filename. For example, use a writable path ending in `take-%n.wav` to keep separate takes. Number selection checks the resolved destination directory. A fixed filename can be overwritten on a later recording.

For parameter recording and replay, use the [CSV recorder]({{ site.baseurl }}/processes/csv-recorder.html).
