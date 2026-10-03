---
layout: default
title: LTC Input
description: "Decode audio LTC into numeric time and signal-status values"
parent: Processes
grand_parent: Reference
permalink: /processes/ltc-input.html
---

# LTC Input

**LTC Input** decodes a mono linear-timecode audio signal. It is provided by the optional LTC add-on. Route a dedicated audio input, or [[LTC Generator]], to **LTC Audio**.

## Controls

| Control | Meaning |
|---|---|
| Offset (s) | Integer seconds added to the decoded time, from -128000 to 128000; default 0. |
| Output Format | Seconds (default), Milliseconds, Microseconds, Nanoseconds or Flicks. |
| Framerate | Auto (default), 24, 25, 29.97 or 30 fps. |
| Queue Size | Decoder queue capacity, 8–256, default 32. Changing it recreates the decoder. |

**Queue Size** is not a promised latency setting or a guarantee against bad signals. The process drains the decoder queue each call and reports the most recent decoded frame.

## Outputs

| Output | Type and units |
|---|---|
| Timecode | Floating-point numeric time in the selected **Output Format**, including the offset. It is not an `HH:MM:SS:FF` string. |
| Valid | Boolean indicating a decoded frame has been received recently. |
| Frame Rate | Numeric frame rate used to convert the frame field to fractional seconds. |
| Drop Frame | Boolean copied from the incoming frame's drop-frame flag. |
| Reverse | Boolean indicating reverse decoding. |
| Volume (dBFS) | Level reported for the decoded frame, in dBFS. |

One second is 1000 milliseconds, 1000000 microseconds, 1000000000 nanoseconds or **705600000 flicks**. The decoder computes `hours × 3600 + minutes × 60 + seconds + frame / fps + offset` before unit conversion. The drop-frame flag is exposed separately; this process does not perform an additional dropped-frame-count correction to that formula.

## Frame-rate and validity limitations

**Auto** is a per-frame heuristic, not a measured-rate lock. It uses the drop-frame bit and the current frame number: without the drop-frame bit, frame numbers below 24 are treated as 24 fps, 24 as 25 fps, and 25 or higher as 30 fps. It can therefore change its reported rate within one second of incoming code. Select an explicit rate when the source rate is known.

After more than **500 ms** without a decoded frame, **Valid** becomes false while processing continues. Other outputs can retain their last decoded values. Gate downstream use of **Timecode** with **Valid** instead of assuming a nonzero number means a live signal.

The outputs are ordinary control values. They do **not** automatically slave score's transport, seek the document or set its tempo. Any mapping from external timecode to application behavior must be configured separately.
