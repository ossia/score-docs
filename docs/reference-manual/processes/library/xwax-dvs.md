---
layout: default

title: XWax DVS
description: "Decode digital vinyl system (DVS) timecode from turntables"

parent: Processes
grand_parent: Reference

permalink: /processes/xwax-dvs.html
---
# XWax DVS

<!-- TODO screenshot: ![XWax DVS]({{ site.img }}/reference/processes/xwax-dvs.png "XWax DVS") -->

Decodes [Digital Vinyl System (DVS)](https://en.wikipedia.org/wiki/Vinyl_emulation)
timecode from a turntable or CDJ feeding control-tone audio, using the
[xwax](https://xwax.org/) decoder. This turns a real turntable into a controller: the
decoded position and speed can scrub and pitch any time-based process in score.

## Audio input

A stereo audio bus carrying the timecode control tone from the deck.

## Vinyl type

The control-vinyl format to decode: **Serato**, **Traktor**, **MixVibes** or **Pioneer**.

## Speed

Nominal turntable speed: **33** or **45** RPM.

## Pitch filter

Smoothing applied to the recovered pitch, trading responsiveness for stability.

## Lead-in time / Tempo

Lead-in handling and reference tempo for the decoded transport.

## Output format

How the decoded position is presented on the **Timecode** output.

## Outputs

* **Timecode** — decoded position.
* **Raw timecode** — undecoded raw value.
* **Speed / Pitch** — playback speed and pitch deviation.
* **Tempo** — derived tempo.
* **Quality** — decode confidence, 0 to 1.
* **Valid** — whether a usable signal is present.
