---
layout: default
title: DBAP speaker gains and paths
description: "Generate distance-based gains for a moving source in a four-speaker layout."
parent: Spatial audio techniques
grand_parent: Common practices
nav_exclude: true
permalink: /common-practices/sound-spatialization/spat-example-dbap.html
score: /common-practices/sound-spatialization/spat-example-dbap.score
---

# DBAP speaker gains and paths

![Speaker positions and DBAP gains feeding Matrix spatialization, alongside the audio effects chain and RMS traces.]({{ site.baseurl }}/assets/scores/thumbnails/common-practices-sound-spatialization-spat-example-dbap.png)

Generate distance-based gains for a moving source in a four-speaker layout.

[Download the example]({{ site.baseurl }}/assets/scores/common-practices/sound-spatialization/spat-example-dbap.score)

{% include try-on-web.html %}

## Setup and run

Use score with the GBAP spatialization add-on (Multi-Cursor Manager, PathGenerator and Matrix spatialization), Faust and Airwindows. The sound source is the default-library `Media/drums/kit1/Ride Cymbal.wav`; install the default media package or replace that Sound file with your own source.

Start playback. Multi-Cursor Manager defines four speakers near the corners of a normalized square. PathGenerator moves a source diagonally between approximately `[0.964,0.024]` and `[0.038,0.963]`, with Ping Pong enabled. Array Flattener converts the path output for DBAP's Source input. The two Point2D Views show the speaker layout and moving position.

DBAP is saved with Blur 0.5 and Roll-off about 21.226. Its gain output drives both Matrix spatialization's Weights and LED View in Lightness01 mode. Move a speaker or change the path and watch the distribution change; higher or lower roll-off changes how strongly distance affects the gains.

## Audio routing

The looping cymbal passes through smoothDelay, pitchShifter and Airwindows Lowpass2 before Matrix spatialization, which is configured for four outputs. An LFO and `30+2x` Micromap modulate delay time. Matrix output is connected to RMS and a Signal display for monitoring; the saved graph does not route that outlet to the parent audio mix.

To hear the spatialized result, explicitly route Matrix spatialization's audio outlet to four hardware outputs in your speaker order. A stereo output cannot reproduce the four-speaker layout. Start at low gain: smoothDelay's saved feedback is about 99.8%. Without this routing you can still study the position, gain and RMS displays; the document is not a ready-made device configuration.
