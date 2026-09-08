---
layout: default

title: LTC Generator
description: "Generate SMPTE Linear Timecode as an audio signal"

parent: Processes
grand_parent: Reference

permalink: /processes/ltc-generator.html
---
# LTC Generator

<!-- TODO screenshot: ![LTC Generator]({{ site.img }}/reference/processes/ltc-generator.png "LTC Generator") -->

Generates [SMPTE Linear Timecode (LTC)](https://en.wikipedia.org/wiki/Linear_timecode) as
an audio signal, following score's transport position. Route the output to an audio device
to synchronise external gear (recorders, lighting desks, DAWs) to your score.

## Offset

A time offset, in seconds, added to the generated timecode. Use it to align the emitted
timecode with an external reference.

## Framerate

The timecode frame rate:

* **525** — 30 fps (NTSC).
* **625** — 25 fps (PAL).
* **1125** — 30 fps (HD).
* **Film** — 24 fps.

## Output

A single audio channel carrying the LTC signal. See also [LTC Input](ltc-input.html) for
decoding incoming timecode.
