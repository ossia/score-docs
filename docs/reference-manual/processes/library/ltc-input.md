---
layout: default

title: LTC Input
description: "Decode SMPTE Linear Timecode from an audio signal"

parent: Processes
grand_parent: Reference

permalink: /processes/ltc-input.html
---
# LTC Input

<!-- TODO screenshot: ![LTC Input]({{ site.img }}/reference/processes/ltc-input.png "LTC Input") -->

Decodes [SMPTE Linear Timecode (LTC)](https://en.wikipedia.org/wiki/Linear_timecode) from
an incoming audio signal, letting score follow an external timecode source. Feed it the
audio channel carrying the LTC and read the decoded position from its outputs.

## LTC audio

The audio channel carrying the incoming LTC signal.

## Offset

A time offset, in seconds, applied to the decoded timecode.

## Output format

How the decoded timecode is presented on the **Timecode** output (e.g. seconds vs.
HH:MM:SS:FF string).

## Framerate

Expected frame rate of the incoming timecode (must match the source).

## Queue size

Internal decoding buffer size; larger values are more robust but add latency.

## Outputs

* **Timecode** — the decoded position.
* **Valid** — whether a valid signal is currently being decoded.
* **Frame rate** — detected frame rate.
* **Drop frame** — drop-frame flag.
* **Reverse** — set when the source is playing backwards.
* **Volume** — input signal level.

See also [LTC Generator](ltc-generator.html).
